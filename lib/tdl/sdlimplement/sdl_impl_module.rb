
class SdlImplModule
    @@_impl_ms_ = {}
    attr_reader :class_name,:nickname,:info,:path,:pins_map,:key_name,:real_require
    def initialize(key_name,hash)
        # @class_name = class_name
        @key_name = key_name
        parse_name(key_name)
        @info   = hash['info']
        @path   = hash['path']
        @pins_map = hash['pins_map'].to_sym if hash['pins_map']
        @req_modules = hash['require'] || {}
        @mutual_moduls = hash['matual'] || {}

        %w{ info path pins_map require matual}.each {|e| hash.delete(e) }
        gen_other_attr(hash)

        @@_impl_ms_[key_name] = self
        @real_require = {}
    end

    def common_argvs
        [:nickname,:pins_map]
    end

    def gen_other_attr(hash)
        obj = Object.new
        define_singleton_method("other") do
            obj
        end

        keys = hash.keys

        obj.define_singleton_method("keys") do
            keys
        end

        hash.each do |k,v|
            obj.define_singleton_method(k) do
                v
            end
        end
    end

    def parse_name(key_name)
        rep0 = /(?<class>\w+)/
        rep1 = /(?<class>\w+)\(\s*\)/
        rep2 = /(?<class>\w+)\((?<nickname>\w+)\)/

        if rep2.match key_name
            @class_name = $~[:class]
            @nickname   = $~[:nickname]
        elsif rep1.match key_name
            @class_name = $~[:class]
            @nickname   = nil
        elsif rep0.match key_name
            @class_name = $~[:class]
            @nickname   = nil
        else
            raise TdlError.new("SdlImplModule KEY_NAME PARSE ERROR [#{key_name.to_s}]")
        end
    end

    # def parse_requires(req_hash)
    #
    # end

    # def self.impl_ms_keys_cont(key)
    #     if @@_impl_ms_.keys.include? key
    #         return key
    #     elsif @@_impl_ms_.keys.map { |e| e.sub(/\(\w*\)/,"" ) }.include? key
    #         return @@_impl_ms_.keys.select { |e|  e.include? key }[0]
    #     else
    #         return false
    #     end
    # end

    def dependent(sure:false,pool:[])
        dep_array = []

        @req_modules.each do |k,v|
            unless v.is_a? Array
                ov = SdlImplModule.modules_hash(v)
                if ov
                    # dep_array << ov
                    dep_array << [ov,ov.dependent(sure:sure,pool:pool)]
                else
                    raise TdlError.new("Module[#{@class_name}] depend on [#{v}] but [#{v}] dont exist !!!!")
                end
                @real_require[k]    = ov unless @real_require.include? ov
            else
                # dep_array << v
                next if sure

                if pool.empty?
                    mutual_hash = {}
                    v.each_index do |index|
                        mutual_hash["k##{index}"] = v[index]
                    end
                    ov = SdlImplModule.new("#mutual#",{'require' => mutual_hash })
                    dep_array << [ov,ov.dependent(sure:sure,pool:pool)]

                else
                    in_pool = false
                    v.each do |vv|
                        ov = SdlImplModule.modules_hash(vv)
                        if pool.include? ov
                            dep_array << [ov,ov.dependent(sure:sure,pool:pool)]
                            in_pool = true
                            break
                        end
                    end

                    unless in_pool
                        ov = SdlImplModule.modules_hash(v[0])
                        dep_array << [ov,ov.dependent(sure:sure,pool:pool)]
                    end

                    @real_require[k]    = ov    unless @real_require.include? ov
                end
            end
        end
        # raise TdlError.new("SdlImplModule[#{key_name}] cant dependent itself !!!") if dep_array.flatten.include? self

        return dep_array
    end

    def self.modules_hash(module_origin_str)
        if @@_impl_ms_.keys.include? module_origin_str
            @@_impl_ms_[module_origin_str]
        elsif @@_impl_ms_.keys.map { |e| e.sub(/\(\w*\)/,"" ) }.include?(module_origin_str) || @@_impl_ms_.keys.map { |e| e.sub(/\(\w*\)/,"" ) }.include?(module_origin_str.sub(/\(\s*\)/,""))
            @@_impl_ms_[ @@_impl_ms_.keys.select { |e|  e.include? module_origin_str }[0] ]
        else
            # puts module_origin_str
            return nil
        end
    end

    def self.inspect_dependent_verb(level_len,dep_array)
        str = ""
        dep_array.each do |e_array|
            str += " "*level_len + (e_array[0].key_name).to_s + " -> \n"
            if e_array[1].any?
                str += self.inspect_dependent_verb(level_len+((e_array[0].key_name).to_s.length)+4,e_array[1])
            else
                str.chop!
                str += "[]\n"
            end
        end
        str
    end

    def self.inspect_dependent(level_len,dep_array)
        str = ""
        dep_array.each do |e_array|
            str += " "*level_len + (e_array[0].key_name).to_s + ":\n"

            str += " "*level_len + (e_array[0].key_name).to_s + ":\n"
            if e_array[1].any?
                str += self.inspect_dependent(level_len+4,e_array[1])
            else
                str.chop!
                str += " ~\n"
            end
        end
        str
    end

    #### ---------  implement top  ------------------

    def self.implement(modules,tbs)
        ma  = []
        modules.each do |m|
            ma << self.modules_hash(m)
            ma << m.dependent.flatten
        end
        ma = ma.uniq

    end

    # def self.


