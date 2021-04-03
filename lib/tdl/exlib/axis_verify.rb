
module AxiTdl

    module AxisVerify 

        class Iteration

            # attr_accessor :axis_tlast, :axis_tuser, :axis_tkeep, :axis_tdata
            def initialize(length: 1024, data: [0], vld_perc: 50,user:[0], keep:[1] , rand_seed: 0 ,dsize: 8, usize: 1)
                @axis_tdata = data.to_a * (length / data.size + 1)
                @axis_tuser = user.to_a * (length / user.size + 1)
                @axis_tkeep = keep.to_a * (length / keep.size + 1)
                @vld_perc = vld_perc / 100.0
                @length = length
                @prng = Random.new( rand_seed )
                @dsize = dsize
                @usize = usize 
                @ksize = @dsize / 8 + (@dsize%8==0 ? 0 : 1)

                raise TdlError.new("valid percetage cant be zero") if vld_perc==0
            end

            # def each(&block)
            #     # yield(axis_tlast, axis_tuser, axis_tkeep, axis_tdata)
            #     # @length.each do |index|
            #     #     yield(axis_tlast, axis_tuser, axis_tkeep, axis_tdata)
            #     # end
            #     index = 0
            #     while true 

            #         # @length  -= 1
            #         # @length = axis_tcnt
            #         # yield(@length, axis_tvalid, axis_tlast, axis_tuser, axis_tkeep, axis_tdata)
                    
            #         yield(index, (@vld_perc > @prng.rand ? 1 : 0), @axis_tuser[index], @axis_tkeep[index], (@length==0 ? 1 : 0), @axis_tdata[index])
                    
            #         if @length <= index + 1
            #             break 
            #         end
            #         index += 1
            #     end
            # end

            def to_a 
                collect = []
                index = 0
                10000.times do  

                    vld = (@vld_perc > @prng.rand ? 1 : 0)
                    
                    collect << [ index, vld , @axis_tuser[index], @axis_tkeep[index], (@length==(index+vld) ? 1 : 0), @axis_tdata[index] ]
                    
                    if @length <= index + vld
                        break 
                    end

                    index += vld
                end

                collect 
            end

            def stream_context
                collect = []
                to_a.each do |axis_tcnt, axis_tvalid, axis_tuser, axis_tkeep, axis_tlast, axis_tdata|
                    u0 = axis_tdata % (2**@dsize)
                    u3 = axis_tlast << (@dsize)
                    u1 = (axis_tkeep % (2**@ksize)) << (@dsize + 1)
                    u2 = (axis_tuser % (2**@usize)) << (@dsize + @ksize + 1)
                    u4 = axis_tvalid << (@dsize + @ksize + @usize + 1)
                    collect << (u0+u1+u2+u3+u4)
                end

                collect.map do |e| 
                    "%0#{(@dsize + @ksize + @usize + 1 + 1)/4  + ( ((@dsize + @ksize + @usize + 1 + 1)%4 == 0) ? 0 : 1 )}x"%e
                end
                # collect
            end
        end

        class SimpleStreams 
            attr_accessor :streams
            def initialize(length: [10,200], gap_len: [0,10], data: [ (0...100) ] * 10 , vld_perc: [50, 100], dsize: 8)
                max_len = [length.size, gap_len.size, data.size , vld_perc.size ].max
                @lengths = length.to_a * (max_len / length.size + 1 )
                @gap_lens = gap_len.to_a * (max_len / gap_len.size + 1 )
                @datas = data.to_a * (max_len / data.size + 1 )
                @vld_percs = vld_perc.to_a * (max_len / vld_perc.size + 1 )
                
                @dsize = dsize 
                @max_len = max_len
                @streams = []
                gen_itr
            end

            def gen_itr 
                @max_len.times do |index|
                   itr = Iteration.new(length: @lengths[index], data: @datas[index], vld_perc: @vld_percs[index],user:[0], keep:[1] , rand_seed: index ,dsize: @dsize, usize: 1)
                   streams << itr
               end
            end

            def coe 
                collect = []
                @max_len.times do |index|
                     ## add grap 
                    if @gap_lens[index] != 0
                        collect += ["0"]*@gap_lens[index]
                    end 
                    itr = @streams[index]
                    collect += itr.stream_context
                end

                mmp = [] 
                collect.each_index do |index| 
                    mmp << "@%04x #{collect[index]}\n"%index
                end

                mmp.join("")

            end
        end
    
    end

end


