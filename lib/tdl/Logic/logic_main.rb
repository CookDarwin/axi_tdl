$__tdl_cur_self__ = self

def check_same_name_method(name)
    raise TdlError.new("\n 'Method' Name Error ,#{name} Can't be defined,because it has same name\n") if self.methods.include? name.to_sym
end

class Logic
    # @@logic_expression = []
    # @@logic_expression_def = []
    # @@logic_expression_record = []
    #
    # @@condition_expression = []

    attr_accessor :clock,:reset

    # def @@logic_expression_record.[](key)
    #     return true if @@logic_expression_record.include? key
    #
    #     @@logic_expression_record << key
    #
    #     return false
    #
    # end

    # def GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_record.[](key)
    #     return true if GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_record.include? key
    #
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.logic_expression_record << key
    #
    #     return false
    #
    # end


    # def self.lazy_def_exec
    #     expression_iteration()
    #     def_str = @@logic_expression_def.join("\n")
    #     # puts exp_str
    #     def_str
    # end

    # def self.lazy_def_exec
    #     expression_iteration()
    #     def_str = GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def.join("\n")
    #     # puts exp_str
    #     def_str
    # end

    # def self.lazy_inst_exec
    #     # expression_iteration()
    #     exp_str = @@logic_expression.join("\n")
    #     cexp_str = @@condition_expression.map{|e| e.call }.join("\n")
    #     @@logic_expression = []
    #     @@logic_expression_def = []
    #     @@logic_expression_record = []
    #     @@condition_expression = []
    #     # puts exp_str
    #     exp_str + cexp_str
    # end

    # def self.lazy_inst_exec
    #     # expression_iteration()
    #     exp_str =  GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression.join("\n")
    #     cexp_str = GlobalParam.CurrTdlModule.BindEleClassVars.Logic.condition_expression.map{|e| e.call }.join("\n")
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression = []
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def = []
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_record = []
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.condition_expression = []
    #     # puts exp_str
    #     exp_str + cexp_str
    # end


    # def self.expression_iteration(depth=0)
    #     raise TdlError.new("LOGIC_EXPRESSION ITERATION too depth #{depth} !!") if depth > 10
    #     def_iteration = false
    #     e_iteration = false
    #
    #     @@logic_expression_def.map! do |e|
    #         if e.is_a? Proc
    #             d = e.call
    #         else
    #             d = e.to_s
    #         end
    #
    #         if d.is_a? Proc
    #             def_iteration = true
    #         end
    #
    #         d
    #     end
    #
    #     @@logic_expression.map! do |e|
    #         if e.is_a? Proc
    #             d = e.call
    #         else
    #             d = e.to_s
    #         end
    #
    #         if d.is_a? Proc
    #             e_iteration = true
    #         end
    #         d
    #     end
    #
    #     if e_iteration || def_iteration
    #         expression_iteration(depth+1)
    #     end
    # end

    # def self.expression_iteration(depth=0)
    #     raise TdlError.new("LOGIC_EXPRESSION ITERATION too depth #{depth} !!") if depth > 10
    #     def_iteration = false
    #     e_iteration = false
    #
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression_def.map! do |e|
    #         if e.is_a? Proc
    #             d = e.call
    #         else
    #             d = e.to_s
    #         end
    #
    #         if d.is_a? Proc
    #             def_iteration = true
    #         end
    #
    #         d
    #     end
    #
    #     GlobalParam.CurrTdlModule.BindEleClassVars.Logic.expression.map! do |e|
    #         if e.is_a? Proc
    #             d = e.call
    #         else
    #             d = e.to_s
    #         end
    #
    #         if d.is_a? Proc
    #             e_iteration = true
    #         end
    #         d
    #     end
    #
    #     if e_iteration || def_iteration
    #         expression_iteration(depth+1)
    #     end
    # end


    # def signal_proc(a)
    #     if a.is_a? Proc
    #         a.call
    #     else
    #         a.to_s
    #     end
    # end

    def exp_element(b)
        if b.is_a? Proc
            b.call
        else
            b.to_s
        end
    end

    def self.exp_element(b)
        if b.is_a? Proc
            b.call
        else
            b.to_s
        end
    end
end

# class Logic
#
#     # def self.add_ex_expression(a)
#     #     @@condition_expression ||= []
#     #     raise TdlError.new("Logic Expression Must bee Lambda") unless a.is_a? Proc
#     #     @@condition_expression.push a
#     # end
#
#     def self.add_ex_expression(a)
#         GlobalParam.CurrTdlModule.BindEleClassVars.Logic.condition_expression ||= []
#         raise TdlError.new("Logic Expression Must bee Lambda") unless a.is_a? Proc
#         GlobalParam.CurrTdlModule.BindEleClassVars.Logic.condition_expression.push a
#     end
#
# end
