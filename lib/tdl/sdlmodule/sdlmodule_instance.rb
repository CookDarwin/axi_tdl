class DefaultProc < Proc

end

class SdlInst

    attr_accessor :inner_port_hash,:inst_port_hash,:inst_param_hash

    attr_accessor :name,:belong_to_module

    attr_reader :origin

    def initialize(origin:nil,name:'inst')
        @origin = origin
        @inner_port_hash = Hash.new
        @inst_port_hash = Hash.new
        @inst_param_hash = Hash.new
        @name = name
        Tdl.add_to_all_file_paths(@origin.module_name.to_s,@origin.real_sv_path) if @origin.real_sv_path
    end

    private
    def read_hash_value(hash,key)
        value = hash[key]
        if value.is_a? DefaultProc
            hash[key] = value.call(key)
        else
            value
        end
    end

    public

    def Parameter(key)
        read_hash_value(inst_param_hash,key)
    end

    def Ports(key)
        read_hash_value(inst_port_hash,key)
    end

    def [](key)
        key = key.to_s
        if inst_param_hash.key? key
            # inst_param_hash[key]
            Parameter(key)
        elsif inst_port_hash.key? key
            # inst_port_hash[key]
            Ports(key)
        else
            printf_keys
            raise TdlError.new("#{@origin.module_name} dont have port [#{key} :CLASS #{key.class}]")
        end
    end

    def []=(key,value)
        key = key.to_s
        if inst_param_hash.key? key
            inst_param_hash[key] = value
        elsif inst_port_hash.key? key
            ## 判断 接口类型是否一样
            # if @origin.send(key).is_a?(InfElm) && value.is_a?(InfElm)
            if @origin.send(key).is_a?(TdlSpace::TdlBaseInterface) && value.is_a?(TdlSpace::TdlBaseInterface)
                if @origin.send(key).class != value.class 
                    raise TdlError.new("#{@origin.module_name} port type<#{@origin.send(key).class}> isnot same as #{value.name} <#{value.class}>")
                else 
                    # raise TdlError.new("#{@origin.module_name} port type isnot same as #{value.module_name}")
                    if value.modport_type
                        if @origin.send(key).modport_type.to_s != value.modport_type.to_s
                            # raise TdlError.new("[#{@origin.module_name}] port[#{key}][#{@origin.send(key).port}] type isnot same as [#{value}][#{value.port}]")
                            # puts "[#{@origin.module_name}] port[#{key}][#{@origin.send(key).port}] type isnot same as [#{value}][#{value.port}]"
                            inst_port_hash[key] = VCSCompatable::auto_vcs_cpt_connect(@origin.send(key) ,value)
                        else 
                            inst_port_hash[key] = value
                        end
                    else 
                        inst_port_hash[key] = value
                    end
                end
            else 
                inst_port_hash[key] = value
            end 
        else
            printf_keys
            raise TdlError.new("#{@origin.module_name} dont have port [#{key} :CLASS #{key.class}]")
        end
    end

    def hier_signal(*keys)
        RedefOpertor.with_normal_operators do
            if keys.size == 1
                _last_hier_signal(keys[0])
            else
                @_inst_collect ||= hier_inst_collect
                cl = @_inst_collect.find do |e|
                    if keys[0].is_a? SdlInst
                        keys[0].inst_name == e.inst_name
                    elsif keys[0].is_a?(String) || keys[0].is_a?(Symbol)
                        kstr = keys[0].to_s
                        kstr == e.inst_name
                    else
                        raise TdlError.new("#{@origin.module_name} hier signal key type error")
                    end
                end

                unless cl
                    raise TdlError.new("#{@origin.module_name} INST #{inst_name} dont have #{keys[0].to_s}")
                end

                "#{cl.inst_name}."+hier_signal(*keys[1,keys.size])
            end
        end
    end


    def _last_hier_signal(key)
        @_name_collect ||= hier_name_collect

        if key.is_a? BaseElm
            key_str = key.signal
        elsif key.is_a? String
            key_str = key
        elsif key.is_a? Symbol
            key_str = key.to_s
        else
            raise TdlError.new("#{@origin.module_name} hier signal key type error")
        end

        if @_name_collect.include? key_str
            "#{inst_name}.#{key_str}"
        else
            raise TdlError.new("#{@origin.module_name} INST #{inst_name} dont have #{key_str}")
        end
    end


    def inst_draw
