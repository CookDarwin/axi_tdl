module TdlSimTest
    # class TopModuleSimX 
        
    #     def initialize
    #         ## 工程文件引入一开始，必须先引入测试项文件，然后再是其他工程 sdl hdl文件
    #         ## 测试项
    #         @sim_targets = []

    #         ## 工程能提供的测试用例
    #         @top_sim_table = []
    #     end

    # end

    class TdlBaseTestUnit
        attr_accessor :value_default,:active
        def initialize(name,active=false)
            @active = active
            TdlBaseTestUnit.check_same_test_name(name)
        end

        def value
            if @sim_target != true 
                return @sim_target || @value_default
            else 
                return @value_default
            end
        end

        def use_default?
            if @value_default && !@sim_target
                return true 
            else
                return false 
            end
        end

        private 

        def active_symb
            @active ? 'Y' : ''
        end
        public
        ## 工程文件引入一开始，必须先引入测试项文件，然后再是其他工程 sdl hdl文件
        ## 测试项
        @@test_unit_hash = {}

        ## 工程能提供的测试用例
        @@top_sim_list = []

        def self.top_sim_list
            @@top_sim_list
        end 

        def self.top_sim_list=(a)
            @@top_sim_list = a 
        end

        def self.load_test_unit_hash(hash)   ## KEY -> VALUE
            @@test_unit_hash = hash
        end

        def self.test_unit_hash 
            @@test_unit_hash || {}
        end

        def self.test_unit_hash=(a)
            _hash_ = {}
            a.each do |k,v|
                _hash_[k] = v 
                _hash_[k.to_s] = v 
                _hash_[k.to_s.to_sym] = v 
            end
            @@test_unit_hash  = _hash_
        end

        def self.check_same_test_name(name)
            @@_same_test_name_collect_ ||= []
            if @@_same_test_name_collect_.include? name.to_s 
                raise TdlError.new "cant define same test name<#{name}>"
            end
            @@_same_test_name_collect_ << name.to_s
        end

        ## 用于终端打印
        def self.echo_prj_test_list
            # type_list = []
            # name_list = []
            # value_list = []
            # default_list = []
            # other_list = []
            # ttl = 0
            # nnl = 0
            # vvl = 0
            # ddl = 0
            info_x = [ ['TYPE'],['NAME'],['ACTIVE'],['VALUE'],['DEFAULT'],['OTHERS'] ] 
            len_x = [7]  * 6
            @@top_sim_list.each do |e|
                rels = e.echo_info_array
                rels.each_index do |index|
                    info_x[index] << rels[index].to_s 
                    len_x[index]  = (rels[index].to_s.length > len_x[index] ) ? rels[index].to_s.length : len_x[index]
                end
            end
            collect_str = []
            info_x[0].each_index do |index|
                sub_collect_str = []
                6.times do |xx|
                    if xx != 5
                        sub_collect_str << "  #{info_x[xx][index]} #{' '*(len_x[xx]+4- info_x[xx][index].size) }"
                    else
                        sub_collect_str << "  #{info_x[xx][index]}"
                    end
                end

                collect_str << sub_collect_str.join('|')
            end
            collect_str.join("\n")+"\n---\n  Total: #{@@top_sim_list.length}\n"
        end

    end

    class TdlSimpleTestUnit < TdlBaseTestUnit

        def initialize(name: 'TdlSimpleTestUnit-0',value_default: nil, sim_target_hash: {})
            super name
            @name = name 
            @value_default = value_default
            @sim_target = sim_target_hash[name]
            if @sim_target 
                @active = true 
            end
        end

        def value
            if @sim_target != true 
                return @sim_target || @value_default
            else 
                return @value_default
            end
        end

        def echo_info_array
            # test type :: test name :: test value :: test default ? :: tset others
            ['SIMPLE-UNIT',@name,active_symb,value().to_s, use_default?().to_s, "default(#{@value_default})" ] 
        end
    
        def echo_info 
            echo_info_array.join(" ## ")
        end

    end

    class TdlSelTestUnit < TdlBaseTestUnit
        def initialize(name: 'TdlSelTestUnit-0',sel_range: [],value_default: nil, sim_target_hash: nil)
            super name
            @name = name 
            @sel_range = sel_range
            if value_default
                unless sel_range.include? value_default
                    raise TdlError.new "DEFAULT:: #{value_default} not in range[#{sel_range.map{|e| e.to_s }.join(",")}]"
                end
            end
            @value_default = value_default
            @sim_target = sim_target_hash[name]
            
            if @sim_target
                @active = true
                unless sel_range.include? @sim_target
                    if @sim_target != true
                        raise TdlError.new " SIM TARGET:: #{@sim_target} not in range[#{sel_range.map{|e| e.to_s }.join(",")}]"
                    end
                end
            end
        end

        def echo_info_array
            # test type :: test name :: test value :: test default ? :: tset others
            ['SEL-UNIT',@name,active_symb,value(), use_default?(), @sel_range.map{|e| e.to_s }.join(",") ] 
        end

        def echo_info 
            echo_info_array.map{ |e| e.to_s }.join(" ## ")
        end
    end

    class TdlNumTestUnit < TdlBaseTestUnit
        def initialize(name: 'TdlNumTestUnit-0',value_default: nil, sim_target_hash: nil)
            super name
            @name = name 
            @value_default = value_default
            @sim_target = sim_target_hash[name]
            @active = true if @sim_target
        end

        def echo_info_array
            # test type :: test name :: test value :: test default ? :: tset others
            ['NUM-UNIT',@name,active_symb,value().to_s, use_default?().to_s, "default(#{@value_default})" ] 
        end
    
        def echo_info 
            echo_info_array.join(" ## ")
        end

    end

    class TdlHashTestUnit < TdlBaseTestUnit
        def initialize(name: 'TdlNumTestUnit-0',value_default: {}, sim_target_hash: {})
            super name
            @name = name 
            @value_default = {} 
            value_default.each do |k,v|
                @value_default[k] = v
                @value_default[k.to_s] = v
                @value_default[k.to_s.to_sym] = v
            end

            @sim_target = {}
            if sim_target_hash[name].is_a? Hash
                @active = true
                sim_target_hash[name].each do |k,v|
                    @sim_target[k] = v
                    @sim_target[k.to_s] = v
                    @sim_target[k.to_s.to_sym] = v
                end
            elsif sim_target_hash[name] == true 
                @active = true
            end
        end


        def value
            return  @value_default.merge @sim_target
        end

        def echo_info_array
            # test type :: test name :: test value :: test default ? :: tset others
            def_str = []
            @value_default.each do |k,v|
                def_str << "#{k}:#{v}" if k.is_a?(String)
            end

            value_str = []

            value().each do |k,v|
                value_str << "#{k}:#{v}" if v != @value_default[k] && k.is_a?(String)
            end
            if value_str.any?
                value_str = value_str.join(', ')
            else
                value_str = 'default'
            end

            ['HASH-UNIT',@name,active_symb,value_str, use_default?().to_s, "default(#{def_str.join(", ")})" ] 
        end
    
        def echo_info 
            echo_info_array.join(" ## ")
        end

    end

    ## 用于定义语法糖

    class SdlSimpleTestDefSuger
        def initialize(value_default: nil)
            @value_default = value_default
        end

        def -(name)
            rel = TdlSimTest::TdlSimpleTestUnit.new(name: name,value_default: @value_default, sim_target_hash: TdlBaseTestUnit.test_unit_hash)
            TdlBaseTestUnit.top_sim_list << rel 
            TdlSimTest.define_singleton_method(name) do 
                return rel 
            end
            return rel
        end

    end

    class SdlSelTestDefSuger
        def initialize(sel_range: [],value_default: nil)
            @sel_range = sel_range
            @value_default = value_default
        end

        def -(name)
            rel = TdlSimTest::TdlSelTestUnit.new(name: name,sel_range: @sel_range, value_default: @value_default, sim_target_hash: TdlBaseTestUnit.test_unit_hash)
            TdlBaseTestUnit.top_sim_list << rel 

            TdlSimTest.define_singleton_method(name) do 
                return rel 
            end
            return rel
        end
    end

    class SdlNumTestDefSuger
        def initialize(value_default: nil)
            @value_default = value_default
        end

        def -(name)
            rel = TdlSimTest::TdlNumTestUnit.new(name: name,value_default: @value_default, sim_target_hash: TdlBaseTestUnit.test_unit_hash)
            TdlBaseTestUnit.top_sim_list << rel 
            TdlSimTest.define_singleton_method(name) do 
                return rel 
            end
            return rel
        end

    end

    class SdlHashTestDefSuger
        def initialize(value_default: {})
            @value_default = value_default
        end

        def -(name)
            rel = TdlSimTest::TdlHashTestUnit.new(name: name,value_default: @value_default, sim_target_hash: TdlBaseTestUnit.test_unit_hash)
            TdlBaseTestUnit.top_sim_list << rel 
            TdlSimTest.define_singleton_method(name) do 
                return rel 
            end
            return rel
        end

    end

