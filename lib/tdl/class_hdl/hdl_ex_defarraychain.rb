"""
DefArrayChain:
    - DefLogicArrayChain:
        - ClockDefLogicArrayChain
        - ResetDefLogicArrayChain
    - DefDataInf_ArrayChain:
        - PortDefDataInf_ArrayChain
    - DefDataInf_C_ArrayChain:
        - DefAxiStream_ArrayChain
            - PortDefAxiStream_ArrayChain:
            - 
        - PortDefDataInf_C_ArrayChain:
    - DefAxiLite_ArrayChain:
        - PortDefAxiLite_ArrayChain
    - DefAxi4_ArrayChain
        - PortDefAxi4_ArrayChain
"""

module TdlSpace 

    module PortDef 

        PORT_SUB_TYPE = [:master,:slaver,:mirror,:out_mirror,:master_wr,:slaver_wr,:master_rd,:slaver_rd,:master_rd_aux,:mirror_rd,:mirror_wr,:master_wr_aux,:master_wr_aux_no_resp]
        PORT_SUB_TYPE.each do |e|
            define_method(e) do |args=[]|
                @sub_type = e
                # @has_args = args
                args.each do |key,value|
                    # send(key,value)
                    self.instance_variable_set("@#{key}",value)
                end
                return self
            end
        end

        def [](*a)
            new_c = super
            new_c.instance_variable_set("@sub_type",@sub_type)
            return new_c
        end

    end

    # class PortDefAxiStream_ArrayChain < DefAxiStream_ArrayChain
    #     include PortDef

    #     def -(name)
    #         yname = to_inp(name)

    #         @dsize = NqString.new("#{yname.to_s}.DSIZE") unless @dsize
    #         a = ::AxiStream.new(name:yname,dsize:@dsize,port:@sub_type.to_s,dimension:@chain,freqM:freqM,belong_to_module: @belong_to_module)
    #         # @belong_to_module.add_to_new_module("@port_axisinfs",a)
    #         StringBandItegration.add_method_to_itgt(name,a)
    #         a
    #     end
        
    # end

    # class PortDefDataInf_ArrayChain < DefDataInf_ArrayChain
    #     include PortDef

    #     def -(name)
    #         yname = to_inp(name)

    #         @dsize = NqString.new("#{yname.to_s}.DSIZE") unless @dsize
    #         # a = super(name)
    #         a = DataInf.new(name:yname,dsize: @dsize,port: @sub_type.to_s,dimension:@chain ,belong_to_module: @belong_to_module)
    #         # @belong_to_module.add_to_new_module("@port_datainfs",a)
    #         StringBandItegration.add_method_to_itgt(name,a)
    #         a
    #     end
    # end

    # class PortDefDataInf_C_ArrayChain < DefDataInf_C_ArrayChain
    #     include PortDef
    #     def -(name)
    #         yname = to_inp(name)

    #         @dsize = NqString.new("#{yname.to_s}.DSIZE") unless @dsize
    #         a = DataInf_C.new(name:yname,dsize:@dsize,port: @sub_type,dimension:@chain,freqM:freqM,belong_to_module: @belong_to_module)
    #         # @belong_to_module.add_to_new_module("@port_datainf_c_s",a)
    #         StringBandItegration.add_method_to_itgt(name,a)
    #         a
    #     end
    # end

    # class PortDefAxiLite_ArrayChain < DefAxiLite_ArrayChain
    #     include PortDef
    #     def -(name)
    #         yname = to_inp(name)


    #         # @dsize = NqString.new("#{name.to_s}.DSIZE") unless @dsize
    #         a = AxiLite.new(name:yname,clock:clock,reset:reset,dsize:dsize,asize:asize,mode:AxiLite::BOTH,port: @sub_type,freqM:freqM,belong_to_module: @belong_to_module)
    #         # @belong_to_module.add_to_new_module("@port_axilinfs",a)
    #         StringBandItegration.add_method_to_itgt(name,a)
    #         a
    #     end
    # end

    # class PortDefAxi4_ArrayChain < DefAxi4_ArrayChain
    #     include PortDef
    #     def -(name)
    #         yname = to_inp(name)

    #         @dsize = NqString.new("#{yname.to_s}.DSIZE")  unless @dsize
    #         @idsize = NqString.new("#{yname.to_s}.IDSIZE")  unless @idsize
    #         @asize = NqString.new("#{yname.to_s}.ASIZE")  unless @asize
    #         @lsize = NqString.new("#{yname.to_s}.LSIZE")  unless @lsize
    #         @clock = NqString.new("#{yname.to_s}.axi_aclk")  unless @clock
    #         @reset = NqString.new("#{yname.to_s}.axi_aresetn")  unless @reset
    #         # @freqM = NqString.new("#{name.to_s}.FreqM")  unless @freqM

    #         a = Axi4.new(name:yname,dsize:dsize,idsize:idsize,asize:asize,lsize:lsize,port:@sub_type,mode:mode,dimension:@chain,freqM:freqM,addr_step: addr_step,belong_to_module: @belong_to_module)

    #         if a.port.eql?(:master_wr) || a.port.eql?(:slaver_wr)
    #             a.mode = Axi4::ONLY_WRITE
    #         elsif a.port.eql?(:master_rd) || a.port.eql?(:slaver_rd)
    #             a.mode = Axi4::ONLY_READ
    #         else
    #             a.mode = Axi4::BOTH
    #         end

    #         # @belong_to_module.add_to_new_module("@port_axi4infs",a)
    #         StringBandItegration.add_method_to_itgt(name,a)
    #         a
    #     end
    # end

    class DefPortArrayChain

        attr_accessor :belong_to_module

        def initialize(belong_to_module)
            @belong_to_module = belong_to_module
        end

        # def axis 
        #     return PortDefAxiStream_ArrayChain.new(belong_to_module: self.belong_to_module)
        # end

        # alias_method :axi_stream_inf,:axis

        # def axi4 
        #     return PortDefAxi4_ArrayChain.new(belong_to_module: self.belong_to_module)
        # end

        # def data 
        #     return PortDefDataInf_ArrayChain.new(belong_to_module: self.belong_to_module)
        # end

        # alias_method :data_inf,:data

        # def data_c 
        #     return PortDefDataInf_C_ArrayChain.new(belong_to_module: self.belong_to_module)
        # end

        # alias_method :data_inf_c,:data_c

        # def axilite 
        #     return PortDefAxiLite_ArrayChain.new(belong_to_module: self.belong_to_module)
        # end

    end 

    class ClockDefLogicArrayChain < DefLogicArrayChain
        attr_accessor :freqM
        def -(name)
            name = to_inp(name)

            belong_to_module.Def.clock(name:name,freqM:@freqM || 100,dsize:@dsize || 1)
        end
    end

    class ResetDefLogicArrayChain < DefLogicArrayChain  
        attr_accessor :active
        def -(name)
            name = to_inp(name)

            belong_to_module.Def.reset(name:name,active: @active || "low",dsize: @dsize || 1)
        end
    end

    class DefLogicArrayChain
        def clock(*args) 
            if args.any?
                if args[0].is_a? Hash 
                    freqM = args[0][:freqM]
                else 
                    freqM = args[0]
                end 
            else  
                freqM = nil
            end

            a = ClockDefLogicArrayChain.new(@belong_to_module)
            a.freqM = freqM

            return a
        end

        def reset(*args) 

            if args.any?
                if args[0].is_a? Hash 
                    active = args[0][:active]
                else 
                    active = args[0]
                end 
            else  
                active = nil
            end

            a = ResetDefLogicArrayChain.new(@belong_to_module)
            a.active = active

            return a

        end
    end
end

class SdlModule
    ## 端口定义
    def port 

        # return ClassHDL::PortDefChain.new(self)
        return TdlSpace::DefPortArrayChain.new(self)
    end

end