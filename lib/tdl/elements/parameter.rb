
# require_relative "./tdlerror"
# require_relative "./basefunc"

class Parameter < BaseElm
    include BaseModule
    attr_accessor :name,:value,:id,:ghost,:type,:vcs_string

    def initialize(name: "P",value:100,local:false,port:false,show:true,type:nil)
        @name = name
        @local = local
        # @id = GlobalParam.CurrTdlModule.BindEleClassVars.Parameter.id
        @port = port
        @show = show
        @value = value
        @type = type
        # if @port
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Parameter.ports << self
        # else
        #     GlobalParam.CurrTdlModule.BindEleClassVars.Parameter.inst_stack << method(:inst)
        # end
    end

    def inst
        return "" if @ghost
        unless @local
            "parameter #{@type.to_s} #{@name}   = #{align_signal(@value)};"
        else
            "localparam #{@type.to_s} #{@name}  = #{align_signal(@value)};"
        end
    end

    # def signal
    #     if @port
    #         "#{@name}"
    #     else
    #         "#{@name}_#{@id}"
    #     end
    # end

    def [](a,b=nil)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
        end

        if b
            sqstr = "[#{a.to_s}:#{b.to_s}]"
        else
            sqstr = "[#{a.to_s}]"
        end
        signal.concat sqstr
    end

    def port_length
        ("parameter" + " #{@type.to_s} " + @name.to_s + " ").length
    end

    def inst_port(align_len = 7)
        unless @show
            show_str = "//(* show = \"false\" *)\n    "
        else
            show_str = ""
        end
        if @port
            unless vcs_string
                with_new_align(0) do
                    show_str + ("parameter" + " #{@type.to_s} " + @name.to_s + " " + " "*align_len + "= #{align_signal(@value)}")
                end
            else 
                with_new_align(0) do
                    show_str + ("`parameter_longstring(#{vcs_string}) " + @name.to_s + " " + " "*align_len + "= #{align_signal(@value)}")
                end
            end
        end
    end

    # def self.inst
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Parameter.inst_stack.map { |e| e.call }.join("")
    # end

    # def self.clear
    #     @@id = 0
    #     @@inst_stack = ""
    #     @@ports = []
    # end