class AxiStream

    def to_simple_sim_master_coe(enable: 1.b1, length: [10,200], gap_len: [0,10], data: [ (0...100) ] , vld_perc: [50, 100], loop_coe: true)
        # raise TdlError.new "file cant be empty"  unless file
        file = File.join(AxiTdl::TDL_PATH,"./auto_script/tmp/","coe_#{self.name}_#{globle_random_name_flag}.coe")
        _sps = nil
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            require_sdl 'axis_sim_master_model.rb'
            File.open(file,'w') do |f|
                _sps = AxiTdl::AxisVerify::SimpleStreams.new(length: length, gap_len: gap_len, data: data , vld_perc: vld_perc)
                f.print _sps.coe
            end
        end

        self.define_singleton_method(:verification) do 
            _sps 
        end

        @belong_to_module.instance_exec(self,file,loop_coe,enable) do |_self,file,loop_coe,_enable| 

            Instance(:axis_sim_master_model,"sim_model_inst_#{_self.name}") do |h| 
                h.param.LOOP                (loop_coe ? "TRUE" : "FALSE")
                h.param.RAM_DEPTH           File.open(File.expand_path(file)).readlines.size
                h.input.enable              _enable
                h.input.load_trigger        1.b0
                h.input[32].total_length    h.param.RAM_DEPTH
                h.input[512*8].mem_file     File.expand_path(file) # {axis_tvalid, axis_tuser, axis_tkeep, axis_tlast, axis_tdata}
                h.port.axis.master.out_inf  _self
            end
        end

    end

    def to_simple_sim_slaver(rdy_percetage=50,loop_rdy=true)
        unless rdy_percetage.is_a?(Array)
            @belong_to_module.instance_exec(self) do |_self|

                always_ff(posedge: _self.aclk) do 
                    IF ~_self.aresetn do 
                        _self.axis_tready   <= 1.b0 
                    end
                    ELSE do 
                        _self.axis_tready   <= rdy_percetage.precent_true
                    end
                end
            end
        else  
            @belong_to_module.instance_exec(self,rdy_percetage,loop_rdy) do |_self,rdy_percetage,loop_rdy|

                __xx = logic[32] - "#{_self.name}_rdy_percetage_index"
                __rr = logic[rdy_percetage.size, 32] - "#{_self.name}_rdy_percetage"
                Initial do 
                    __xx <= 0
                    rdy_percetage.each_index do |index|
                        __rr[index] <= rdy_percetage[index]
                    end
                end 

                Always(posedge: _self.aclk) do 
                    IF _self.vld_rdy_last do 
                        IF __xx >= (rdy_percetage.size - 1 ) do 
                            if loop_rdy  
                                __xx <= 0
                            else 
                                __xx <= __xx 
                                __rr[__xx] = 0
                            end
                        end
                        ELSE do 
                            __xx <= __xx + 1.b1 
                        end
                    end
                    ELSE do 
                        __xx <= __xx 
                    end
                end 

                always_ff(posedge: _self.aclk) do 
                    IF ~_self.aresetn do 
                        _self.axis_tready   <= 1.b0 
                    end
                    ELSE do 
                        _self.axis_tready   <= "($urandom_range(0,99) <= #{__rr[__xx]})".to_nq
                    end
                end
            end
        end
    end

    def simple_verify_by_coe(file)
        unless File.file?(file)
            if file.is_a?(String)
                wfile = File.join(AxiTdl::TDL_PATH,"./auto_script/tmp/","#{self.name}_#{globle_random_name_flag}.coe")
                File.open(wfile,'w') do |f|
                    f.puts file
                end
                file = wfile
            end
        end 

        require_hdl 'axis_sim_verify_by_coe.sv'

        @belong_to_module.instance_exec(self,File.open(file).readlines.size,file) do |_self,_ram_depth,_file|

            Instance(:axis_sim_verify_by_coe, "axis_sim_verify_by_coe_inst_#{_self.name}") do |h|#(
                h.param.RAM_DEPTH           _ram_depth
                h.param.VERIFY_KEEP         "OFF"
                h.param.VERIFY_USER         "OFF"
                h.input.load_trigger        1.b0
                h.input[32].total_length    _ram_depth
                h.input[4096].mem_file      File.expand_path(_file)
                h.port.axis.mirror.mirror_inf   _self
            end
        end
    end
end

## Extand Array 
module AxiTdl 
    module Verification 
        class CoeArray < Array 

            def initialize(obj_array=nil)
                super obj_array
            end

            def coe 
                xcollect = []
                self.each_index do |index|
                    xcollect << "@#{index.to_s(16)} #{self[index].to_s(16)}\n"
                end 
                xcollect.join("")
            end

        end
    end
end
