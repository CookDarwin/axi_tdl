require 'yaml'
class TopModule < SdlModule

    attr_accessor :techbench,:sim,:constraint
    @@curr_top_module = nil
    def initialize(name:"tdlmodule",out_sv_path:nil)
        @@curr_top_module = self
        # set sim env
        @sim = TopModule.sim
        @out_sv_path = out_sv_path
        # console_argvs
        # TopModule.sim = @sim
        @constraint = ConstraintsVerb.new

        if @sim
            rewrite_to_warning(out_sv_path,"#{name}.sv")

            name = "#{name}_sim"
        else
            rewrite_to_warning(out_sv_path,"#{name}_sim.sv")
        end

        @techbench = TechBenchModule.new(name:"tb_#{name}",out_sv_path:out_sv_path)
        rtl_top_module = super(name:name,out_sv_path:out_sv_path)
        @techbench.Instance(name,"rtl_top")
        rtl_top_module
    end

    def self.current
        @@curr_top_module
    end 

    def pins
        @pins_params
    end

    def load_pins(pins_file)
        pins_params = YAML::load(File.open(pins_file))

        pins_params = recur_pins_hash(pins_params)

        pins_params.define_singleton_method("[]") do |index|
            pins_params.fetch(index.to_s)
        end

        @pins_params = pins_params
    end

    def recur_pins_hash(hash)
        new_hash = {}
        hash.each do |k,v|
            if v.is_a? Hash
                hash[k] = recur_pins_hash(v)
            else
                if v.is_a?(String) && v=~/\s/
                    hash[k] = v.split(/\s+/)
                end
            end
            new_hash[k.to_sym] = hash[k]
        end
        return hash.merge(new_hash)
    end

    def console_argvs
        # hash = Parser.parse(ARGV)
        hash = $argvs_hash
        if hash[:sim]
            @sim = hash[:sim]
        end

        bi = Proc.new do
            bp = File.join(@out_sv_path,"program_files/")
            Dir.mkdir(bp) unless File.exist? bp
            bp
        end

        if hash[:gold]
            @constraint.image(type: :gold,next_addr:hash[:next_cfg_addr],bitpath:bi.call)
        elsif hash[:update]
            @constraint.image(type: :update,bitpath:bi.call)
        end
    end

    def rewrite_to_warning(path,file_name)
        unless path
            _out_sv_path = './'
        else
            _out_sv_path = path
        end

        path_file_name = File.join(_out_sv_path,file_name)

        return unless File.exist? path_file_name

        basename = File.basename(path_file_name,'.sv')

        File.open(path_file_name,'w') do |f|
            str =