### parse text for autogen method and constant ###

    def self.parse_params(parameter_str)
        if parameter_str.nil? || parameter_str.strip.empty?
            return nil
        end
        params = []
        parameter_str = parameter_str.gsub(/\/\/.*$/,'')
        if parameter_str && !parameter_str.strip.empty?
            params = parameter_str.split(/,\s*$/).map do |e|
                me = e.match(/(?<vcs>parameter|parameter_string|parameter_longstring)(\(\d+\))?\s*(\[.*?\]|\s+|real|bit|string|longint)\s*(?<name>\w+)\s*=\s*(?<value>.*)/)
                # me = e.match(/(?<vcs>parameter|parameter_string)\s*(\[.*?\]|\s+|real|bit|string|longint)\s*(?<name>\w+)\s*=\s*(?<value>.*)/)
                # me_value = me["value"].downcase
                next unless me
                me_value = me["value"]
                ex_me = e.match(/\(\*\s*show\s*=\s*"false"\s*\*\)/)
                if me && !ex_me
                    h = Hash.new
                    h[:type] = Parameter
                    me_integer = me_value.match(/^\s*\d+\s*$/)
                    me_mth0 = me_value.match(/["](?<str_name>.+?)["]/)
                    me_mth3 = me_value.match(/\$clog2/)
                    me_mth4 = me_value.match(/^[A-Z]([A-Z]|[0-9]|\+|-|\*|\/|%|_)+[A-Z0-9]$/)
                    me_mth2 = me_value.match(/(?<bit_name>^\d+$|^\d+(=|-|\*|\/){1,2}\d+)/i)
                    me_mth1 = me_value.match(/(?<bit_name>\d*'(h|d|b|sh|sd|sb)\w+|^\d+$|\d+(=|-|\*|\/){1,2}\d+)/i)
                    me_mth5 = me_value.match(/\{.+\}/)
                    if me_value
                        h[:name] = me["name"].downcase
                        h[:origin_name] = me["name"]
                        if me_mth5
                            h[:value]   = "NqString.new(\"#{me_value}\")"
                        elsif me_integer
                            h[:value]   = me_value
                        elsif me_mth0
                            h[:value]   = '"'+me_mth0["str_name"]+'"'
                        elsif me_mth2
                            h[:value]   = me_mth1["bit_name"]
                        elsif me_mth1
                            h[:value]   = '"'+me_mth1["bit_name"]+'"'
                        elsif me_mth3
                            h[:value]   = "NqString.new('#{me_value}')"
                        elsif me_mth4
                            h[:value]   = "NqString.new('#{me_value}')"
                        else
                            h[:value]   = '"'+me_value.strip+'"'
                        end
                    end

                    h[:port_len]  = h[:origin_name].length
                    # h[:type] = Parameter

                    h[:inst_ex_port] = lambda { |ml|
                        if ml+4 >= h[:origin_name].length
                            ll = ml+4 - h[:origin_name].length
                        else
                            ll = 1
                        end

                        "    .#{h[:origin_name]}"+" "*(ll)+"(\#{align_signal(#{h[:name]})})"
                    }

                    yield h

                    h
                else
                    nil
                end
            end
        end
        params.compact
    end


end

class Parameter # add +

    OP_SYMBOLS = %w{+ - * / % > < >= <= == != <<}

    OP_SYMBOLS.each do |s|
        define_method(s) do |a|
            operation_tow(s,a)
        end
    end

    private
        def operation_tow(symb,a)
            # return NqString.new(align_signal(signal,q_mark=false).concat("#{symb}").concat(align_signal(a,q_mark=false)))
            # return NqString.new(signal.concat("#{symb}").concat(a.to_s))

            unless a.instance_of? String
                rel =  NqString.new(signal.concat("#{symb}").concat(a.to_s))
            else  
                rel = NqString.new(signal.concat("#{symb}").concat('"').concat(a.to_s)).concat('"')
            end
            new_op = ClassHDL::OpertorChain.new(nil,belong_to_module) 
            new_op.tree.push([rel])

            return new_op
        end

    public

    def clog2
        return "$clog2(#{signal})".to_nq
    end
    
    def cmod(x)
        ## 返回最小整数使得 self 小于等于 x*rel 
        return "#{signal}/#{x}+(#{signal}%#{x}!=0)".to_nq
    end

end

class GenInnerStr < String
end

$generate_tap_igt = 0

class Parameter     # add generator

    def generator(&block)
        with_tap_id do
            tmp_sm = GenBlockModule.new(name:"#{belong_to_module.module_name}_#{name}_generator_tmp_top_#{pg_id}",belong_to_module:belong_to_module)
            gstr = yield("#{name}_KK".to_nq,tmp_sm)  # KK, str_collect

            str = ""

            if gstr.is_a? GenInnerStr
                str += gstr
            end

            str += (tmp_sm.instance_draw + tmp_sm.vars_exec_inst)
            # belong_to_module.Logic_inst << tmp_sm.vars_define_inst
            belong_to_module.Logic_draw << generator_block(str)
        end
    end

    private

    def generator_block(str)

"
generate
for(#{name}_KK=0;#{name}_KK<#{name};#{name}_KK++)begin:#{name}_GENERATOR_BLOCK_#{pg_id}
#{str}
end
endgenerate
"
    end

    def with_tap_id(&block)
        $generate_tap_igt += 1
        str = yield
        $generate_tap_igt -= 1
        str
    end

    def pg_id
        @_pg_id ||= 0
        belong_to_module.Logic_draw << "genvar  #{name}_KK;\n" if @_pg_id.eql?(0)
        _tmp_id = @_pg_id
        @_pg_id += 1
        _tmp_id
    end

    def times_id
        @_pt_id ||= 0
        belong_to_module.Logic_draw << "int  #{name}_KK;\n" if @_pt_id.eql?(0)
        _tmp_id = @_pt_id
        @_pt_id += 1
        _tmp_id
    end

    public

    def generator_times(&block)     # for .. for ..
        with_tap_id do
            str = times(pg_id,&block)
            GenInnerStr.new(str)
        end
    end

    def always_times(&block)
        with_tap_id do
            str = times(pt_id,&block)
            GenInnerStr.new(str)
        end
    end

    private

    def times(tid,&block)

        tmp_sm = GenBlockModule.new(name:"#{belong_to_module.module_name}_#{name}_generator_tmp_#{tid}",belong_to_module:belong_to_module)

        gstr = yield("#{name}_KK".to_nq,tmp_sm)  # KK, str_collect

        str = ""

        if gstr.is_a? GenInnerStr
            str += gstr
        end

        str += (tmp_sm.instance_draw + tmp_sm.vars_exec_inst)
        # belong_to_module.Logic_inst << tmp_sm.vars_define_inst
        rel =  times_draw(tid,str)

    end

    def times_draw(tid,str)
"#{'    '*$generate_tap_igt}for(#{name}_KK=0;#{name}_KK<#{name};#{name}_KK++)begin:#{name}_GENERATOR_BLOCK_#{tid}
#{'    '*$generate_tap_igt}#{str}
#{'    '*$generate_tap_igt}end"
    end

end

class Parameter

    def eql?(a)
        if a.is_a? Parameter
            self.value.eql? a.value
        else
            self.value.eql? a
        end
    end
end
