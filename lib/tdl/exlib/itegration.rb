class StringBandItegration < String
    attr_accessor :itgt,:origin_str,:key

    def self.add_method_to_itgt(stringbanditegration,obj)
        unless stringbanditegration.is_a? StringBandItegration
            return obj
        end
        stringbanditegration.itgt.check_same_method(stringbanditegration.origin_str)
        stringbanditegration.itgt.check_same_method(stringbanditegration.key)

        stringbanditegration.itgt.define_singleton_method(stringbanditegration.origin_str) do
            obj
        end

        if stringbanditegration.origin_str.to_s != stringbanditegration.key.to_s
            stringbanditegration.itgt.define_singleton_method(stringbanditegration.key) do
                obj
            end
        end
        obj
    end

end



class NameSPoolHash < Hash
    attr_accessor :nickname,:itgt
    alias_method "old_assign","[]="
    alias_method "old_index","[]"

    define_method("[]=") do |a,b|
        old_assign(a.to_s,"#{b.to_s}")
    end

    define_method("[]") do |a|
        b = StringBandItegration.new("#{nickname.to_s}#{old_index(a.to_s)}")
        b.itgt = itgt
        b.origin_str = old_index(a.to_s)
        b.key = a
        return b
    end

    def use_self(a)
        unless old_index(a.to_s)
            send("[]=",a,a)
            send("[]",a)
        else
            send("[]",a)
        end
    end

    def use_selfs(*a)
        a.each do |aa|
            use_self(aa)
        end
    end

    def method_missing(method_id, *arguments)
        m0 = method_id.match(/(?<name>.+)\s*=/)
        # m_self = method_id.match(/^self_(?<name>.+)/)
        # m1 = method_id.match(/(?<name>.+)\s*=/)
        # if m_self
        #     send("[]=",m_self[:name],m_self[:name])
        # elsif m0
        if m0
            # if has_key?(m0[:name])
            # old_assign(m0[:name],arguments[0])
            send("[]=",m0[:name],arguments[0])
        elsif  has_key?(method_id.to_s)
            send("[]",method_id)
        else
            raise TdlError.new("Itegration dont has name #{method_id} in names_pool")
        end
    end

end

class Itegration
'''
the class is for Test Itegration and IP hardware
'''
    attr_accessor :nickname,:names_pool,:api

    def initialize(name_str)
        @api = ItgApi.new
        if name_str.to_s.strip.empty?
            @nickname = ""
        else
            @nickname =  "#{name_str.to_s.strip}_"
        end
        _names_pool_inst()
    end
    private

    def _names_pool_inst
        @names_pool = NameSPoolHash.new
        @names_pool.nickname = @nickname
        @names_pool.itgt = self
    end

    def define_active_behavior(name,*args,&block)
        @api.define_active_behavior(name,*args,&block)
        if respond_to? name
            raise TdlError.new("Itegration already has method `#{name.to_s}`")
        end
        define_singleton_method(name) do
            @api.send(name)
        end
    end

    def define_silence_behavior(name,bind_module,*args,&block)
        @api.define_silence_behavior(name,bind_module,*args,&block)
    end

    def Var(name,&block)
        def_var_func(name)
        a = @api.var(name,&block)
    end

    private

    def def_var_func(name)
        define_singleton_method(name) do
            @api.send(name)
        end
    end

    public

    def check_same_method(name)
        if respond_to? name.to_s
            raise TdlError.new("Itegration can't Redefine method #{name}")
        end
    end

end