"
`timescale 1ns/1ps
module #{basename}();
initial begin
    #(1us);
    $warning(\"Check TopModule.sim,please!!!\");
    $stop;
end
endmodule\n"
            f.puts str
        end

    end

    public

    def gen_sv_module
        if @sim
            Tdl.Puts "INFO: JUST GEN SV[#{@module_name}] FOR SIM "
        else
            Tdl.Puts "INFO: JUST GEN TechBench Modules,NO SIM"
        end
        super
        # @techbench.gen_sv_module

        # exec auto gen sub TechBenchModule
        TechBenchModule.gen_sv_module
    end

    def mix_itegrations
        ## 执行动态link itgt
        # puts implicit_itgt_collect
        self.link_eval
        self.index_inst
        # if implicit_itgt_collect
        #     ## 执行 itgt inst
        #     implicit_itgt_collect.reverse.each do |itgt|
        #         itgt.inst unless itgt.init_inst
        #     end
        # end
        #
        # ## 执行 itgt inst
        # @_itgt_collect_.each do |itgt|
        #     itgt.inst unless itgt.init_inst
        # end
        ## 执行 itegration_verb 里面的silence
        @_itgt_collect_.each do |itgt|
            itgt.silence_procs_run if itgt.respond_to?('silence_procs_run')
        end

        if implicit_itgt_collect
            ## 执行 itegration_verb 里面的silence
            implicit_itgt_collect.each do |itgt|
                itgt.silence_procs_run if itgt.respond_to?('silence_procs_run')
            end
        end

        ## 生成 itgt下的子模块文件
        # gen_children_modules
        @_itgt_collect_.each do |itgt|
            itgt.gen_children_modules()
        end

        if implicit_itgt_collect
            ## 执行 itegration_verb 里面的silence
            implicit_itgt_collect.each do |itgt|
                itgt.gen_children_modules()
            end
        end

    end

    def gen_sv_module_verb
        mix_itegrations
        ## 添加测试用例 实例化
        _exec_add_test_unit() if TopModule.sim
        
        gen_sv_module
    end

    def parse_pin_prop(prop=nil)
        return [prop["pins"],prop["iostd"],prop["pulltype"],prop["drive"]]
    end

    def Input(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        pin,iostd,pulltype,drive = parse_pin_prop(pin_prop) if pin_prop
        a = super(name,dsize:dsize,dimension:dimension,pin:pin,iostd:iostd,pin_prop:pin_prop)
        @constraint.add_property(a,pin,iostd,pulltype,drive)
        a
    end

    def Output(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        pin,iostd,pulltype,drive = parse_pin_prop(pin_prop) if pin_prop
        a = super(name,dsize:dsize,dimension:dimension,pin:pin,iostd:iostd,pin_prop:pin_prop)
        @constraint.add_property(a,pin,iostd,pulltype,drive)
        a
    end

    def Inout(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        pin,iostd,pulltype,drive = parse_pin_prop(pin_prop) if pin_prop
        a = super(name,dsize:dsize,dimension:dimension,pin:pin,iostd:iostd)
        @constraint.add_property(a,pin,iostd,pulltype,drive)
        a
    end

    def Clock(name,freqM:100,port: :input,pin:[],iostd:[],dsize:1,pin_prop:nil)
        pin,iostd,pulltype,drive = parse_pin_prop(pin_prop) if pin_prop
        a = super(name,port:port,freqM:freqM,pin:pin,iostd:iostd,dsize:dsize,pin_prop:pin_prop)
        @constraint.add_property(a,pin,iostd,pulltype,drive)
        a
    end

    def Reset(name,port: :input,active:"low",pin:[],iostd:[],dsize:1,pin_prop:nil)
        pin,iostd,pulltype,drive = parse_pin_prop(pin_prop) if pin_prop
        a = super(name,port:port,active:active,pin:pin,iostd:iostd,dsize:dsize,pin_prop:pin_prop)
        @constraint.add_property(a,pin,iostd,pulltype,drive)
        a
    end

    def create_xdc
        return if @sim
        fname = "#{module_name}_constraints.xdc"
        fname = File.join(@out_sv_path,fname)
        File.open(fname,'w') do |f|
            f.puts @constraint.xds
        end
    end

    def create_add_file_tcl
        return if @sim
        fname = "#{module_name}_add_files.tcl"
        fname = File.join(@out_sv_path,fname)
        File.open(fname,'w') do |f|
            f.puts("add_files \\")
            # f.puts Tdl.all_file_paths.map{ |e| e[1].gsub("\\",'/') }.join("\\\n")
            f.puts Tdl.all_file_paths.map{ |k,v| v.gsub("\\",'/') }.join("\\\n")
        end
    end

    # def self.root_ref_signal(basele,&block)   # return proc becuse top module may not be created
    #     if basele.is_a? BaseElm
    #         Proc.new do
    #             @@root_ref_array = []

    #             unless block_given?
    #                 self.recur_ref(basele.belong_to_module,basele.signal)
    #             else
    #                 self.recur_ref(basele.belong_to_module,yield(basele))
    #             end

    #             if @@root_ref_array.any?
    #                 @@root_ref_array.first
    #             else
    #                 NqString.new("")
    #             end
    #         end
    #     else
    #         raise TdlError.new("#{basele} is a #{basele.class} . Type ERROR")
    #         basele.to_s
    #     end
    # end

    # def self.root_ref_inst(sub_inst,port_key)   # return proc becuse top module may not be created
    #     unless sub_inst.is_a? SdlInst
    #         raise TdlError.new("[KEY:#{port_key}]root_ref_inst of #{@module_name} must be a SdlInst")
    #     end
    #     Proc.new do
    #         basele = sub_inst[port_key]
    #         if basele.is_a? BaseElm
    #             @@root_ref_array = []
    #             self.recur_ref(basele.belong_to_module,basele.signal)
    #             if @@root_ref_array.any?
    #                 @@root_ref_array.first
    #             else
    #                 basele.to_s
    #             end
    #         elsif basele.is_a? Proc
    #             basele.call
    #         else
    #             basele
    #         end
    #     end
    # end

    # def self.root_ref_proc(block=nil)   # return proc becuse top module may not be created
    #     Proc.new do
    #         if block_given?
    #             basele = yield
    #         else
    #             basele = block.call
    #         end

    #         if basele.is_a? BaseElm
    #             @@root_ref_array = []
    #             self.recur_ref(basele.belong_to_module,basele.signal)
    #             if @@root_ref_array.any?
    #                 @@root_ref_array.first
    #             else
    #                 NqString.new("")
    #             end
    #         else
    #             basele
    #         end
    #     end
    # end

    # def self.root_ref_signals(basele)   # return proc becuse top module may not be created
    #     if basele is_a? BaseElm
    #         Proc.new do
    #             @@root_ref_array = []
    #             self.recur_ref(basele.belong_to_module,basele.signal)
    #             @@root_ref_array
    #         end
    #     else
    #         Proc.new { basele }
    #     end
    # end

    # def self.recur_ref(sdlmodule,collect_str)
    #     if sdlmodule.is_a? TopModule
    #         @@root_ref_array << "$root.#{sdlmodule.techbench.module_name}.#{sdlmodule.instanced_and_parent_module.keys.first}.#{collect_str}"
    #     else
    #         return nil unless sdlmodule.instanced_and_parent_module
    #         sdlmodule.instanced_and_parent_module.each do |k_inst,v_module|
    #             next_collect_str = "#{k_inst}.#{collect_str}"
    #             self.recur_ref(v_module,next_collect_str)
    #         end
    #     end
    # end

    def self.define_global(name,default_value)
        # RedefOpertor.with_normal_operators do
            self.class_variable_set("@@#{name.to_s}",default_value)

            self.define_singleton_method(name.to_s) do
                self.class_variable_get("@@#{name.to_s}")
            end

            self.define_singleton_method("#{name.to_s}=") do |a|
                self.class_variable_set("@@#{name.to_s}",a)
            end
        # end
    end

    define_global("sim",nil)

end
## 添加 itegration verb
class TopModule

    attr_accessor :implicit_itgt_collect
    # attr_accessor :cal_inst_index_proc

    def itgt_collect
        @_itgt_collect_
    end

    def add_itegration(itgt_class,nickname:nil,param:{},pins_map:{},implicit:false)
        @_itgt_collect_ ||= []
        if pins_map.is_a? Hash
            pins_map_f = pins_map
        else
            pins_map_f = self.pins[pins_map.to_s] || {}
        end

        ist = Kernel.const_get(itgt_class).new(nickname,pins_map_f,self)
        @_itgt_collect_ << ist unless implicit
        # ist.top_module = self
        param.each do |k,v|
            ist.send("#{k}=",v)
        end

        ## 加入新的itgt时，自动link itgt
        # ist.link_eval
        # puts "------------------"
        # ist.names_pool_inst
        ## 如果itgt没有上级 link 和 不是隐性添加 则直接例化
        # if nickname != "implicit"
            col = ist.class.get_itgt_var('itegration_link_collect',[])
            if col && col.empty?
                ist.inst unless ist.init_inst
                ist.init_inst = true
                ist.inst_index = 0
            end
        # end
        # ist.inst
        return ist
    end

    def link_eval
        @_itgt_collect_ ||= []
        
        @_itgt_collect_.each do |i|
            i.link_eval
        end
    end

    def index_inst
        curr_collect = (implicit_itgt_collect || []) | @_itgt_collect_

        curr_collect.each do |e|
            if e.init_inst
                e.cal_inst_index(0)
            end
        end

        curr_collect = curr_collect.sort { |a, b| a.inst_index <=> b.inst_index }

        curr_collect.each {|e| e.inst unless e.init_inst }

    end
end

## 添加 missing

class TopModule
    ## vcs path 
    attr_accessor :vcs_path
    def self.method_missing(method,*args,&block)

        sdlm = TopModule.new(name: method,out_sv_path: args[0])
        @@package_names ||= []
        sdlm.head_import_packages = []
        sdlm.head_import_packages += @@package_names

        @@package_names.each do |e|
            sdlm.require_package(e,false) if e
        end
        @@package_names = []
        sdlm.instance_exec(&block)

        if args[0] && File.exist?(args[0])
            # sdlm.gen_sv_module
            sdlm.gen_sv_module_verb
            unless sdlm.vcs_path
                # sdlm.test_unit.gen_dve_tcl(File.join(args[0],"dve.tcl"))
                SdlModule.gen_dev_wave_tcl File.join(args[0],"dve.tcl")
            else  
                # sdlm.test_unit.gen_dve_tcl(File.join(sdlm.vcs_path,"dve.tcl"))
                SdlModule.gen_dev_wave_tcl File.join(sdlm.vcs_path,"dve.tcl")
            end
            sdlm.create_xdc
        else 
            sdlm.origin_sv = true 
        end
        sdlm
    end
    ## 定义模块时添加 package

    def self.with_package(*args)
        @@package_names += args
        return self 
    end
end

## 給TopModule 添加单元测试 方法
# module TdlSpace 
#     class TopModuleTestUnitRef

#         def collect_unit(tu)
#             @__collect_units__ ||= []
#             @__collect_units__ << tu 
#         end

#         def echo_units
#             @__collect_units__ ||= []
#             index = 1
    
#             rels = []
#             # __collect = TdlTestPoint.inst_collect.select { |e| e.target.belong_to_module.top_tb_ref? }
#             # @__collect_units__.each do |ue|
#             #     tp_str = ue.origin.dve_wave_signals.select do |e|
#             #         e.respond_to? :tp_instance
#             #     end.map do |ele| 
#             #         unless __collect.index(ele.tp_instance)
#             #             puts ele.name
#             #         end
#             #         "     ->#{__collect.index(ele.tp_instance)+1}< :: #{ele.tp_instance.name} || #{ele.tp_instance.file}:#{ele.tp_instance.line}" 
#             #     end.join("\n")

#             #     rels << "  [#{index}]  #{ue.origin.module_name} ::<TestPoints> \n#{tp_str}"
#             #     index += 1
#             # end
#             rels.join("\n")
#         end

#         def dve_wave(name: '', signals: []) #name => SdlModule instance name
#             return unless signals
#             @_dev_wave_ ||= Hash.new 
#             @_dev_wave_[name.to_s] = signals    ## Signal is TdlTestPoint
#         end

#         def gen_dve_tcl(filename)
#             File.open(filename,'w') do |f|
#                 f.puts TdlSpace.gen_dev_wave_tcl(@_dev_wave_ || Hash.new)
#             end
#         end

#     end
# end 

# class TopModule
#     def test_unit
#         @__test_unit__ ||= TdlSpace::TopModuleTestUnitRef.new
#     end

# end

##  判断 是否被顶层引用
class SdlModule

    def top_module_ref?
        if self == TopModule.current.techbench 
            return true
        end
        instanced_and_parent_module.values.each do |pm|
            if pm.is_a?(TopModule)
                return true 
            else
                if pm.instanced_and_parent_module.any? 
                    if pm.top_module_ref?
                        return true 
                    end
                end
            end
        end
        return false
    end

    def top_tb_ref?
        return false unless TopModule.current
        if self == TopModule.current.techbench 
            return true
        end
        instanced_and_parent_module.values.each do |pm|
            if pm == TopModule.current.techbench ##pm.is_a?(TechBenchModule)
                return true 
            else
                if pm.instanced_and_parent_module.any? 
                    if pm.top_tb_ref?
                        return true 
                    end
                end
            end
        end
        return false
    end
end



