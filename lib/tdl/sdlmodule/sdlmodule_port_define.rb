
class InfPort
    attr_accessor :sdlmodule,:infclass
    def initialize(sdlmodule,infclass)
        @infclass = infclass
        @sdlmodule = sdlmodule
    end

    def port_name_chk(name)
        if name.is_a?( String )|| name.is_a?( Symbol)
            return
        else
            raise TdlError.new("Port of #{@sdlmodule.module_name} Type<#{@infclass.to_s}> must be defined in String or Symbol")
        end
    end
end

class SdlModule

    public

    def add_to_new_module(variable="@port_params",new_var)
        _vars = self.instance_variable_get(variable)    # get hash

        define_ele(new_var) ## 给sdlmodule 定义方法，方法名为 new_var.name ,返回new_var对象

        @ports ||=Hash.new

        _vars[new_var.name] = new_var
        @ports[new_var.name] = new_var  unless new_var.is_a? Parameter

        new_var.belong_to_module = self

        add_new_after_inst(new_var) ## 当在sdlmodule里面例化 子sdlmodule时可以通过child_sdlmodule_inst[:key] 访问 子模块的port

        return new_var
    end


    private

    ## -------------------------------------------------------------------------
    def port_name_chk(name)
        if name.is_a?( String )|| name.is_a?( Symbol)
            return
        else
            raise TdlError.new("Port of #{@module_name} must be defined in String or Symbol")
        end
    end
    ## =========================================================================

    def parse_pin_prop(prop=nil)
        return [prop["pins"],prop["iostd"],prop["pulltype"]]
    end

    def add_method_to_itgt(stringbanditegration,obj)
        StringBandItegration.add_method_to_itgt(stringbanditegration,obj)
    end

    public

    def Parameter(name=:NAME,value=0,type:nil,show:true)
    # def Parameter(name=:NAME,value=0,type=nil,show=true)
        port_name_chk(name)
        if value.is_a? Float
            type = :real
        end
        tmp = Parameter.new(name:name.to_s,value:value,port:true,type:type,show:show, belong_to_module: self)
        add_to_new_module("@port_params",tmp)
        add_method_to_itgt(name,tmp)
        tmp
    end

    def Parameters(phash)
        phash.each do |key,value|
            Parameter(name=key,value=value,type=nil)
        end
    end

    def Input(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        port_name_chk(name)
        pin,iostd = parse_pin_prop(pin_prop) if pin_prop
        # RedefOpertor.with_normal_operators do
        #     tmp = Logic.new(name:name,dsize:dsize,port:"input",dimension:dimension)
        #     add_to_new_module("@port_logics",tmp)
        #     add_method_to_itgt(name,tmp)
        #     tmp
        # end
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            tmp = Logic.new(name:name,dsize:dsize,port:"input",dimension:dimension, belong_to_module: self)
            add_to_new_module("@port_logics",tmp)
            add_method_to_itgt(name,tmp)
            tmp
        end
    end

    def Output(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        port_name_chk(name)
        pin,iostd = parse_pin_prop(pin_prop) if pin_prop
        # RedefOpertor.with_normal_operators do
        #     tmp = Logic.new(name:name,dsize:dsize,port:"output",dimension:dimension,type: 'logic')
        #     add_to_new_module("@port_logics",tmp)

        #     if block_given?
        #         yield(tmp)
        #     end
        #     # define_method(name) do
        #     add_method_to_itgt(name,tmp)
        #     tmp
        # end
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            tmp = Logic.new(name:name,dsize:dsize,port:"output",dimension:dimension,type: 'logic', belong_to_module: self)
            add_to_new_module("@port_logics",tmp)

            if block_given?
                yield(tmp)
            end
            # define_method(name) do
            add_method_to_itgt(name,tmp)
            tmp
        end
    end

    def Inout(name,dsize:1,dimension:[],pin:[],iostd:[],pin_prop:nil)
        port_name_chk(name)
        pin,iostd = parse_pin_prop(pin_prop) if pin_prop
        # RedefOpertor.with_normal_operators do
        #     tmp = Logic.new(name:name,dsize:dsize,port:"inout",dimension:dimension,type: '' )
        #     add_to_new_module("@port_logics",tmp)

        #     if block_given?
        #         yield(tmp)
        #     end
        #     # define_method(name) do
        #     add_method_to_itgt(name,tmp)
        #     tmp
        # end
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            tmp = Logic.new(name:name,dsize:dsize,port:"inout",dimension:dimension,type: '' , belong_to_module: self)
            add_to_new_module("@port_logics",tmp)

            if block_given?
                yield(tmp)
            end
            add_method_to_itgt(name,tmp)
            tmp
        end
    end

    def Clock(name,freqM:100,port: :input,pin:[],iostd:[],dsize:1,pin_prop:nil)
        port_name_chk(name)
        pin,iostd = parse_pin_prop(pin_prop) if pin_prop
        a = Clock.new(name:name,freqM:freqM,port:port,dsize:dsize, belong_to_module: self)
        add_to_new_module("@port_clocks",a)

        if block_given?
            yield(a)
        end
        # define_method(name) do
        add_method_to_itgt(name,a)
        a
    end

    def Reset(name,port: :input,active:"low",pin:[],iostd:[],dsize:1,pin_prop:nil)
        port_name_chk(name)
        pin,iostd = parse_pin_prop(pin_prop) if pin_prop
        a = Reset.new(name:name,active:active.to_s.downcase,port:port,dsize:dsize, belong_to_module: self)
        add_to_new_module("@port_resets",a)
        # define_method(name){ a }
        add_method_to_itgt(name,a)
        a
    end

    ## --- DataInf ----
    # Data_inf = Object.new

    # public

    # def DataInf
    #     unless @DataInf
    #         @DataInf = InfPort.new(self,DataInf)

    #         class << @DataInf
    #             def DataInf_port_(name,dsize:8,port: :master,dimension:[])
    #                 port_name_chk(name)
    #                 a = DataInf.new(name:name,dsize:dsize,port:port.to_s,dimension:dimension)
    #                 sdlmodule.add_to_new_module("@port_datainfs",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 a
    #             end
    #         end

    #         [:master,:slaver,:mirror].each do |ty|
    #             @DataInf.define_singleton_method(ty) do |name,dsize:8,dimension:[]|
    #                 DataInf_port_(name,dsize:dsize,port:ty,dimension:dimension)
    #             end
    #         end
    #         @DataInf
    #     else
    #         @DataInf
    #     end
    # end

    ## === DataInf_C ====

    # public

    # def DataInf_C
    #     unless @DataInf_C
    #         @DataInf_C = InfPort.new(self,DataInf_C)
    #         class << @DataInf_C

    #             def DataInf_C_port_(name,dsize:8,port: :master,dimension:[],freqM:nil)
    #                 port_name_chk(name)
    #                 a = DataInf_C.new(name:name,dsize:dsize,port:port.to_s,dimension:dimension,freqM:freqM)
    #                 sdlmodule.add_to_new_module("@port_datainf_c_s",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 a
    #             end
    #         end
    #         [:master,:slaver,:mirror,:out_mirror].each do |ty|
    #             @DataInf_C.define_singleton_method(ty) do |name,dsize:8,dimension:[],freqM:nil|
    #                 DataInf_C_port_(name,dsize:dsize,port:ty,dimension:dimension)
    #             end
    #         end
    #         @DataInf_C
    #     else
    #         @DataInf_C
    #     end
    # end

    ## === DataInf_C ====
    ## === AxiStream ====

    # public

    # def AxiStream
    #     unless @AxiStream
    #         @AxiStream = InfPort.new(self,AxiStream)

    #         class << @AxiStream
    #             def AxiStream_port_(name,dsize:nil,port: :master,dimension:[],freqM:nil)
    #                 port_name_chk(name)
    #                 dsize = NqString.new("#{name.to_s}.DSIZE") unless dsize
    #                 a = AxiStream.new(name:name,dsize:dsize,port:port.to_s,dimension:dimension,freqM:freqM)
    #                 sdlmodule.add_to_new_module("@port_axisinfs",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 # puts a
    #                 a
    #             end
    #         end

    #         [:master,:slaver,:mirror,:out_mirror].each do |ty|
    #             @AxiStream.define_singleton_method(ty) do |name,dsize:nil,dimension:[],freqM:nil|
    #                 AxiStream_port_(name,dsize:dsize,port:ty,dimension:dimension,freqM: freqM)
    #             end
    #         end
    #         @AxiStream
    #     else
    #         @AxiStream
    #     end
    # end
    ## === AxiStream ====
    ## === AxiLite ====


    # def AxiLite
    #     unless @AxiLite
    #         @AxiLite = InfPort.new(self,AxiLite)

    #         class << @AxiLite
    #             def AxiLite_port_(name,asize:8,dsize:32,port: :master,freqM:nil)
    #                 port_name_chk(name)
    #                 a = AxiLite.new(name:name.to_s,clock:nil,reset:nil,dsize:dsize,asize:asize,mode:AxiLite::BOTH,port:port,freqM:freqM)
    #                 sdlmodule.add_to_new_module("@port_axilinfs",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 a
    #             end
    #         end
    #         [:master,:slaver,:master_rd,:master_wr,:slaver_rd,:slaver_wr].each do |ty|
    #             @AxiLite.define_singleton_method(ty) do |name,asize:8,dsize:32,port: :master,dimension:[],freqM:nil|
    #                 AxiLite_port_(name,dsize:dsize,port:ty,asize:asize)
    #             end
    #         end
    #         @AxiLite
    #     else
    #         @AxiLite
    #     end
    # end
    ## === AxiLite ====
    ## === AXI 4 ======

    # public
    # def Axi4
    #     unless @Axi4
    #         @Axi4 = InfPort.new(self,Axi4)

    #         class << @Axi4
    #             def Axi4_port_(name, dsize: nil,idsize: nil,asize: nil,lsize: nil,port: :master,dimension: [],freqM: nil,addr_step:  1.0)
    #                 port_name_chk(name)
    #                 dsize = NqString.new("#{name.to_s}.DSIZE")  unless dsize
    #                 idsize = NqString.new("#{name.to_s}.IDSIZE")  unless idsize
    #                 asize = NqString.new("#{name.to_s}.ASIZE")  unless asize
    #                 lsize = NqString.new("#{name.to_s}.LSIZE")  unless lsize
    #                 if port.eql?(:master_wr) || port.eql?(:slaver_wr)
    #                     mode = Axi4::ONLY_WRITE
    #                 elsif port.eql?(:master_rd) || port.eql?(:slaver_rd)
    #                     mode = Axi4::ONLY_READ
    #                 else
    #                     mode = Axi4::BOTH
    #                 end
    #                 # a = Axi4.new(name:"#{name.to_s}",clock:NqString.new("#{name.to_s}.axi_aclk"),reset:NqString.new("#{name.to_s}.axi_aresetn"),dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,port:port,mode:mode,dimension:dimension,freqM:freqM)
    #                 a = Axi4.new(name:"#{name.to_s}",dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,port:port,mode:mode,dimension:dimension,freqM:freqM,addr_step: addr_step)
    #                 sdlmodule.add_to_new_module("@port_axi4infs",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 a
    #             end
    #         end
    #         [:master,:slaver,:master_wr,:slaver_wr,:master_rd,:slaver_rd,:master_rd_aux,:mirror_rd,:mirror_wr,:master_wr_aux,:master_wr_aux_no_resp].each do |ty|
    #             @Axi4.define_singleton_method(ty) do |name,dsize:nil,idsize:nil,asize:nil,lsize:nil,dimension:[],freqM:nil,addr_step: 1.0|
    #                 Axi4_port_(name,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,port: ty,dimension:dimension,freqM: freqM,addr_step: addr_step)
    #             end
    #         end
    #         @Axi4
    #     else
    #         @Axi4
    #     end
    # end
    ## === AXI 4 ======
    ## === VideoInf ====

    # def VideoInf
    #     unless @VideoInf
    #         @VideoInf = InfPort.new(self,VideoInf)

    #         class << @VideoInf
    #             def VideoInf_port_(name,dsize:24,clock:nil,reset:nil,port:false,dimension:[],freqM:nil)
    #                 port_name_chk(name)
    #                 a = VideoInf.new(name:name,dsize:dsize,clock:clock,reset:reset,port:port,dimension:dimension,freqM:freqM)
    #                 sdlmodule.add_to_new_module("@port_videoinfs",a)
    #                 if block_given?
    #                     yield(a)
    #                 end
    #                 StringBandItegration.add_method_to_itgt(name,a)
    #                 a
    #             end
    #         end
    #         [:master,:slaver,:compact_in,:compact_out].each do |ty|
    #             @VideoInf.define_singleton_method(ty) do |name,dsize:24,clock:nil,reset:nil,port:false,dimension:[],freqM:nil|
    #                 VideoInf_port_(name,dsize:dsize,clock:clock,reset:reset,port:port,dimension:dimension)
    #             end
    #         end
    #         @VideoInf
    #     else
    #         @VideoInf
    #     end
    # end
    ## === AxiLite ====
end
