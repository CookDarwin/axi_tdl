
class Logic

    def Initial(&block)
        @_lg_init_tap_cnt_ = 1
        @_init_exec_stack = []
        yield(self)
        str = initial_block(@_init_exec_stack.join())
        # Logic.add_ex_expression(lambda { str })
        belong_to_module.Logic_draw << str
    end

    def init_assign(value)
        vstr = RedefOpertor.with_normal_operators do
            with_new_align(0) do
                align_signal(value,q_mark=false)
            end
        end
        @_init_exec_stack << "#{logic_init_tap}#{signal} = #{vstr};\n"
    end

    def init_exec(str)
        @_init_exec_stack << "#{logic_init_tap}#{str};\n"
    end

    def repeat(num=0,&block)
        if num > 0
            @_init_exec_stack << "#{logic_init_tap}repeat(#{num.to_s}) begin\n"
        else
            @_init_exec_stack << "#{logic_init_tap}forever begin\n"
        end
        @_lg_init_tap_cnt_ += 1
        yield
        @_lg_init_tap_cnt_ -= 1
        @_init_exec_stack << "#{logic_init_tap}end\n"
    end

    private

    def logic_init_tap
        "#{'    '*@_lg_init_tap_cnt_}"
    end

    def initial_block(str)
        @_init_index_ ||=0
"
initial begin:#{signal(square:false)}_INIT_BLOCK_#{@_init_index_ += 1}
#{str}
end
"
    end
end
