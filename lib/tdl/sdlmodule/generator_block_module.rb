
class GenBlockModule < SdlModule
    attr_accessor :belong_to_module
    def initialize(name: "GenBlock",belong_to_module:nil)
        super(name:"#{name}")
        @dont_gen_sv = true

        @belong_to_module = belong_to_module
    end

    public

    def If(nq_operation,&block)
        @_if_collect_str_ ||= ""
        @_if_collect_str_ += gen_if("if",nq_operation,&block)
    end

    def ElsIf(nq_operation,&block)
        @_if_collect_str_ += gen_if("else if",nq_operation,&block)
    end

    def Else(&block)
        @_if_collect_str_ += gen_if("else",nil,&block)
    end

    def if_block(&block)
        head_str = "//-----------------------------------------------------------\n"
        end_str =  "//===========================================================\n"
        @_if_sub_gen_block_module_id ||= 0
        tmp_sm = GenBlockModule.new(name:"#{@belong_to_module.module_name}_generator_if_block_#{@_if_sub_gen_block_module_id}",belong_to_module:self)# SUB MODULE
        @_if_sub_gen_block_module_id += 1
        yield(tmp_sm)
        GenInnerStr.new(head_str.concat(tmp_sm.gen_if_block_str).concat(end_str))
    end

    def gen_if_block_str
        @_if_collect_str_.gsub!(/^./) do |m|
            "#{'    '*$generate_tap_igt}#{m}"
        end
    end

    private

    def if_parent_module_chk
        raise TdlError.new "Which module use GenBlockModule of 'if' must be a GenBlockModule" unless @belong_to_module.is_a? GenBlockModule
    end

    def gen_if(if_type,nq_operation,&block)
        if_parent_module_chk
        tmp_sm = GenBlockModule.new(name:"#{@belong_to_module.belong_to_module.module_name}_#{@belong_to_module.module_name}_generator_#{if_type}",belong_to_module:@belong_to_module)
        $generate_tap_igt += 1
        gstr = yield(tmp_sm)
        $generate_tap_igt -= 1
        str = ""

        if gstr.is_a? GenInnerStr
            str += gstr
        end

        str += (tmp_sm.instance_draw + tmp_sm.vars_exec_inst)
        # belong_to_module.Logic_inst << tmp_sm.vars_define_inst
        generator_if_block(if_type,nq_operation,str)
    end

    def generator_if_block(if_type,nq_operation,str)
        if nq_operation
            nq_operation_str = "(#{nq_operation})"
        else
            nq_operation_str = " "
        end

        if if_type.eql?("if")
            # head_str = ":#{@belong_to_module.module_name}_GENERATOR_IF"
            head_str = ""
        else
            head_str = ""
        end

"#{if_type}#{nq_operation_str}begin#{head_str}
#{str.gsub!(/^./){|m| "    #{m}"}}
end #{(if_type.eql?('else'))? "\n" : ""}"
    end

end