end

class SdlTopImplement
    attr_reader :top_module

    def initialize(top_name,out_sv_path,need_modules,tbs,implparams,pins_yaml)
        @pins_yaml = TopModule.load_ppins(pins_yaml) if pins_yaml
        @tbs = tbs || []
        @implparams = implparams
        @out_sv_path = out_sv_path

        @top_module = TopModule.new(name: top_name,out_sv_path: out_sv_path)


        @_sure_array_ = []
        need_modules.each do |m|
            inspect_dependent(m)
            rel = SdlImplModule.modules_hash(m)
            @_sure_array_ << rel.dependent(sure:true) if rel
        end

        @_sure_array_ = @_sure_array_.flatten

        @module_pool = []

        need_modules.each do |m|
            rel = SdlImplModule.modules_hash(m)
            @module_pool << rel
            @module_pool << rel.dependent(sure:false,pool: @_sure_array_) if rel
        end

        @module_pool.flatten!
        @module_pool = @module_pool.uniq
        ## implement
        need_modules.each do |m|
            instance_itgt_module SdlImplModule.modules_hash(m)
        end

        # @top_module.gen_sv_module
        inspect_pool
    end

    def inspect_pool
        Dir.mkdir(File.join(@out_sv_path,"/inspect/")) unless File.exist? File.join(@out_sv_path,"/inspect/")
        File.open(File.join(@out_sv_path,"/inspect/","#{@top_module.module_name}_include.txt"),'w') do |f|
            f.puts @module_pool.map { |e|  e.key_name }.join("\n")
        end
    end

    def inspect_dependent(impl_module_str)
        md = SdlImplModule.modules_hash(impl_module_str)
        sure_array = md.dependent(sure:true)

        use_array = md.dependent(sure:false,pool: sure_array.flatten )

        dep_array = SdlImplModule.inspect_dependent_verb(0,use_array)

        Dir.mkdir(File.join(@out_sv_path,"/inspect/")) unless File.exist? File.join(@out_sv_path,"/inspect/")
        Dir.mkdir(File.join(@out_sv_path,"/inspect/dependent/")) unless File.exist? File.join(@out_sv_path,"/inspect/dependent/")
        File.open(File.join(@out_sv_path,"/inspect/dependent/","#{md.class_name}.txt"),'w') do |f|
            f.puts dep_array
        end
    end

    def pool_hash(name_str,nickname=nil)
        @module_pool.select do |e|
            if nickname
                e.classname == name_str && e.nickname == nickname
            else
                e.classname == name_str
            end
        end[0]
    end


    def instance_itgt_module(impl_module)
        ## check define
        if impl_module.nickname
            str = "itgt_#{impl_module.class_name}_#{impl_module.nickname}"
        else
            str = "itgt_#{impl_module.class_name}"
        end

        if respond_to?(str)
            return send(str)
        end

        unless File.exist? impl_module.path
            raise TdlError.new("Implemet Module[#{impl_module.key_name}] Path[#{impl_module.path}] dont exist !!!")
        end
        require_relative(impl_module.path)


        argv_hash = {}

        impl_module.common_argvs.each do |ca|
            rel = impl_module.send(ca)
            if (ca.to_sym == :pins_map) && rel
                argv_hash[ca.to_sym] = @pins_yaml[rel]
            elsif rel
                argv_hash[ca.to_sym] = rel
            end
        end

        impl_module.real_require.each do |k,rel|
            if @module_pool.include? rel
                argv_hash[k.to_sym] = instance_itgt_module(rel)
            else
                TdlError.new("#{rel.key_name} is not in module_pool !!!")
            end
        end

        argv_hash[:top_module]  = @top_module

        if @tbs.include?(impl_module.key_name)
            argv_hash[:tb]          = true
        end

        ## other attr
        other_rep0 = /params-yaml-(?<name>.+)/
        other_rep1 = /params-var-(?<name>.+)/

        impl_module.other.keys.each do |k|
            rel = impl_module.other.send(k)
            if other_rep0.match(rel.to_s) || other_rep1.match(rel.to_s)
                argv_hash[k.to_sym] =  @implparams.send($~[:name])
            else
                argv_hash[k.to_sym] = rel
            end
        end


        ## define itgt methods
        target_class = eval("#{impl_module.class_name}")
        inspect_sdl(target_class,argv_hash)

        _inst_ = target_class.send(:new,argv_hash)

        define_singleton_method(str) do
            _inst_
        end

        return _inst_

    end

    def inspect_sdl(target_class,argv_hash)
        Dir.mkdir(File.join(@out_sv_path,"/inspect/")) unless File.exist? File.join(@out_sv_path,"/inspect/")
        Dir.mkdir(File.join(@out_sv_path,"/inspect/sdl_example/")) unless File.exist? File.join(@out_sv_path,"/inspect/sdl_example/")
        str = ""
        argv_hash.each do |k,v|
            if k.to_s == "pins_map"
                vv = v.dup
                v.keys.select { |e|  e.is_a? String }.each do |kk|
                    vv.delete kk
                end

                hash_str = ""
                vv.each do |vvk,vvv|
                    hash_str    += "        #{vvk}: #{vvv},\n"
                end
                str += "    #{k.to_s}:{\n#{hash_str}\n    }\n"
            else
                str += "    #{k.to_s}:#{v.to_s.gsub('#',"")},\n"
            end
        end

        File.open(File.join(@out_sv_path,"/inspect/sdl_example/","#{target_class.to_s}_example.rb"),'w') do |f|
            # f.puts dep_array
            f.puts "#{target_class.to_s}.new("
            f.puts str
            f.puts ")"

        end
    end

    ## class methods

    def self.build(top_name,resource_yaml)
        hash = YAML::load(File.open(resource_yaml))
        pm = SdlImplParam.new(hash['params'])

        hash.each do |k,v|
            SdlImplModule.new(k,v)  if(k != 'params') && (k != 'implement')
        end

        if TopModule.sim && hash['implement']['tb_modules']
            imlp_top = SdlTopImplement.new(top_name,File.dirname(resource_yaml),hash['implement']['tb_modules'],hash['implement']['tb'],pm,hash['params']['yaml']['pins'])
        else
            imlp_top = SdlTopImplement.new(top_name,File.dirname(resource_yaml),hash['implement']['modules'],hash['implement']['tb'],pm,hash['params']['yaml']['pins'])
        end

        # hash['implement']['ex_up_code']
        imlp_top.top_module.ex_up_code  = (hash['implement']['ex_up_code'].join("\n")+"\n") if hash['implement']['ex_up_code']

        imlp_top.top_module.gen_sv_module

        if(hash['implement']['constraints'])
            hash['implement']['constraints'].each do |e|
                Constraints.add_const e
            end
        end

        imlp_top.top_module.create_xdc  if hash['implement']['xdc']

    end

end
