class SdlModule
    # attr_accessor :dve_wave_signals

    def tracked_by_dve(flag:nil, &filter_block) ## 被dve track
        @@__tracked_by_dve_hash__ ||= Hash.new
        # if @@__tracked_by_dve_hash__.has_key?(self)
        #     raise TdlError.new(" `#{module_name}` Cant be tracked again!!!")
        # end
        @@__tracked_by_dve_hash__[self] = filter_block
        @__track_filter_block__ = filter_block
        @__dve_track_flag__ = flag
    end

    def self.tracked_by_dve ## 收集添加有 dve track 的模块
        @@__tracked_by_dve_hash__ ||= Hash.new ## key:sdlmodule, value:filter_block
    end
    
    def add_to_dve_wave(flag: :default,base_ele: nil,&block)
        @__track_signals_hash__ ||=Hash.new 
        @__track_signals_hash__[flag] ||= Hash.new

        if @__track_signals_hash__[flag].has_key?(base_ele)
            raise TdlError.new(" `#{module_name}.#{base_ele.to_s}` Cant be tracked again!!!")
        end

        @__track_signals_hash__[flag][base_ele] = block

        unless base_ele.is_a?(AxiTdl::SdlModuleActiveBaseElm)
            raise TdlError.new(" `#{base_ele.to_s}<class #{base_ele.class}>` is not AxiTdl::SdlModuleActiveBaseElm !!! ")
        end
    end

    def track_signals_hash
        @__track_signals_hash__ ||=Hash.new

        unless @__dve_track_flag__
            @__track_signals_hash__
        else 
            rel = {}
            rel[@__dve_track_flag__] = @__track_signals_hash__[@__dve_track_flag__]
            rel
        end
    end

    def gen_dev_wave_tcl ## 返回一个[]
        dve_tcl_hash = {}
        track_signals_hash.each do |flag, base_ele_bhash|
            base_elms = []
            intf_elms = []
            intf_elms_name = []
            base_ele_bhash.each do |ele, sub_filter_block|
                _ref_paths = ele.path_refs(&@__track_filter_block__)

                if sub_filter_block
                    _ref_paths = _ref_paths.select do |e| 
                        sub_filter_block.call(e) 
                    end 
                end 

                if _ref_paths.size == 1
                    # rels[0]
                elsif _ref_paths.size == 0
                    raise TdlError.new "#{ele.to_s} Cant find root ref"
                else
                    raise TdlError.new "#{ele.to_s} Find multi root refs \n#{_ref_paths.join("\n")}\n"
                end


                if ele.is_a?(BaseElm) || ele.is_a?(ClassHDL::EnumStruct) || ele.is_a?(ClassHDL::StructVar)
                    base_elms   << _ref_paths[0].sub("$root.","Sim:") 
                elsif ele.is_a? TdlSpace::TdlBaseInterface
                    if ele.modport_type
                        base_elms   << _ref_paths[0].sub("$root.","Sim:")  
                    else
                        intf_elms   << _ref_paths[0].sub("$root.","Sim:") 
                        intf_elms_name << ele.inst_name
                    end
                end

                
            end

            dve_tcl_hash[flag] = [base_elms, intf_elms,intf_elms_name]

        end

        add_ss = []
        add_list = []
        add_bar = []
        dve_tcl_hash.each do |flag, ary|
            add_ss  << TdlSpace.dev_signals_to_tcl(flag: "#{module_name}_#{flag}", signals: ary[0] )

            add_list << TdlSpace.gui_list_add_group(flag: "Group2_#{module_name}_#{flag}")

            ary[1].each_index do |index|
                add_ss << TdlSpace.dev_interface_to_tcl(flag: "#{module_name}_#{flag}", iname: ary[2][index] ,signals: [ ary[1][index] ])
                add_list <<  TdlSpace.gui_list_add_group(flag: "#{module_name}_#{flag}|#{ary[2][index]}")
            end

            add_bar  << TdlSpace.gui_list_set_insertion_bar(flag: "#{module_name}_#{flag}")
        end

        # TdlSpace.dve_tcl_temp(add_ss.join("\n"), add_list.join("\n"), add_bar.join("\n") )

        return [add_ss.join("\n"), add_list.join("\n"), add_bar.join("\n")]

    end

    def self.gen_dev_wave_tcl(filepath=nil)
        ctcl_ss,ctcl_list,ctcl_bar = [],[],[]
        self.tracked_by_dve.each do |sdlm,filter_block|
            tcl_ss,tcl_list,tcl_bar = sdlm.gen_dev_wave_tcl

            ctcl_ss << tcl_ss
            ctcl_list << tcl_list
            ctcl_bar << tcl_bar
        end

        rel = TdlSpace.dve_tcl_temp(ctcl_ss.join("\n"), ctcl_list.join("\n"), ctcl_bar.join("\n") )
        if filepath 
            File.open(filepath,'w') do |f|
                f.puts rel 
            end
        end
        rel
    end

    

    def self.echo_tracked_by_dve 
        # Flag module root_path
        # rels = {}
        flags = []
        _modules = []
        _root_path = []
        _signals = []
        _max_name = 'module_name'.size
        _max_flag = 'FLAG'.size
        _max_signal = 'SIGNAL'.size
        self.tracked_by_dve.each do |sdlm, filter_block|
            __track_signals_hash__ = sdlm.track_signals_hash || Hash.new 
            __track_signals_hash__.each do |flag, sub_hash|

                sub_hash.each do |ele, sub_filter_block|
                    _root_refs = ele.path_refs(&filter_block)
                    if sub_filter_block 
                        _root_refs.select! do |e| sub_filter_block.call(e) end
                    end    

                    if _root_refs.size == 1
                        # rels[0]
                    elsif _root_refs.size == 0
                        raise TdlError.new "#{ele.to_s} Cant find root ref"
                    else
                        raise TdlError.new "#{ele.to_s} Find multi root refs \n#{_root_refs.join("\n")}\n"
                    end

                    flags << flag.to_s 
                    _modules << sdlm.module_name
                    if sdlm.module_name.size > _max_name
                        _max_name = sdlm.module_name.size
                    end
                    if flag.to_s.size > _max_flag
                        _max_flag   = flag.to_s.size 
                    end
                    # _root_path << _root_refs[0]
                    _root_path << File.expand_path(ele.belong_to_module.real_sv_path)

                    _signals << ele.to_s
                    if ele.to_s.size > _max_signal 
                        _max_signal = ele.to_s.size 
                    end
                end
            end
        end
        
        collect = ["[%s]    %-#{_max_flag}s    %#{_max_name+4}s  %-#{_max_signal}s    %s" % ['index', 'FLAG', 'MODULE-NAME', 'SIGNAL', 'belong_to_module']]
        flags.each_index do |index|
           collect << "[%5d]    %-#{_max_flag}s    %#{_max_name+4}s  %-#{_max_signal}s    %s" % [index+1, flags[index], _modules[index], _signals[index], _root_path[index]]
        end

        collect.join("\n")
    end
