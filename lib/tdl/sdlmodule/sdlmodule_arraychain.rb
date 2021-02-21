
"""
DefArrayChain:
    - DefLogicArrayChain:
    - DefDataInf_ArrayChain:
    - DefDataInf_C_ArrayChain:
        - DefAxiStream_ArrayChain
    - DefAxiLite_ArrayChain:
    - DefAxi4_ArrayChain
"""

module TdlSpace 

    class DefArrayChain

        attr_accessor :chain,:belong_to_module

        def initialize(belong_to_module)
            @chain = []
            @belong_to_module = belong_to_module
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(@belong_to_module)
            new_dla.chain = @chain + a
            new_dla
        end

        def -(name)
            raise TdlError.new(" Base Class cant define anything!!!")
            # if name.is_a? StringBandItegration
            #     raise TDLError.new("简化定义模式不允许传入 StringBandItegration 类型")
            # end
        end

        def check_name(name)
            check_topmodule_method(name)
            if name.is_a? StringBandItegration
                raise TdlError.new("简化定义模式不允许传入 StringBandItegration 类型")
            end
        end

        def to_inp(name)
            check_name(name)
            if $_implicit_curr_itgt_.slast
                yname = name.to_inp($_implicit_curr_itgt_.last)
            else 
                yname = name 
            end
            return yname 
        end 

        def method_missing(name,*args,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                if name !~ /\w+/
                    super 
                end

                if args && args.any? && args[0].is_a?(Hash)
                    args[0].each do |key,value|
                        self.instance_variable_set("@#{key}",value)
                    end
                end

                self - name
            end
        end

        ## 简化模式定义时 打通topmodule 和 itgt 方法连接，需要topmodule没有定义同名方法
        def check_topmodule_method(name)
            if $_implicit_curr_itgt_.slast.respond_to?('top_module') && $_implicit_curr_itgt_.slast.top_module.respond_to?(name)
                raise TdlError.new("TopModule[#{$_implicit_curr_itgt_.slast.top_module.module_name}] 已经定义了方法 [#{name}],Itgt 不能定义新方法#{name},以免发生混淆")
            end
        end

    end 


    class DefLogicArrayChain < DefArrayChain
        
        def -(name)
            if @chain.length > 1
                dimension = @chain[0,@chain.length-1]
            else 
                dimension = []
            end
            name = to_inp(name)
            belong_to_module.Def.logic(name: name,dsize: @chain.last || 1,dimension: dimension,type: @type || 'logic')
        end

        def wire 
            @type = 'wire'
            return self 
        end

        def tri0 
            @type = 'tri0'
            return self 
        end

        def tri1 
            @type = 'tri1'
            return self 
        end

        def integer 
            @type = 'integer'
            return self 
        end

        def string 
            @type = "string"
            return self 
        end
    end 

    class DefDebugLogicArrayChain < DefArrayChain
        
        def -(name)
            if @chain.length > 1
                dimension = @chain[0,@chain.length-1]
            else 
                dimension = []
            end
            name = to_inp(name)
            belong_to_module.Def.debuglogic(name: name,dsize: @chain.last || 1,dimension: dimension,type: @type || 'logic')
        end

        def wire 
            @type = 'wire'
            return self 
        end

    end 

    class DefGenVar < DefArrayChain
        def -(name)
            if @chain.length > 1
                dimension = @chain[0,@chain.length-1]
            else 
                dimension = []
            end
            name = to_inp(name)
            belong_to_module.Def.logic(name: name,dsize: @chain.last || 1,dimension: dimension,type: 'genvar')
        end
    end

    class DefDataInf_ArrayChain < DefArrayChain
        attr_accessor :dsize
        def initialize(belong_to_module: nil,dsize: 8)
            super(belong_to_module)
            @dsize = dsize 
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(belong_to_module: @belong_to_module,dsize: @dsize)
            new_dla.chain = @chain + a
            new_dla
        end
        
        def -(name,dsize: nil )
            name = to_inp(name)
            belong_to_module.Def.datainf_c(name: name ,dsize: dsize||@dsize,dimension: @chain)
        end
    end

    class DefDataInf_C_ArrayChain < DefArrayChain
        attr_accessor :dsize,:freqM,:clock,:reset
        def initialize(belong_to_module: nil,dsize: nil,freqM: nil,clock: nil,reset: nil)
            super(belong_to_module)
            @dsize = dsize 
            @freqM = freqM
            @clock = clock 
            @reset = reset
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(belong_to_module: @belong_to_module,clock: @clock,reset:@reset,freqM: @freqM,dsize: @dsize)
            new_dla.chain = @chain + a
            new_dla
        end
        
        def -(name,clock: nil,reset: nil,freqM: nil,dsize: nil )
            name = to_inp(name)

            belong_to_module.Def.datainf_c(name: name ,clock: clock||@clock,reset: reset||@reset ,dsize: dsize||@dsize ,dimension: @chain,freqM:freqM||@freqM)
        end
    end

    class DefAxiStream_ArrayChain < DefDataInf_C_ArrayChain
        def -(name,clock: nil,reset: nil,freqM: nil,dsize: nil )
            name = to_inp(name)

            belong_to_module.Def.axi_stream(name: name ,clock: clock||@clock,reset: reset||@reset ,dsize: dsize||@dsize ,dimension: @chain,freqM:freqM||@freqM)
        end
    end

    class DefAxiLite_ArrayChain < DefArrayChain
        attr_accessor :dsize,:freqM,:clock,:reset,:asize,:mode
        def initialize(belong_to_module: nil,clock: nil,reset: nil,dsize: 8,asize: 8,mode: AxiLite::BOTH,freqM: nil)
            super(belong_to_module)
            @dsize = dsize 
            @freqM = freqM
            @clock = clock 
            @reset = reset
            @asize = asize
            @mode = mode
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(belong_to_module: @belong_to_module,clock: @clock,reset:@reset,freqM: @freqM,dsize: @dsize,asize: @asize,mode: @mode)
            new_dla.chain = @chain + a
            new_dla
        end

        def -(name,clock: nil,reset: nil,freqM: nil,dsize: nil,asize: nil,mode: nil)
            name = to_inp(name)

            belong_to_module.Def.axilite(
                name: name ,
                clock: clock||@clock,
                reset: reset||@reset ,
                dsize: dsize||@dsize ,
                # dimension: @chain,
                asize: asize || @asize,
                mode: mode || @mode,
                freqM:freqM||@freqM)
        end

    end

    class DefAxi4_ArrayChain < DefArrayChain
        attr_accessor :dsize,:freqM,:clock,:reset,:idsize,:asize,:lsize,:mode,:addr_step
        def initialize(belong_to_module: nil,clock: nil,reset: nil,dsize: 8,asize: 8,lsize:8,idsize:1,addr_step: 1.0,mode: Axi4::BOTH,freqM: nil)
            super(belong_to_module)
            @dsize = dsize 
            @freqM = freqM
            @clock = clock 
            @reset = reset
            @asize = asize
            @mode = mode
            @lsize = lsize 
            @idsize = idsize 
            @addr_step = addr_step
        end

        def [](*a)
            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(
                belong_to_module: @belong_to_module,
                clock: @clock,
                reset:@reset,
                freqM: @freqM,
                dsize: @dsize,
                idsize: @idsize,
                lsize: @lsize,
                addr_step: @addr_step,
                asize: @asize,
                mode: @mode)
            new_dla.chain = @chain + a
            new_dla
        end

        def -(name,clock: nil,reset: nil,freqM: nil,dsize: nil,asize: nil,mode: nil,lsize: nil,idsize: nil,addr_step: nil)
            name = to_inp(name)

            belong_to_module.Def.axi4(
                name: name ,
                clock: clock||@clock,
                reset: reset||@reset ,
                dsize: dsize||@dsize ,
                dimension: @chain,
                asize: asize || @asize,
                mode: mode || @mode,
                lsize: lsize || @lsize,
                idsize: idsize || @idsize,
                addr_step: addr_step || @addr_step,
                freqM:freqM||@freqM)
        end

    end

end

class SdlModule

    def logic 
        TdlSpace::DefLogicArrayChain.new(self)
    end

    def debugLogic
        TdlSpace::DefDebugLogicArrayChain.new(self)
    end

    def genvar 
        TdlSpace::DefGenVar.new(self)
    end

    # def data_inf_c(dsize: 8,freqM: nil,clock: nil,reset: nil)
    #     TdlSpace::DefDataInf_C_ArrayChain.new(belong_to_module: self,clock: clock,reset: reset,freqM: freqM,dsize: dsize)
    # end

    # def data_inf(dsize:8)
    #     TdlSpace::DefDataInf_ArrayChain.new(belong_to_module: self,dsize: dsize)
    # end

    # def axi_stream_inf(dsize: 8,freqM: nil,clock: nil,reset: nil)
    #     TdlSpace::DefAxiStream_ArrayChain.new(belong_to_module: self,clock: clock,reset: reset,freqM: freqM,dsize: dsize)
    # end

    # def axi_lite_inf(clock: nil,reset: nil,dsize: 8,asize: 8,mode: AxiLite::BOTH,freqM: nil)
    #     TdlSpace::DefAxiLite_ArrayChain.new(belong_to_module: self,clock: clock,reset: reset,freqM: freqM,dsize: dsize,asize: asize,mode: mode)
    # end

    # def axi_inf(clock: nil,reset: nil,dsize: 8,asize: 8,mode: AxiLite::BOTH,freqM: nil,lsize: 8,idsize:1,addr_step: 1.0)
    #     TdlSpace::DefAxi4_ArrayChain.new(belong_to_module: self,clock: clock,reset: reset,freqM: freqM,dsize: dsize,asize: asize,mode: mode,lsize: lsize,idsize: idsize,addr_step: addr_step)
    # end

end