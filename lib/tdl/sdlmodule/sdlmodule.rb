# require_relative "./tdl"

$__sdl_curr_self__ = self

class SdlModule
    @@allmodule_name = []
    @@allmodule = []

    def self.allmodule_name
        @@allmodule_name
    end

    def self.call_module(module_name)
        $__sdl_curr_self__.send(module_name)
        # main.send(module_name)
    end

    def self.exist_module?(name)
        @@allmodule_name.include? name.to_s
    end

    def self.Main
        $__sdl_curr_self__
    end

    def signal(name)
        method(name).call
    end

    def inward_inst(name)
        method(name).call
    end

    def has_signal?(name)
        @_add_to_new_module_vars.include? name.to_s
    end

    def has_inward_inst?(name)
        @_add_to_new_module_vars.include? name.to_s
    end

    private

    def def_main_method(name)
        name = name.to_s

        unless name =~ /^[a-zA-Z]([a-zA-Z0-9]|_)*[a-zA-Z0-9]$/
            raise TdlError.new("SdlModule name ERROR: `#{name}`")
        end

        if @@allmodule_name.include? name
            tm = SdlModule.call_module(name)
            raise TdlError.new("sdlmodule[#{name}]<#{path}> already be created before PATH[#{tm.path.to_s}]")
        end

        @@allmodule_name << name

        $__sdl_curr_self__.instance_variable_set("@#{name}",self)
        # main.instance_variable_set("@#{name}",self)

        $__sdl_curr_self__.define_singleton_method(name) do
        # main.define_singleton_method(name) do

            self.instance_variable_get("@#{name}")

        end


    end

    def create_ghost
        @@ele_array.each do |e|
            head = e.to_s
            if e.is_a? String 
                next 
            end
            tmp = e.new(name:"#{head}_NC")
            tmp.belong_to_module = self
            tmp.ghost = true
            instance_variable_set("@#{head}_NC",tmp)

            class << tmp

                def signal
                    @_id_ ||= 0
                    str = @_id_.to_s
                    @_id_ += 1
                    str
                end

            end
        end

    end

    public

    # include AlwaysBlock
    # @@ele_array = ([Parameter] | SignalElm.subclass | InfElm.subclass | CLKInfElm.subclass | [MailBox,BfmStream])
    @@ele_array = ([Parameter] | SignalElm.subclass | CLKInfElm.subclass | [MailBox] | ['ExOther'])

    @@ele_array.each do |e|
        head_str = "#{e.to_s}"
        attr_accessor "#{head_str}_collect"
        attr_accessor "#{head_str}_inst"
        attr_accessor "#{head_str}_draw"
        attr_accessor "#{head_str}_pre_inst_stack"      # before instance,draw,define
        attr_accessor "#{head_str}_post_inst_stack"     # just before define,after instance,draw; and it return string
        attr_reader "#{head_str}_NC"
    end

    attr_accessor :ex_param,:ex_port,:ex_up_code,:ex_down_code
    attr_accessor :out_sv_path,:module_name,:techbench
    attr_reader :create_tcl
    attr_accessor :path,:real_sv_path
    attr_accessor :dont_gen_sv,:target_class
    ## 模块头部添加package引入
    attr_accessor :head_import_packages
    attr_accessor :instanced_and_parent_module

    def initialize(name: "tdlmodule",out_sv_path: nil)
        # $new_m = self
        # self.BindEleClassVars = PackClassVars.new
        # GlobalParam.PushTdlModule(self)
        @out_sv_path = out_sv_path
        def_main_method(name)
        @@allmodule << self
        @module_name = name
        @real_sv_path = File.join(@out_sv_path,"#{@module_name}.sv") if @out_sv_path
        # @port_clocks = []
        # @port_resets = []
        # @port_params = []
        # @port_logics = []
        # @port_datainfs = []
        # @port_datainf_c_s = []
        # @port_videoinfs = []
        # @port_axisinfs = []
        # @port_axi4infs = []
        # @port_axilinfs = []

        @port_clocks        = Hash.new
        @port_resets        = Hash.new
        @port_params        = Hash.new
        @port_logics        = Hash.new
        @port_datainfs      = Hash.new
        @port_datainf_c_s   = Hash.new
        @port_videoinfs     = Hash.new
        @port_axisinfs      = Hash.new
        @port_axi4infs      = Hash.new
        @port_axilinfs      = Hash.new

        # @techbench = TechBench.new
        @sub_instanced = []
        ## --------
        @@ele_array.each do |e|
            head_str = "@#{e.to_s}"
            self.instance_variable_set("#{head_str}_collect",[])
            self.instance_variable_set("#{head_str}_inst",[])
            self.instance_variable_set("#{head_str}_draw",[])
            self.instance_variable_set("#{head_str}_pre_inst_stack",[])
            self.instance_variable_set("#{head_str}_post_inst_stack",[])
            # tmp = e.new(name:"#{e.to_s}_NC")
            # tmp.ghost = true
            # self.instance_variable_set("#{head_str}_NC",tmp)
        end
        create_ghost
        # @super_modules = []
        # @Logic_collect = []
        # @Logic_inst = []
        # @Logic_draw = []
        #
        # @Clock_collect = []
        # @Clock_inst = []
        # @Clock_draw = []
        #
        # @Reset_collect = []
        # @Reset_inst = []
        # @Reset_draw = []
        #
        # @Parameter_collect = []
        # @Parameter_inst = []
        # @Parameter_draw = []
        #
        # @DataInf_collect = []
        # @DataInf_inst = []
        # @DataInf_draw = []
        #
        # @DataInf_C_collect = []
        # @DataInf_C_inst = []
        # @DataInf_C_draw = []
        #
        # @AxiStream_collect = []
        # @AxiStream_inst = []
        # @AxiStream_draw = []
        #
        # @AxiLite_collect = []
        # @AxiLite_inst = []
        # @AxiLite_draw = []
        #
        # @VideoInf_collect = []
        # @VideoInf_inst = []
        # @VideoInf_draw = []
        #
        # @Axi4_collect = []
        # @Axi4_inst = []
        # @Axi4_draw = []
        if block_given?
            yield(self)
        end

        @instanced_and_parent_module ||= Hash.new
        @instance_and_children_module ||= Hash.new
    end

    public

    def vars_define_inst
        vars = []
        @@ele_array.each do |e|
            head_str = "@#{e.to_s}"
            vars += self.instance_variable_get("#{head_str}_collect")
        end

        ele_str = []
        (self.instance_variable_get("@__element_collect__") || [] ).each do |e|
            rel = e._inner_inst
            if rel 
                ele_str << rel 
            end
        end

        vars_inst = vars.map{ |v| v.inst }

        var_str = vars_inst.join("\n")
        var_str +"\n"+ ele_str.join("\n")
    end

    public
    def vars_exec_inst
        vars_inst = []
        vars_draw = []

        @@ele_array.each do |e|
            head_str = "@#{e.to_s}"
            vars_inst |= self.instance_variable_get("#{head_str}_inst")
            vars_draw |= self.instance_variable_get("#{head_str}_draw")
        end

        vars_inst_str = vars_inst.map do |e|
            if e.is_a? String
                e
            elsif e.is_a? Proc
                e.call
            end
        end.join("\n")

        vars_draw_str = vars_draw.map do |e|
            if e.is_a? String
                e
            elsif e.is_a? Proc
                e.call
            end
        end.join("\n")


        vars_inst_str + vars_draw_str
    end
    # private
    def define_ele(name,obj=nil)
        if name.is_a? BaseElm
            obj = name
            name = obj.name
        end
        name = name.to_s
        NameSpaceAdd(name)
        self.define_singleton_method(name) do |&block|
            if block_given?
                yield obj
            end
            obj
        end
    end

    def NameSpaceAdd(name)

        # @_add_to_new_module_vars ||= methods.map { |e| e.to_s }
        @_add_to_new_module_vars ||= []
        @_base_methods ||=  methods.map { |e| e.to_s }
        raise TdlError.new(" SdlModule[#{@module_name}] add signal error: same port or instance `#{name}` ") if (@_add_to_new_module_vars | @_base_methods ).include? name

        @_add_to_new_module_vars << name
    end

    public

    def show_ports
        puts pagination("clock")
        hash_show @port_clocks
        puts pagination("reset")
        hash_show @port_resets
        puts pagination("parameter")
        hash_show @port_params
        puts pagination("logic")
        hash_show @port_logics
        puts pagination("datainf")
        hash_show @port_datainfs
        puts pagination("datainf_c")
        hash_show @port_datainf_c_s
        puts pagination("videoinf")
        hash_show @port_videoinfs
        puts pagination("axistream")
        hash_show @port_axisinfs
        puts pagination("axi4")
        hash_show @port_axi4infs
        puts pagination("axilite")
        hash_show @port_axilinfs
    end

    private

    def hash_show(hash)
        hash.each do |k,v|
            puts "#{k} CLASS:#{v.class} "
        end
    end

    public

    # def self.try_new(name:nil,out_sv_path:nil)
    #     if SdlModule.call_module(name)
    #         SdlModule.call_module(name)
    #     else
    #         SdlModule.new(name:name,out_sv_path:out_sv_path)
    #     end
    # end