end

module AxiTdl 
    module TestUnitTrack # included AxiTdl::SdlModuleActiveBaseElm
        def tracked_by_dve(flag= :default,&filter_block)
            self.belong_to_module.tracked_by_dve
            self.belong_to_module.add_to_dve_wave(flag: flag, base_ele: self, &filter_block)
        end
    end
end

module AxiTdl 
    class SdlModuleActiveBaseElm
        include AxiTdl::TestUnitTrack
    end
end

class TestUnitModule < SdlModule ##TestUnitModule 是在编译完 TopModule TB后才会运行

    def initialize(name: "tdlmodule",out_sv_path: nil)
        super(name: name,out_sv_path: out_sv_path)
        # @dve_wave_signals = []
    end

    def test_unit_init(&block)
        Initial do 
            to_down_pass    <= 1.b0
            initial_exec("wait(from_up_pass)")
            initial_exec("$root.#{TopModule.current.techbench.module_name}.test_unit_region = \"#{module_name}\"")
            block.call ## collect __root_ref_eles__ at here
            to_down_pass    <= 1.b1
        end
    end

    def add_root_ref_ele(*eles)
        @__root_ref_eles__ ||= []
        @__root_ref_eles__ += eles
        @__root_ref_eles__.uniq!
    end

    def root_ref_eles 
        @__root_ref_eles__ || []
    end

    def be_instanced_by_sim
        @@__be_instanced_by_sim__ ||= []
        @@__be_instanced_by_sim__ << self
    end

    def self.be_instanced_by_sim
        @@__be_instanced_by_sim__ || []
    end

    def self.echo_be_instanced_by_sim
        @@__be_instanced_by_sim__ ||= []

        _module_name = []
        _ref_module_name = []
        _signal_name = []
        _ref_module_path = []

        _max_module_name = 'test_module'.size 
        _max_signal_name = 'SIGNAL'.size 
        _max_ref = 'REF_MODULE'.size
        @@__be_instanced_by_sim__.each do |tm|
            __root_ref_eles__ = tm.root_ref_eles

            __root_ref_eles__.each do |ele|
                _module_name << tm.module_name
                _ref_module_name << ele.belong_to_module.module_name
                _signal_name << ele.to_s 
                _ref_module_path << File.expand_path(ele.belong_to_module.real_sv_path)

                if tm.module_name.size > _max_module_name
                    _max_module_name    = tm.module_name.size 
                end 

                if ele.belong_to_module.module_name.size > _max_ref
                    _max_ref  = ele.belong_to_module.module_name.size 
                end 

                if ele.to_s.size > _max_signal_name
                    _max_signal_name = ele.to_s.size 
                end
            end
        end

        collect = ["[%5s]    %-#{_max_module_name}s    %#{_max_ref}s  %-#{_max_signal_name}s    %s" % ['index', 'TEST-MODULE','REF-MODULE','SIGNAL', 'REF-MODULE-PATH'] ] 

        _module_name.each_index do |index|
            collect << "[%5d]    %-#{_max_module_name}s    %#{_max_ref}s  %-#{_max_signal_name}s    %s" % [index+1, _module_name[index], _ref_module_name[index], _signal_name[index], _ref_module_path[index]]
        end

        collect.join("\n")
    end


    def self.gen_dve_tcl(filepath)


    end