class ItgApi
'''
It is parameter for instances of Itegration
'''
    attr_reader :silence_methods
    def initialize(itg:nil)
        @itg = itg
    end

    private

    def before_gen_sv_module_of(bind_module,&block)
        if bind_module.respond_to?(:igt_apis_proc)
            bind_module.igt_apis_proc << block
        else
            bind_module.instance_variable_set("@_igt_apis_",[block])

            bind_module.define_singleton_method("igt_apis_proc") do
                self.instance_variable_get("@_igt_apis_")
            end

            old_gen_sv_module = bind_module.method(:gen_sv_module)

            bind_module.define_singleton_method(:gen_sv_module) do
                self.igt_apis_proc.each do |ias|
                    ias.call
                end
                old_gen_sv_module.call
            end
        end
    end

    public

    def var(name,&block)
        _var = instance_variable_get("@_#{name}")

        if name.to_s.eql? "req_inf"
            puts "#{self.to_s} IN IGT #{_var}"
            puts singleton_methods
        end

        if _var
            return _var
        else
            instance_variable_set("@_#{name}",block.call(self))
            def_var_func(name)
            instance_variable_get("@_#{name}")
        end
    end

    def def_var_func(name)
        self.define_singleton_method(name) do
            instance_variable_get("@_#{name}")
        end
    end

    def define_active_method(name,*args,&block)
        define_singleton_method(name) do
            instance_variable_set("@_#{name}_as_",true)
            block.call(*args)
        end
    end

    def define_active_behavior(name,*args,&block)
        define_active_method(name,*args,&block)
    end

    def define_silence_behavior(name,bind_module,*args,&block)
        before_gen_sv_module_of(bind_module) do
            unless instance_variable_get("@_#{name}_as_")
                block.call(bind_module,*args)
            end
        end
    end

end
## 定义隐性的itgt 这样可以不带参数地调用 to_inp
class ItgtArray < Array 
    def slast  
        # $_implicit_curr_itgt_.instance_variable_set("@_none_",$_implicit_curr_itgt_.last)
        unless @_none_
            return self.last
        else 
            return nil 
        end
    end
    
    def setLast  
        @_none_ = false
    end
    
    def clearLast  
        @_none_ = true
    end
    
    def with_none_itgt(&block)
        clearLast
        rels = yield
        setLast
        rels
    end

    def wrap_nont_itgt(&block)
        _self = self
        # Proc.new do |itgt|
        #     _self.clearLast
        #     rels = block.call
        #     _self.setLast
        #     rels
        # end
        return block
    end
end

$_implicit_curr_itgt_ = ItgtArray.new
class String ## add to itegration names_pool

    def to_inp(itgt=nil)
        if itgt
            itgt.names_pool.use_self(self)
        else
            $_implicit_curr_itgt_.last.names_pool.use_self(self)
        end
    end

    # def of(itgt)
    #     itgt.names_pool[self]
    # end
    #
    # def signal_of(itgt,sdlmodule)
    #     sdlmodule.signal(self.of(itgt))
    # end

    def snoop(itgt=nil,sdlmodule=nil)
        itgt ||= $_implicit_curr_itgt_.last
        if sdlmodule
            # unless sdlmodule.has_signal?(itgt.names_pool[self])
            unless sdlmodule.respond_to?(itgt.names_pool[self])
                if sdlmodule.is_a?(TopModule) && sdlmodule.techbench.respond_to?(itgt.names_pool[self])
                    sdlmodule.techbench.signal(itgt.names_pool[self])
                else 
                    sdlmodule.signal(itgt.names_pool[self])
                    # raise TdlError.new("Dont have `#{itgt.names_pool[self]}` in module <#{sdlmodule.module_name}>" )
                end
            else 
                sdlmodule.signal(itgt.names_pool[self])
            end
        else
            itgt.top_module.signal(itgt.names_pool[self])
        end
   end
end

class Symbol ## add to itegration names_pool

    def to_inp(itgt=nil)
        if itgt
            itgt.names_pool.use_self(self.to_s)
        else
            $_implicit_curr_itgt_.last.names_pool.use_self(self.to_s)
        end
    end

    def snoop(itgt=nil,sdlmodule=nil)
        itgt ||= $_implicit_curr_itgt_.last
        if sdlmodule
            sdlmodule.signal(itgt.names_pool[self.to_s])
        else
            itgt.top_module.signal(itgt.names_pool[self.to_s])
        end
   end
end

'''
Itegration_inst0-
                | - ItgApi_inst0
                | - ItgApi_inst1
                | - ItgApi_instx

'''
