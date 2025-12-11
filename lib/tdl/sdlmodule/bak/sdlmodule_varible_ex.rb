class TryDefXp < DefXp

    # def initialize(sdlmodule)
    #     @sdlmodule = sdlmodule
    # end

    # def var_common(a)
    #     @sdlmodule.var_common(a)
    # end

    def try_call_ele(name)
        @sdlmodule.try_call_ele(name)
    end

    def logic(name:"tmp",dsize:1,port:false,default:nil,msb_high:true,dimension:[],type:"logic",&block)
        a = try_call_ele(name)
        return a if a
        # lg = Logic.new(name:name,dsize:dsize,port:port,default:default,msb_high:msb_high,dimension:dimension,type:type)
        # var_common(lg)
        super(name:name,dsize:dsize,port:port,default:default,msb_high:msb_high,dimension:dimension,type:type,&block)
    end

    def clock(name:"",freqM:100,dsize:1,&block)
        a = try_call_ele(name)
        return a if a
        # a = Clock.new(name:name,freqM:freqM,dsize:dsize)
        # var_common(a)
        super(name:name,freqM:freqM,dsize:dsize,&block)
    end

    def reset(name:"",active:"low",dsize:1,&block)
        a = try_call_ele(name)
        return a if a
        # a = Reset.new(name:name,active:active,dsize:dsize)
        # var_common(a)
        super(name:name,active:active,dsize:dsize,&block)
    end

    def parameter(name:"P",value:100,local:false,type:nil,&block)
        a = try_call_ele(name)
        return a if a
        # a = Parameter.new(name:name,value:value,local:local,port:false,show:true,type:type)
        # var_common(a)
        super(name:name,value:value,local:local,type:type,&block)
    end

    def axilite(name:"axi_lite",clock:nil,reset:nil,dsize:8,asize:8,mode: AxiLite::BOTH,&block)
        a = try_call_ele(name)
        return a if a
        # a = AxiLite.new(name:name,clock:clock,reset:reset,dsize:dsize,asize:asize,mode:mode,port:false)
        # var_common(a)
        super(name:name,clock:clock,reset:reset,dsize:dsize,asize:asize,mode: mode,&block)
    end

    def datainf(name:"data_inf",dsize:8,dimension:[],&block)
        a = try_call_ele(name)
        return a if a
        # a = DataInf.new(name:name,dsize:dsize,dimension:dimension)
        # var_common(a)
        super(name:name,dsize:dsize,dimension:dimension,&block)
    end

    def datainf_c(name:"data_inf_c",clock:nil,reset:nil,dsize:8,dimension:[],&block)
        a = try_call_ele(name)
        return a if a
        # a = DataInf_C.new(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension)
        # var_common(a)
        super(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,&block)
    end

    def axi_stream(name:"test_axis",clock:nil,reset:nil,dsize:8,dimension:[],&block)
        a = try_call_ele(name)
        return a if a
        # a = AxiStream.new(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension)
        # var_common(a)
        super(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,&block)
    end

    def axi4(name:"axi4",clock:nil,reset:nil,dsize:8,idsize:1,asize:8,lsize:8,mode: Axi4::BOTH,addr_step:1.0,&block)
        a = try_call_ele(name)
        return a if a
        # a = Axi4.new(name:name,clock:clock,reset:reset,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,mode:mode,port:false,addr_step:addr_step)
        # var_common(a)
        super(name:name,clock:clock,reset:reset,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,mode: mode,addr_step:addr_step,&block)
    end

    def videoinf(name:"video",dsize:24,clock:nil,reset:nil,dimension:[],&block)
        a = try_call_ele(name)
        return a if a
        # a = VideoInf.new(name:name,dsize:dsize,clock:clock,reset:reset,port:false,force_name:false,dimension:dimension)
        # var_common(a)
        super(name:name,dsize:dsize,clock:clock,reset:reset,dimension:dimension,&block)
    end

    def mailbox(name:'mbox',depth:100,&block)
        a = try_call_ele(name)
        return a if a
        # a = MailBox.new(name:name,depth:depth)
        # var_common(a)
        super(name:name,depth:depth,&block)
    end

end

class SdlModule

    def try_call_ele(name)
        # puts SdlModule.allmodule_name
        if @_add_to_new_module_vars.include?(name.to_s)
            method(name).call
        else
            nil
        end
    end

    def TryDef
        @_trydefxp_ ||= TryDefXp.new(self)
    end

end