end



class SdlModule 
    ## 例化模块

    def method_missing(method,*args,&block)
        rel = nil
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            @@_method_missing_sub_methds ||= []

            @@_method_missing_sub_methds.each do |me|
                rel = self.send(me,method,*args,&block)
                if rel 
                    rel 
                end
            end

            ## 最后才调用阴性例化模块
            rel = implicit_inst_module_method_missing(method,*args,&block)
            if rel 
                rel
            else
                super
            end
        end
        return rel
    end
end

## add clock domain

class SdlModule 


    def same_clock_domain(*vars)
        objs = vars.map do |c|
            ## interface 
            if c.respond_to?(:clock) && c.clock.respond_to?(:freqM)
                c.clock.freqM 
            ## Clock
            elsif c.is_a?(Clock)
                c.freqM  
            else 
            ## other 
                nil
            end 
        end.uniq.compact

        if objs.size > 1
            raise TdlError.new " dont same clock domain"
        end

        ## verification in HDL
        objs_clks = vars.map do |c| 
            ## interface 
            if c.respond_to?(:clock)
                if c.dimension && c.dimension.any?
                    c.clock
                else 
                    c.clock
                end
            ## Clock
            elsif c.is_a?(Clock)
                c  
            else 
            ## other 
                c
            end 
        end

        Clock.same_clock(self, *objs_clks)
    end
