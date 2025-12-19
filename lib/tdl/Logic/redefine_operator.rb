require_relative "./../class_hdl/hdl_assign.rb"
require_relative "./../class_hdl/hdl_redefine_opertor.rb"


module RedefOpertor

    def self.with_new_yield_operators(back_to_new_cond:true,&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:new,&block)
    end

    def self.with_new_cond_operators(&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:new,&block)
    end

    def self.with_old_operators(&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old,&block)
    end


    def self.with_normal_operators(&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old,&block)
    end

    def self.return_normal_operators
        ClassHDL::AssignDefOpertor.use_old_cond_opertors
    end

end