end

class TdlTestUnit < TdlBuild 
    # return ClassHDL::AnonyModule.new
    def self.method_missing(method,*args,&block)
        
        sdlm = TestUnitModule.new(name: method,out_sv_path: args[0])

        si = sdlm.input - "from_up_pass"
        so = sdlm.output.logic - "to_down_pass"

        @@package_names ||= []
        sdlm.head_import_packages = []
        sdlm.head_import_packages += @@package_names

        @@package_names.each do |e|
            sdlm.require_package(e,false) if e
        end
        @@package_names = []
        sdlm.instance_exec(&block)

        if args[0] && File.exist?(args[0])
            sdlm.gen_sv_module
        else 
            sdlm.origin_sv = true 
        end
        sdlm
    end

end

class TopModule
    public 
    def add_test_unit(*args)
        @_test_unit_collect_ ||= []
        @_test_unit_collect_ = @_test_unit_collect_ + args
    end

    private 

    def _exec_add_test_unit
        @_test_unit_collect_ ||= []
        args = @_test_unit_collect_
        ## 例化需要的itgt test unit
        # ItegrationVerb.test_unit_inst
        ItegrationVerb.test_unit_inst do |name|
            args.include? name.to_s
        end

        self.techbench.instance_exec(args) do |args|
            index = 0
            last_index = 0
            logic.string        - 'test_unit_region'
            logic[args.size]    - 'unit_pass_u'
            logic[args.size]    - 'unit_pass_d'

            nqq  = args.size <= 1
            args.each do |tu|
                if tu.is_a? SdlModule
                    _inst_name_ = tu.module_name
                else
                    _inst_name_ = tu.to_s 
                end

                # puts _inst_name_
                # puts SdlModule.call_module(_inst_name_).class
                tu_inst = Instance(_inst_name_,"test_unit_#{index}") do |h|
                    h.input.from_up_pass            (nqq ? unit_pass_u : unit_pass_u[index])
                    h.output.logic.to_down_pass     (nqq ? unit_pass_d : unit_pass_d[index])
                end

                tu_inst.origin.be_instanced_by_sim
                # TdlTestUnit.collect_unit tu_inst
                # TopModule.current.test_unit.collect_unit tu_inst

                ## 添加dve wave 信号
                # TopModule.current.test_unit.dve_wave(name: _inst_name_, signals: tu_inst.origin.dve_wave_signals )

                if index == 0
                    Assign do 
                        unless nqq
                            unit_pass_u[index] <= 1.b1 
                        else
                            unit_pass_u <= 1.b1 
                        end
                    end
                else 

                    Assign do 
                        unit_pass_u[index] <= unit_pass_d[last_index]
                    end
                end 
                last_index = index
                index += 1
            end
        end
    end

end