end

## 获取 引用的所有文件
class SdlModule

    def __ref_children_modules__
        curr_refs = []

        @_import_packages_ ||= []
        curr_refs << @_import_packages_

        instance_and_children_module.values.each do |pm|
            curr_refs << [pm, pm.__ref_children_modules__()]
        end

        return curr_refs
    end

    def ref_modules

        curr_refs = __ref_children_modules__.flatten.uniq.reject do |e|
            e.is_a?(ClassHDL::ClearSdlModule)
        end
        curr_refs << self
    end

    def self.base_hdl_ref
        ## 基本接口引用
        _base_refs = []
        _base_refs << ['axi_inf', File.expand_path(File.join(__dir__, "../../axi/interface_define/axi_inf.sv"))]
        _base_refs << ['axi_lite_inf', File.expand_path(File.join(__dir__, "../../axi/interface_define/axi_lite_inf.sv"))]
        _base_refs << ['axi_stream', File.expand_path(File.join(__dir__, "../../axi/interface_define/axi_stream_inf.sv"))]
        _base_refs << ['data_inf', File.expand_path(File.join(__dir__, "../../axi/data_interface/data_interface.sv"))]
        _base_refs << ['data_inf_c', File.expand_path(File.join(__dir__, "../../axi/data_interface/data_interface_pkg.sv"))]
        _base_refs << ['axi_bfm_pkg', File.expand_path(File.join(__dir__, "../../axi/AXI_BFM/AXI_BFM_PKG.sv"))]
        _base_refs << ['cm_ram_inf', File.expand_path(File.join(__dir__, "../../tdl/rebuild_ele/cm_ram_inf.sv"))]
        _base_refs << ['Lite_Addr_Data_CMD', File.expand_path(File.join(__dir__, "../../axi/AXI_Lite/gen_axi_lite_ctrl.sv"))]
        _base_refs
    end

    def pretty_ref_hdl_moduls_echo
        index = 1
        _indexs = []
        _names = []
        _paths = []
        max_size = 0
        ref_modules.each do |e| 
            _indexs << index 
            _names << e.module_name
            _paths << File.expand_path(e.real_sv_path)
            index += 1
            if e.module_name.size > max_size
                max_size = e.module_name.size 
            end
        end
        puts(pagination(" Modules of <#{module_name}> reference"))

        # fstr = "[%#{index.to_s.size}d] %-#{ _names.map do |e| e.size end.max }s    %s"
        fstr = "[%#{index.to_s.size}d] %-#{ max_size }s    %s"

        (index-1).times do |xi|
            puts (fstr % [_indexs[xi], _names[xi], _paths[xi]])
        end
    end
end
