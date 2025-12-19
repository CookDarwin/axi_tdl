class DefXp

    def initialize(sdlmodule)
        @sdlmodule = sdlmodule
    end

    def var_common(a,&block)
        @sdlmodule.var_common(a,&block)
    end

    def add_method_to_itgt(stringbanditegration,obj)
        StringBandItegration.add_method_to_itgt(stringbanditegration,obj)
    end

    def logic(name:"tmp",dsize:1,port:false,default:nil,msb_high:true,dimension:[],type:"logic",&block)
        lg = Logic.new(name:name,dsize:dsize,port:port,default:default,msb_high:msb_high,dimension:dimension,type:type, belong_to_module: @sdlmodule)
        var_common(lg,&block)
        add_method_to_itgt(name,lg)
    end

    def clock(name:"",freqM:100,dsize:1,&block)
        a = Clock.new(name:name,freqM:freqM,dsize:dsize, belong_to_module: @sdlmodule)
        var_common(a,&block)
        add_method_to_itgt(name,a)
    end

    def reset(name:"",active:"low",dsize:1,&block)
        a = Reset.new(name:name,active:active,dsize:dsize, belong_to_module: @sdlmodule)
        var_common(a,&block)
        add_method_to_itgt(name,a)
    end

    def parameter(name:"P",value:100,local:false,type:nil,&block)
        a = Parameter.new(name:name,value:value,local:local,port:false,show:true,type:type, belong_to_module: @sdlmodule)
        var_common(a,&block)
        add_method_to_itgt(name,a)
    end

    # def axilite(name:"axi_lite",clock:nil,reset:nil,dsize:8,asize:8,mode: AxiLite::BOTH,freqM:nil,&block)
    #     a = AxiLite.new(name:name,clock:clock,reset:reset,dsize:dsize,asize:asize,mode:mode,port:false,freqM:freqM)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    # def datainf(name:"data_inf",dsize:8,dimension:[],&block)
    #     a = DataInf.new(name:name,dsize:dsize,dimension:dimension)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    # def datainf_c(name:"data_inf_c",clock:nil,reset:nil,dsize:8,dimension:[],freqM:nil,&block)
    #     a = DataInf_C.new(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,freqM:freqM)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    # alias :data_inf_c :datainf_c

    # def axi_stream(name:"test_axis",clock:nil,reset:nil,dsize:8,dimension:[],freqM:nil,&block)
    #     a = AxiStream.new(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,freqM:freqM)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    # alias :axistream :axi_stream

    # def axi4(name:"axi4",clock:nil,reset:nil,dsize:8,idsize:1,asize:8,lsize:8,mode: Axi4::BOTH,addr_step:1.0,dimension:[],freqM:nil,&block)
    #     a = Axi4.new(name:name,clock:clock,reset:reset,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,mode:mode,port:false,addr_step:addr_step,dimension:dimension,freqM:freqM)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    # def videoinf(name:"video",dsize:24,clock:nil,reset:nil,dimension:[],freqM:nil,&block)
    #     a = VideoInf.new(name:name,dsize:dsize,clock:clock,reset:reset,port:false,freqM:freqM,dimension:dimension)
    #     var_common(a,&block)
    #     add_method_to_itgt(name,a)
    # end

    def mailbox(name:'mbox',depth:100,&block)
        a = MailBox.new(name:name,depth:depth, belong_to_module: @sdlmodule)
        var_common(a,&block)
    end

    def debuglogic(name:"tmp",dsize:1,port:false,default:nil,msb_high:true,dimension:[],type:"logic",&block)
        lg = DebugLogic.new(name:name,dsize:dsize,port:port,default:default,msb_high:msb_high,dimension:dimension,type:type, belong_to_module: @sdlmodule)
        var_common(lg,&block)
        add_method_to_itgt(name,lg)
    end

    def bfm_stream(name:"test_axis",clock:nil,reset:nil,dsize:8,dimension:[],freqM:nil,&block)
        a = BfmStream.new(name:name,clock:clock,reset:reset,dsize:dsize,dimension:dimension,freqM:freqM)
        var_common(a,&block)
    end

end

class SdlModule

    # def Assign(&block)
    #     @aob ||= AssignObject.new(self)
    #     @aob.assign(&block)
    # end

    # def Always(clock:self.clock,reset:self.reset,&block)
    #     ba = BlockAlways.new(self)
    #     # ba.belong_to_module = self
    #     ba.always(clock:clock,reset:reset,&block)
    # end

    # def Always_comb(&block)
    #     ba = BlockAlways.new(self)
    #     # ba.belong_to_module = self
    #     ba.always_comb(&block)
    # end

    # def RootAssign(&block)
    #     @aob ||= RootAssignObject.new(self)
    #     @aob.assign(&block)
    # end


    def Def
        @_defxp_ ||= DefXp.new(self)
    end

    def var_common(a,&block)
        class_v = a.class
        unless self.instance_variable_get("@#{class_v}_collect")
            self.instance_variable_set("@#{class_v}_collect",[])
        end

        unless self.instance_variable_get("@#{class_v}_id")
            self.instance_variable_set("@#{class_v}_id",1)
        end

        a.id = self.instance_variable_get("@#{class_v}_id")
        self.instance_variable_set("@#{class_v}_id",a.id+1)

        a.belong_to_module = self

        self.instance_variable_get("@#{class_v}_collect") << a

        define_ele(a)

        if block_given?
            yield(a)
        end

        a
    end

end

### 添加状态机
class SdlModule

    def StateMachine(name,clock: nil,reset: nil, &block)
        MainStateMachine(name,:clock => clock,:reset => reset,:belong_to_module => self,&block)
    end
end
