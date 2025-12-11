
class IntegralTest      # test units

end


class TechBench
"
every tdlmodule has only one `TechBench`
every TechBench has multiply `TestModule`s
"
    attr_accessor   :auto_path,:tb_path
    def initialize
        # @top_tb = TestModule.new()
        @modules = []
    end

    def add(tm)
        @modules << tm if tm.is_a? TestModule
    end

    def gen_tb_file(test_module_name)
        @top_connect_elements = []
        @modules.each do |e|
            sub_elements = e.gen_sub_tb_module_file
            @top_connect_elements += sub_elements
        end
        inst(test_module_name)
    end

    # def add_top_unit(type:nil,hash:{})
    #     @modules[0].add_test_unit(type:type,hash:hash)
    # end

    def add_module(name,&block)
        tm = TestModule.new(name,&block)
        @modules << tm
        tm
    end

    private
    def init_clock_reset
        unless @clock_reset
            @clock_reset = TestModule.new("clock_reset_unit_block")
            @modules << @clock_reset
        end
    end

    public

    def add_diff_clock_unit(hash)
        init_clock_reset
        @clock_reset.add_test_unit(type:DiffClockITest,hash:hash)
    end

    def add_clock_unit(hash)
        init_clock_reset
        @clock_reset.add_test_unit(type:ClockITest,hash:hash)
    end

    def add_reset_unit(hash)
        init_clock_reset
        @clock_reset.add_test_unit(type:ResetITest,hash:hash)
    end

    def add_io_unit(hash,&block)
        init_clock_reset
        @clock_reset.add_test_unit(type:IOITest,hash:hash,&block)
    end

    def inst(test_module_name)
        # require_path(auto_path)
        tb_m = TdlModule.new(name:"tb_"+test_module_name)
        tb_m.out_sv_path = tb_path
        #
        target_module = Tdl.send("inst_"+test_module_name.downcase)

        @top_connect_elements.each do |e|
            test_module = bfm_module(e.module_name)
            e.connect(target_module,test_module)
        end

        tb_m.exit_build_module
    end

    def bfm_module(module_name)

        @bfm_modules ||= Hash.new
        if @bfm_modules[module_name]
            @bfm_modules[module_name]
        else
            @bfm_modules[module_name] = Tdl.send("inst_"+module_name.downcase)
        end
    end

end

class TestModule
"
TestModule has multiply test_units
"
    attr_accessor :name

    def initialize(name=nil,&block)
        @items_hash = []
        @name = String.new(GlobalParam.CurrTestTargetModule.module_name).concat("_#{name}")
        # tdlmodule.techbench.add(self) if tdlmodule
        @tdlmodule_block = block
    end

    def add_diff_clock_unit(hash)
        add_test_unit(type:DiffClockITest,hash:hash)
    end

    def add_clock_unit(hash)
        add_test_unit(type:ClockITest,hash:hash)
    end

    def add_reset_unit(hash)
        add_test_unit(type:ResetITest,hash:hash)
    end

    def add_io_unit(hash,&block)
        add_test_unit(type:IOITest,hash:hash,&block)
    end


    def add_test_unit(type:nil,hash:{pin_key:nil},&block)
        @items_hash << [type,hash,block] if type.superclass.eql? IntegralTest
    end

    def add_conn_unit(type:nil,hash:{pin_key:nil})
        add_test_unit(type:type,hash:hash)
    end

    def add_connects(*argvs)
        argvs.each do |e|
            add_test_unit(type:SimpleLogicITest,hash:{pin_key:e})
        end
    end

    def add_wires(*argvs)
        argvs.each do |e|
            add_test_unit(type:SimpleLogicITest,hash:{pin_key:e,type:"wire"})
        end
    end

    def gen_sub_tb_module_file
        # return if @items_hash.empty?
        tb_m = TdlModule.new(name:@name,add_to:DataInf)
        tb_m.out_sv_path = GlobalParam.CurrTestTargetModule.techbench.tb_path
        top_connect_elements = []
        @items_hash.each do |e|
            if e[2]
                new_unit = e[0].new(e[1],&e[2])
            else
                new_unit = e[0].new(e[1])
            end
            tbc = new_unit.tb_top_connect_element
            tbc.module_name = @name
            top_connect_elements << tbc
        end

        # if block_given?
        #     puts "++++++++++++++top_connect_elements"
        #     yield(tb_m)
        # end

        if @tdlmodule_block
            @tdlmodule_block.call(tb_m)
        end

        tb_m.buidl_tdl_to_sv_to_autotdl(autopath:GlobalParam.CurrTestTargetModule.techbench.auto_path)
        top_connect_elements
    end

    # def draw_in_top_tb
    #
    # end

end

class TBConnnectEle
    attr_accessor :type,:baseelm_argv,:port_key,:module_name
    attr_accessor :port_key_n
    def initialize(type:nil)
        @type = type
    end

    def inst_conn
        @type.new(baseelm_argv)
    end

    def connect(target_module,bfm_module)
        bfm_module[port_key] = inst_conn
        target_module[port_key] = bfm_module[port_key]
        ex_connect(target_module,bfm_module)
    end

    def ex_connect(target_module,bfm_module)
        if port_key_n
            target_module[port_key_n] = ~bfm_module[port_key]
        end

    end
end