"#{@origin.module_name} #{inst_param}#{inst_name}(
#{inst_port}
);"
    end

    def inst_name
        @name.to_s
    end

    private

    def inst_param
        "<T0> .xxxx <T1> (.....)"
        t0 = []
        t1 = []
        inst_param_hash.each do |key,value|
            t0 << "    .#{key.to_s}"
            if value
                raise TdlError.new("Instance ERROR module[#{@origin.module_name}] Inst_name[#{name}] Parameter [#{key}]") if value.is_a? Array
                t1 << inst_t2(value)
            else
                t1 << nil
            end
        end

        max_len_t0 = t0.map { |e| e.length  }.max
        max_len_t1 = t1.map do |e|
            if e
                e.length
            else
                0
            end
        end.max

        tt = []

        t0.each_index do |index|
            if t1[index]
                t0_str = t0[index]+" "*(max_len_t0+1-t0[index].length)
                t1_str = "("+t1[index]+" "*(max_len_t1-t1[index].length)+" )"
                tt << t0_str + t1_str
            end
        end

        if tt.empty?
            tt_str = ""
        else
            tt_str = "#(\n"+tt.join(",\n")+"\n)"
        end

    end

    def inst_port
        "<T0> /* ..... */ <T1> .xxxx <T2> (....)"
        t0 = []
        t1 = []
        t2 = []

        inner_port_hash.each do |key,value|
            raise TdlError.new("Instance ERROR module[#{@origin.module_name}] Inst_name[#{name}] Port [#{key}] Port cant be array") if inst_port_hash[key].is_a? Array
            
            t0 << inst_t0(value)
            t1 << inst_t1(value)
            t2 << inst_t2(inst_port_hash[key])
        end

        max_len_t0 = t0.map { |e| e.length  }.max
        max_len_t1 = t1.map { |e| e.length  }.max
        max_len_t2 = t2.map { |e| e.length  }.max

        ttt = []

        t0.each_index do |index|
            t0_str = "/* " + t0[index] + " "*(max_len_t0-t0[index].length) + " */"
            t1_str = t1[index] + " "*(max_len_t1+1-t1[index].length)
            t2_str = "(" + t2[index] + " "*(max_len_t2-t2[index].length) + " )"
            ttt << t0_str + t1_str + t2_str
        end

        ttt.join(",\n")

    end

    def inst_t0(ele)
        case
        when ele.class == Clock then
            "#{ele.port} clock"
        when ele.class == Reset then
            "#{ele.port} reset"
        when ele.class == Logic then
            "#{ele.port}"
        # when ele.class == AxiStream then
        #     "axi_stream_inf.#{ele.port}"
        # when ele.class == DataInf then
        #     "data_inf.#{ele.port}"
        # when ele.class == DataInf_C then
        #     "data_inf_c.#{ele.port}"
        # when ele.class == AxiLite then
        #     "axi_lite_inf.#{ele.port}"
        # when ele.class == Axi4 then
        #     "axi_inf.#{ele.port}"
        # when ele.class == VideoInf then
        #     "video_native_inf.#{ele.port}"
        when TdlSpace::TdlBaseInterface.subclass.include?(ele.class) then 
            "#{ele.class.get_class_var('hdl_name')}.#{ele.modport_type}"
        else
            rel_str = inst_t0_methods(ele)
            unless  rel_str
                raise TdlError.new("When instance ports of module, but it can parse this #{ele.to_s} class [#{ele.class}]")
            else
                rel_str
            end
        end
    end

    def self.add_inst_t0_method(mf)
        @@_inst_t0_methods ||= []
        @@_inst_t0_methods << mf
    end

    def inst_t0_methods(ele)
        @@_inst_t0_methods ||= []
        rel = nil
        @@_inst_t0_methods.each do |m|
            rel = m.call(ele)
            if rel
                break
            end
        end
        rel
    end

    def inst_t1(ele)
        ".#{ele.name.to_s}"
    end

    def inst_t2(value)
        with_new_align(0) do
            if value.is_a? DefaultProc # It mean the port not be used,so leave it empty
                "#{align_signal('/*unused */',q_mark=false)}"
            else
                "#{align_signal(value)}"
            end
        end
    end

    def hier_name_collect
        oss = []
        ops = @origin.instance_variable_get("@ports").map { |k,v| v.signal }

        (SignalElm.subclass | InfElm.subclass).each do |e|
            # puts "@#{e.to_s}_collect"
            oss |= @origin.instance_variable_get("@#{e.to_s}_collect").map { |se|  se.signal }
            # oss |= @origin.method("#{e.to_s}_collect").map { |se|  se.signal }
        end

        ops + oss
    end

    def printf_keys
        puts pagination("PARAMETERS KEY")
        inst_param_hash.keys.each do |e|
            puts "CLASS[#{e.class}] VALUE[#{e}]"
        end
        puts pagination("PORTS KEY")
        inst_port_hash.keys.each do |e|
            puts "CLASS[#{e.class}] VALUE[#{e}]"
        end
    end

    public

    def hier_inst_collect
        ois = @origin.instance_variable_get("@sub_instanced")
    end

    private

    def method_missing(method_id,*argvs,&block)
        methods_pool = @origin.instance_variable_get("@_add_to_new_module_vars")
        method_str = method_id.to_s
        # if  methods_pool.include?(method_str)
        #     if argvs.empty?
        #         if inst_port_hash.key?(method_str)
        #             inst_port_hash[method_str]
        #         elsif inst_param_hash.key?(method_str)
        #             inst_param_hash[method_str]
        #         else 
        #             @origin.public_send(method_id,*argvs,&block)
        #         end
        #     else 
        #         ## 带参数，及函数带连接
        #         self[method_id] = argvs[0]
        #     end
        # else
        #     super
        #     # raise TdlError.new("SDL Instance dont have method `#{method_id}`")
        # end

        if inst_port_hash.key? method_str
            if argvs.empty?
                inst_port_hash[method_str]
            else  
                self[method_id] = argvs[0]
            end
        elsif inst_param_hash.key? method_str
            if argvs.empty?
                inst_param_hash[method_str]
            else  
                self[method_id] = argvs[0]
            end
        else  
            super 
        end

        # if argvs.empty?
        #     if inst_port_hash.key?(method_str)
        #         inst_port_hash[method_str]
        #     elsif inst_param_hash.key?(method_str)
        #         inst_param_hash[method_str]
        #     else 
        #         @origin.public_send(method_id,*argvs,&block)
        #     end
        # else 
        #     ## 带参数，及函数带连接
        #     self[method_id] = argvs[0]
        # end
    end

    ## 添加语法糖
    public 

    def port(*args)
        return SdlInstPortSugar.new(self)
    end

    alias_method :data_inf_c,:port
    alias_method :axi_stream_inf,:port
    alias_method :data_inf,:port 
    alias_method :axi4,:port

    

    def output(*args)
        return SdlInstSimplePortSugar.new(self) 
    end

    alias_method :input,:output 
    alias_method :inout,:output
    alias_method :param,:output 
    alias_method :parameter,:output
    
