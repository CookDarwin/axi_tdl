
module HDLClass
    class ImplicitInstParam
        attr_accessor :local,:vcs_string
        def initialize(sdlm)
            @sdlm = sdlm
            @type = nil
        end

        def [](num)
            @type = "[#{num}-1:0]"
            self
        end

        def real
            @type = 'real'
            return self 
        end

        def int 
            @type = 'int'
            return self 
        end

        # def -(name)
        #     @sdlm.Parameter(name,value=0,type:nil,show:true)
        # end

        def method_missing(name,*args,&block)
            if name !~ /\w+/
                raise TdlError.new("cont define parameter name #{name}")
            end
            if args.any?
                unless local
                    relp = @sdlm.Parameter(name,args[0],type:@type,show:true)
                else 
                    relp = @sdlm.Def.parameter(name: name,value: args[0],local:true,type:@type)
                end
                if vcs_string
                    relp.vcs_string = vcs_string
                end
                relp
            else 
                @sdlm.public_send(name)
            end
        end
    end
end

class SdlModule 


    def parameter 
        return HDLClass::ImplicitInstParam.new(self)
    end

    alias_method :param,:parameter

    def localparam
        a = HDLClass::ImplicitInstParam.new(self)
        a.local = true
        return a
    end

    def vcs_string(total=64,local=false)
        a = HDLClass::ImplicitInstParam.new(self)
        self.macro_add_vcs
        a.vcs_string = total
        a.local = local
        return a
    end

end