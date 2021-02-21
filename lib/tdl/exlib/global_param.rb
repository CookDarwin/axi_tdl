class GlobalParam
    @@sim = false
    @@tdlmodule = nil
    @@tdlmodule_stack = []      #push when create TdlModule,pop when Tdl.clear
    @@sdlmodule_stack = []
    # @@curr_is_tb_module = nil
    # @@last_module_instance_name = nil

    def self.sim
        @@sim
    end

    def self.sim=(a)
        @@sim = a
    end

    def self.CurrTdlModule
        # @@tdlmodule
        ctm = @@tdlmodule_stack.last
        unless ctm
            @@etm ||= EmptyModule.new
        else
            ctm
        end
    end

    # def self.CurrTdlModule=(a)
    #     @@tdlmodule = a
    # end

    # def self.RootHierModule
    #     str = NqString.new("$root.")
    #     @@tdlmodule_stack.each do |e|
    #         str.concat(String.new(e))
    #     end
    # end

    def self.PushTdlModule(a)
        #bind PackClassVars
        @@tdlmodule_stack << a
        unless self.CurrTBMode
            self.CurrTestTargetModule ||= a  # only first tdlmodule can be Target
        end
        a
    end

    def self.PopTdlModule
        @@tdlmodule_stack.pop
    end
    # def self.CurrTBMode
    #     @@curr_is_tb_module
    # end

    # def self.CurrTBMode=(a)
    #     @@curr_is_tb_module(a)
    # end

    def self.CurrSdlModule
        # @@tdlmodule
        ctm = @@sdlmodule_stack.last
        unless ctm
            @@sdl_etm ||= EmptyModule.new
        else
            ctm
        end
    end

    def self.PushSdlModule(a)
        #bind PackClassVars
        @@sdlmodule_stack << a
        unless self.CurrTBMode
            self.CurrTestTargetModule ||= a  # only first tdlmodule can be Target
        end
        a
    end

    def self.PopSdlModule
        @@sdlmodule_stack.pop
    end

    def self.define_global(name,default_value)
        self.class_variable_set("@@"+name.to_s,default_value)

        self.define_singleton_method(name.to_s) do
            self.class_variable_get("@@"+name.to_s)
        end

        self.define_singleton_method(name.to_s+"=") do |a|
            self.class_variable_set("@@"+name.to_s,a)
        end
    end

    define_global("CurrTBMode",nil)

    define_global("CurrTestTargetModule",nil)

    define_global("LastModuleInstName",nil)

    define_global("CurrHash",nil)

end

class EmptyModule

    def BindEleClassVars
        @pcv ||= PackClassVars.new
    end
end