end

class SdlInstSimplePortSugar
    attr_reader :sdl_inst
    def initialize(sdl_inst)
        @sdl_inst = sdl_inst

    end

    def [](*args)
        return self
    end

    alias_method :logic,'[]'
    alias_method :wire,'[]'

    def method_missing(method_id,*argvs,&block)
        # if @sdl_inst.respond_to? method_id
            @sdl_inst.send(method_id,*argvs,&block)
            # else  
        #     raise TdlError.new("#{@sdl_inst.origin.module_name} dont have port #{method_id}")
        # end
    end
end

class SdlInstPortSugar < SdlInstSimplePortSugar
    

    @@ml = [:input,:in,:output,:out,:inout,:mirror,:mirror_out,:master,:slaver,:master_wr,:slaver_wr,:master_rd,:slaver_rd,:master_rd_aux,:mirror_rd,:out_mirror,:mirror_wr,:master_wr_aux,:master_wr_aux_no_resp]
    # @@ml += ['data_inf_c','data_inf','axi_stream_inf','axi4','axi_inf','axis','data_c']
    @@ml.each do |e|
        define_method(e) do |*args|
            ## 例化端口合法性检测
            if args[0].is_a?(TdlSpace::TdlBaseInterface) || args[0].is_a?(Logic)
                raise TdlError.new("Port[#{e}] connect Error!!!")
            end
            return self
        end
    end

    # def [](*args)
    #     return self 
    # end

end