end

class TopModule 
    def sim_test_hash=(hash)
        return nil unless TopModule.sim
        rel = TdlSimTest::TdlBaseTestUnit.test_unit_hash || {}
        TdlSimTest::TdlBaseTestUnit.test_unit_hash = rel.merge(hash)
        return TdlSimTest::TdlBaseTestUnit.test_unit_hash
    end

    def sim_test_hash
        TdlSimTest::TdlBaseTestUnit.test_unit_hash
    end
end

## 定义 sdlmoudle 里面 如何添加测试方法

# class SdlMoudle
    
#     def def_sdl_sel_test(sel_range: [],value_default: nil)
#         TdlSpace::SdlSelTestDefSuger.new(sel_range: sel_range,value_default:value_default)
#     end

#     def def_sdl_num_test(value_default=nil)
#         TdlSpace::SdlNumTestDefSuger.new(value_default: value_default)
#     end
    
# end

module TdlSimTest
    def self.def_sel(sel_range: [],value_default: nil)
        TdlSimTest::SdlSelTestDefSuger.new(sel_range: sel_range,value_default:value_default)
    end

    def self.def_num(value_default=nil)
        TdlSimTest::SdlNumTestDefSuger.new(value_default: value_default)
    end

    def self.def_hash(hash)
        TdlSimTest::SdlHashTestDefSuger.new(value_default: hash || {})
    end

    def self.def_simple(value_default=nil)
        TdlSimTest::SdlSimpleTestDefSuger.new(value_default: value_default)
    end
end