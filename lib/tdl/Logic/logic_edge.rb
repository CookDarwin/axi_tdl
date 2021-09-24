

class Logic     ## EDGE METHOD
    def raising(name: nil, cnt: 1,clock: nil,reset: 1.b1 )

        # if cnt==1 && clock == nil && reset==nil && @raising_record
        #     return @raising_record
        # end

        @logic_expression_record ||= Hash.new
        str = ""
        # RedefOpertor.with_normal_operators do
            @clock = clock if clock
            @reset = reset if reset

            head_str = ""
            end_str = ""
            # RedefOpertor.with_normal_operators do
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                head_str =
                "\n//====>>>> #{signal} RAISING EDGE <<<<#{"="*(60-6-signal.length)}\n"
                end_str =
                "\n//----<<<< #{signal} RAISING EDGE >>>>#{"-"*(60-6-signal.length)}\n"

                # @@logic_expression << lambda{ head_str }
                # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ head_str }
                belong_to_module.Logic_draw << head_str
                inst_edge(@clock,@reset)
                unless name 
                    if cnt>1
                        inst_raise_edge_cnt(cnt-1)
                        str = inst_cnt_edge_signal(cnt-1,:raise)
                    else
                        str = "#{signal}_raising"
                    
                    end
                else 
                    if cnt>1
                        inst_raise_edge_cnt(cnt-1)
                    end
                    str = name 
                end
                # @@logic_expression << lambda{ end_str }
                # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ end_str }
                belong_to_module.Logic_draw << end_str
            end

        # if cnt==1 && clock == nil && reset==nil
        #     @raising_record = str.to_nq
        # end

        return str.to_nq
    end

    def falling(cnt:1,clock:nil,reset:nil)
        @logic_expression_record ||= Hash.new
        @clock = clock if clock
        @reset = reset if reset
        head_str = ""
        end_str = ""
        str = ""
        # RedefOpertor.with_normal_operators do
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do

            head_str =
            "\n//====>>>> #{signal} FEDGE <<<<#{"="*(60-6-signal.length)}\n"
            end_str =
            "//----<<<< #{signal} FEDGE >>>>#{"-"*(60-6-signal.length)}\n"
        # end
            # @@logic_expression << lambda{ head_str }
            # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ head_str }
            belong_to_module.Logic_draw << head_str

            inst_edge(@clock,@reset)
            if cnt>1
                inst_fall_edge_cnt(cnt-1)
                str =  inst_cnt_edge_signal(cnt-1,:fall)
            else
                str = "#{signal}_falling"
            end
            # @@logic_expression << lambda{ end_str }
            # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda{ end_str }
            belong_to_module.Logic_draw << end_str
        end
        return str.to_nq
    end

    private

    def inst_cnt_edge_signal(cnt=1,type=:raise)
        return "#{signal}_#{cnt}_#{type}" if @logic_expression_record["#{cnt}_#{type}"]
#         @@logic_expression_def << lambda {"logic #{signal}_#{cnt}_#{type};"}
#         @@logic_expression << lambda {
# "
# assign #{signal}_#{cnt}_#{type} = #{signal}_edge_#{type}_cnt==#{cnt};
# "}
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def << lambda {"logic #{signal}_#{cnt}_#{type};"}
        belong_to_module.Logic_inst << "logic #{signal}_#{cnt}_#{type};"
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda {
        # "
        # assign #{signal}_#{cnt}_#{type} = #{signal}_edge_#{type}_cnt==#{cnt};
        # "}
        belong_to_module.Logic_draw << "assign #{signal}_#{cnt}_#{type} = #{signal}_edge_#{type}_cnt==#{cnt};"

        return "#{signal}_#{cnt}_#{type}"
    end

    def inst_edge(clock,reset)
        return "" if @logic_expression_record[:inst_edge]

        raise TdlError.new("#{@name} DSIZE[#{@dsize}] dont eq 1 ") unless @dsize == 1
# @@logic_expression_def << lambda {
#         GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def << lambda {
# "
# logic  #{signal}_raising;
# logic  #{signal}_falling;
# "}
#         belong_to_module.Logic_inst << lambda {
# "
# logic  #{signal}_raising;
# logic  #{signal}_falling;
# "}
        belong_to_module.Def().logic(name:"#{signal}_raising")
        belong_to_module.Def().logic(name:"#{signal}_falling")
# @@logic_expression << lambda {
# GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda {
    belong_to_module.Logic_draw << lambda {
    large_name_len("0"*36)
"
edge_generator #{signal}edge_generator_inst(
/* input        */  .clk        (#{align_signal(clock,q_mark=false)}),
/* input        */  .rst_n      (#{align_signal(reset,q_mark=false)}),
/* input        */  .in         (#{align_signal(signal,q_mark=false)}),
/* output       */  .raising    (#{align_signal(signal+"_raising",q_mark=false)}),
/* output       */  .falling    (#{align_signal(signal+"_falling",q_mark=false)})
);"}
    return ""
    end

    def raising_edge(cnt=1)
        if cnt==1
            return  "#{signal}_raising"
        else

        end
    end

    def inst_raise_edge_cnt(cnt=1)
        count = cnt if count==nil || cnt > count
        return "" if @logic_expression_record[:inst_raise_edge_cnt]
        inst_edge_cnt(count,:raise)
    end

    def inst_fall_edge_cnt(cnt=1)
        count = cnt if count==nil || cnt > count
        return "" if @logic_expression_record[:inst_fall_edge_cnt]
        inst_edge_cnt(count,:fall)
    end

    def inst_edge_cnt(cnt=1,type=:raise)
        clock_tri = ""
        rst_tri = ""
        rst_assign = "if(0)"
        with_new_align(0) do
            clock_tri = "posedge #{align_signal(@clock,q_mark=false)}"
            if @reset
                if ((@reset.respond_to?(:active)) && (@reset.active.downcase.eql? "high"))
                    rst_tri = ",posedge #{align_signal(@reset,q_mark=false)}"
                    rst_assign = "if(#{align_signal(@reset,q_mark=false)})"
                else
                    rst_tri = ",negedge #{align_signal(@reset,q_mark=false)}"
                    rst_assign = "if(~#{align_signal(@reset,q_mark=false)})"
                end
            else
                rst_tri = ""
                rst_assign = "if(0)"
            end
        end
        # @@logic_expression_def << lambda {
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def << lambda {
        belong_to_module.Logic_inst << lambda {
"
logic [#{cnt.clog2}-1:0] #{signal}_edge_#{type}_cnt;
"}
        # @@logic_expression << lambda {
        # GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression << lambda {
        belong_to_module.Logic_draw << lambda {
"
always@(#{clock_tri}#{rst_tri})
    #{rst_assign}  #{signal}_edge_#{type}_cnt   <= '0;
    else begin
        if(#{type==:raise ? "#{signal}_raising" : "#{signal}_falling"})begin
            if(#{signal}_edge_#{type}_cnt == '1)
                    #{signal}_edge_#{type}_cnt   <= #{signal}_edge_#{type}_cnt;
            else    #{signal}_edge_#{type}_cnt   <= #{signal}_edge_#{type}_cnt + 1'b1;
        end else    #{signal}_edge_#{type}_cnt   <= #{signal}_edge_#{type}_cnt;
    end
"}
    end


end