class SdlModule

    # attr_accessor :ports
    # attr_accessor :parent_modules,:children_modules
    attr_accessor :instanced_and_parent_module
    attr_accessor :instance_and_children_module

    def instanced(name,parent_module)
        @ports ||= Hash.new
        # [@port_clocks , @port_resets , @port_logics , @port_datainfs , @port_datainf_c_s , @port_videoinfs , @port_axisinfs , @port_axi4infs , @port_axilinfs].each do |e|
        #     @ports = @ports.merge e
        # end
        # @ports = (@port_clocks + @port_resets + @port_logics + @port_datainfs + @port_datainf_c_s + @port_videoinfs + @port_axisinfs + @port_axi4infs + @port_axilinfs)
        @instance_cnt ||= 0
        inst_p = SdlInst.new(origin:self,name:name)
     
        @instances ||= []
        @instances << inst_p

        @port_params.each do |k,v|
            inst_p.inst_param_hash[k.to_s] = nil
        end

        @ports.each do |k,v|
            inst_p.inner_port_hash[k.to_s] = v
            if v.is_a? SignalElm
                dele = DefaultProc.new do
                    new_ele = v.copy(belong_to_module:parent_module)
                    # new_ele.belong_to_module = parent_module
                    new_ele.name = "#{name}_#{v.name}"
                    new_ele
                end
            else
                dele = NqString.new("")
            end
            inst_p.inst_port_hash[k.to_s] = dele
        end

        @instance_cnt += 1

        inst_p
    end

    private

    def add_new_after_inst(baseele)
        @instanced_and_parent_module ||= Hash.new
        if baseele.is_a? Parameter
            instanced_and_parent_module.each do |k_inst,v_module|
                v_module.method(k_inst.inst_name).call.inst_param_hash[baseele.name.to_s]  = nil
            end
        else
            instanced_and_parent_module.each do |k_inst,v_module|
                v_module.method(k_inst.inst_name).call.inner_port_hash[baseele.name.to_s]  = baseele
                v_module.method(k_inst.inst_name).call.inst_port_hash[baseele.name.to_s]   = NqString.new("")
            end

        end
    end

    public

    def Instance(sdlmodule_name,name)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            name = name.to_s
            unless name.to_s =~ /^[a-zA-Z]([a-zA-Z0-9]|_)*[a-zA-Z0-9]$/
                raise TdlError.new("SdlModule Instance name ERROR: `#{name}`")
            end

            sdlmodule = SdlModule.call_module(sdlmodule_name)
    
            if self.module_name.eql? sdlmodule.module_name
                raise TdlError.new("SdlModule [#{@module_name}]cant instance itself ")
            end
            inst_obj = sdlmodule.instanced(name,self)
            inst_obj.belong_to_module = self
            add_children_modules(inst_obj: inst_obj,module_poit:sdlmodule)
            define_ele(name,inst_obj)
            @sub_instanced << inst_obj
            if block_given?
                yield inst_obj,self
            end
            inst_obj
        end
    end

    def Itgt_Instance(sdlmodule_name,stringbanditegration,&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            unless stringbanditegration.is_a? StringBandItegration
                raise TdlError.new("Itgt_Instance is just used for StringBandItegration")
            end

            _inst_obj = Instance(sdlmodule_name,stringbanditegration.to_s,&block)

            # stringbanditegration.itgt.define_singleton_method(stringbanditegration.origin_str) do
            #     _inst_obj
            # end
            StringBandItegration.add_method_to_itgt(stringbanditegration,_inst_obj)
            _inst_obj
        end
    end

    # private

    def instance_draw
        @sub_instanced.map do |e|
            e.inst_draw
        end.join("\n")
    end

    def add_children_modules(inst_obj:nil,module_poit:nil)
        # inst_name = inst_name.to_s
        @instance_and_children_module ||= Hash.new
        @instance_and_children_module[inst_obj] = module_poit
        module_poit.add_parent_modules(inst_obj:inst_obj,module_poit:self)
    end

    public

    def add_parent_modules(inst_obj:nil,module_poit:nil)
        # inst_name = inst_name.to_s
        @instanced_and_parent_module ||= Hash.new
        @instanced_and_parent_module[inst_obj] = module_poit
    end

    def call_instance(name)
        method(name).call
    end


end

class SdlModule
    ## 获取模块的树状结构
    ## 父 [self,[ [P0,inst-name], [P1,[P1-1,P1-2]] [P3, inst-name]] ]
    def parents_inst_tree(collect=[],&block)
        rels = []
        # parent_rels = []
        @instanced_and_parent_module.each do |k,v|
            # ## 获取generate tree 
            # if v.is_a? ClassHDL::GenerateBlock
            #     dc = collect.dup
            #     dc << v 
            #     dc << v.belong_to_module
            #     v.parents_inst_tree(dc,&block)
            # elsif v.is_a? ClassHDL::ClearGenerateSlaverBlock
            #     dc = collect.dup
            #     dc << v.belong_to_module
            #     dc << v.belong_to_module.belong_to_module
            #     v.parents_inst_tree(dc,&block)
            # end

            # v.instance_variable_get("@sub_instanced").each do |sm|
            v.instance_and_children_module.each do |ck,cv|
                sm = ck
                dc = collect.dup
                if sm.origin == self 
                    # rels << sm
                    if v.instanced_and_parent_module.empty? 
                        dc << sm 
                        dc << v
                        rels << dc
                        yield dc if block_given?
                    else
                        dc << sm unless cv.is_a?(ClassHDL::ClearGenerateSlaverBlock)
                        v.parents_inst_tree(dc,&block)
                    end
                end
            end
        end
        rels 
    end

    ## 子 [self,[C0, [C1,[C1-1,C1-2]] C3]]
    def children_inst_tree(collect=[],&block)
        rels = []
        # parent_rels = []
        @sub_instanced.each do |sm|
            dc = collect.dup
            if sm.origin.instance_and_children_module.empty? 
                dc << sm
                rels << dc
                yield dc if block_given?
            else 
                dc << sm
                sm.origin.children_inst_tree(dc,&block)
            end
        end
        rels 
    end
end