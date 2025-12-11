
class AxiStream
    def to_master_bfm
        define_singleton_method(:import_axibfm_pkg) do
            unless @__AXI_BFM_IMPORT__
                import_str = "import AxiBfmPkg::*;\n"
                belong_to_module.ex_up_code = import_str.concat belong_to_module.ex_up_code.to_s
                @__AXI_BFM_IMPORT__ = true
            end
        end

        define_singleton_method(:masterbfm) do |info:true,wait:nil,wait_every_raising:nil,wdata_name:"wdata_queue",&block|
            import_axibfm_pkg
            @wdata_name = wdata_name
            @_init_tap_cnt_ ||= 1
            @_master_draw_exec_str_ ||= []
            @_init_master_draw_exec_str_ ||= []
            # define_singleton_method(:wdata_queue) do
            #     "wdata_queue"
            # end
            
            block.call self
    
            if info
                info_str = "ON"
            else
                info_str = "OFF"
            end
            belong_to_module.ExOther_draw << masterbfm_draw(info:info_str)
    
            return self
        end

        define_singleton_method("masterbfm_draw") do |info:"OFF"|
            init_str = @_init_master_draw_exec_str_.join("")
            master_str = @_master_draw_exec_str_.join("")
"
AxiStreamMasterBfm_c #(.DSIZE(#{dsize}),.MSG(\"#{info}\"),.FreqM(#{freqM})) MasterBfm#{name};

initial begin:#{name}_MASTER_BLOCK
logic [#{dsize}-1:0]     #{@wdata_name}     [$];
    MasterBfm#{name} = new(#{name});
#{init_str}
    wait(#{name}.aresetn);
#{master_str}
end
"
        end

        define_singleton_method(:exec) do |str=nil,&block|
            if block_given?
                ystr = block.call(self)
                str = str.to_s + ystr
            end
            @_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
        end
    
        define_singleton_method(:init_exec) do |str|
            @_master_draw_exec_str_ ||= []
            @_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
        end
    
        # def stream_exec(delay:"#(10us)",str:"")
        #     @_master_draw_exec_str_ << "#(100ns) wdata_queue = #{str.to_s};\n"
        # end
    
        define_singleton_method(:repeat) do |num=nil,&block|
            if num
                @_master_draw_exec_str_ << init_tap_draw("repeat(#{num}) begin\n")
            else
                @_master_draw_exec_str_ << init_tap_draw("forever begin\n")
            end
            @_init_tap_cnt_ += 1
            block.call self
            @_init_tap_cnt_ -= 1
            @_master_draw_exec_str_ << init_tap_draw("end\n")
        end
    
        define_singleton_method("bif") do |cond,&block|
            @_master_draw_exec_str_ << init_tap_draw("if(#{cond}) begin\n")
        
            @_init_tap_cnt_ += 1
            block.call self
            @_init_tap_cnt_ -= 1
            @_master_draw_exec_str_ << init_tap_draw("end\n")
        end
    
        define_singleton_method("belsif") do |cond,&block|
            @_master_draw_exec_str_ << init_tap_draw("else if(#{cond}) begin\n")
        
            @_init_tap_cnt_ += 1
            block.call self
            @_init_tap_cnt_ -= 1
            @_master_draw_exec_str_ << init_tap_draw("end\n")
        end
    
        define_singleton_method("belse") do |&block|
            @_master_draw_exec_str_ << init_tap_draw("else begin\n")
        
            @_init_tap_cnt_ += 1
            block.call self
            @_init_tap_cnt_ -= 1
            @_master_draw_exec_str_ << init_tap_draw("end\n")
        end
    
        define_singleton_method(:wait) do |s,edge=nil|
            if edge.nil?
                @_master_draw_exec_str_ << init_tap_draw("wait(#{s});\n")
            elsif edge.to_s.eql? "raising"
                @_master_draw_exec_str_ << init_tap_draw("@(posedge #{align_signal(s)});\n")
            elsif edge.to_s.eql? "falling"
                @_master_draw_exec_str_ << init_tap_draw("@(negedge #{align_signal(s)});\n")
            end
        end
    
        define_singleton_method("gen_axi_stream") do |len:0,rate:100|
            @_master_draw_exec_str_ << init_tap_draw("MasterBfm#{name}.gen_axi_stream(#{len},#{rate},#{@wdata_name});\n")
        end
    
        define_singleton_method(:init_tap_draw) do |str|
            "#{"    "*@_init_tap_cnt_}#{str.to_s}"
        end

        return self
    end 
end 


# class BfmStream < AxiStream

#     private
#     def import_axibfm_pkg
#         unless @__AXI_BFM_IMPORT__
#             import_str = "import AxiBfmPkg::*;\n"
#             belong_to_module.ex_up_code = import_str.concat belong_to_module.ex_up_code.to_s
#             @__AXI_BFM_IMPORT__ = true
#         end
#     end

#     public
#     def masterbfm(info:true,wait:nil,wait_every_raising:nil,wdata_name:"wdata_queue",&block)
#         import_axibfm_pkg
#         @wdata_name = wdata_name
#         @_init_tap_cnt_ ||= 1
#         @_master_draw_exec_str_ ||= []
#         @_init_master_draw_exec_str_ ||= []
#         # define_singleton_method(:wdata_queue) do
#         #     "wdata_queue"
#         # end

#         yield self

#         if info
#             info_str = "ON"
#         else
#             info_str = "OFF"
#         end
#         belong_to_module.ExOther_draw << masterbfm_draw(info:info_str)

#         return self
#     end

#     # def self.MasterBFM()
#     #
#     # end

#     def masterbfm_draw(info:"OFF")
#         init_str = @_init_master_draw_exec_str_.join("")
#         master_str = @_master_draw_exec_str_.join("")
# "
# AxiStreamMasterBfm_c #(.DSIZE(#{@dsize}),.MSG(\"#{info}\"),.FreqM(#{intf_def_freqM})) MasterBfm#{signal};

# initial begin:#{signal}_MASTER_BLOCK
# logic [#{@dsize}-1:0]     #{@wdata_name}     [$];
#     MasterBfm#{signal} = new(#{signal});
# #{init_str}
#     wait(#{signal}.aresetn);
# #{master_str}
# end
# "
#     end

#     def exec(str=nil)
#         if block_given?
#             ystr = yield(self)
#             str = str.to_s + ystr
#         end
#         @_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
#     end

#     def init_exec(str)
#         @_init_master_draw_exec_str_ ||= []
#         @_init_master_draw_exec_str_ << init_tap_draw("#{str.to_s};\n")
#     end

#     # def stream_exec(delay:"#(10us)",str:"")
#     #     @_master_draw_exec_str_ << "#(100ns) wdata_queue = #{str.to_s};\n"
#     # end

#     def repeat(num=nil,&block)
#         if num
#             @_master_draw_exec_str_ << init_tap_draw("repeat(#{num}) begin\n")
#         else
#             @_master_draw_exec_str_ << init_tap_draw("forever begin\n")
#         end
#         @_init_tap_cnt_ += 1
#         yield self
#         @_init_tap_cnt_ -= 1
#         @_master_draw_exec_str_ << init_tap_draw("end\n")
#     end

#     def bif(cond,&block)
#         @_master_draw_exec_str_ << init_tap_draw("if(#{cond}) begin\n")
    
#         @_init_tap_cnt_ += 1
#         yield self
#         @_init_tap_cnt_ -= 1
#         @_master_draw_exec_str_ << init_tap_draw("end\n")
#     end

#     def belsif(cond,&block)
#         @_master_draw_exec_str_ << init_tap_draw("else if(#{cond}) begin\n")
    
#         @_init_tap_cnt_ += 1
#         yield self
#         @_init_tap_cnt_ -= 1
#         @_master_draw_exec_str_ << init_tap_draw("end\n")
#     end

#     def belse(&block)
#         @_master_draw_exec_str_ << init_tap_draw("else begin\n")
    
#         @_init_tap_cnt_ += 1
#         yield self
#         @_init_tap_cnt_ -= 1
#         @_master_draw_exec_str_ << init_tap_draw("end\n")
#     end

#     def wait(s,edge=nil)
#         if edge.nil?
#             @_master_draw_exec_str_ << init_tap_draw("wait(#{s});\n")
#         elsif edge.to_s.eql? "raising"
#             @_master_draw_exec_str_ << init_tap_draw("@(posedge #{align_signal(s)});\n")
#         elsif edge.to_s.eql? "falling"
#             @_master_draw_exec_str_ << init_tap_draw("@(negedge #{align_signal(s)});\n")
#         end
#     end

#     def gen_axi_stream(len:0,rate:100)
#         @_master_draw_exec_str_ << init_tap_draw("MasterBfm#{signal}.gen_axi_stream(#{len},#{rate},#{@wdata_name});\n")
#     end

#     private

#     def init_tap_draw(str)
#         "#{"    "*@_init_tap_cnt_}#{str.to_s}"
#     end

# end

class AxiStream

    def slaverbfm(info:true,rate:100,repeat:100)

        if info
            info_str = 1
        else
            info_str = 0
        end
        belong_to_module.AxiStream_draw << slaverbfm_draw(info:info_str,repeat:repeat,rate:rate)

        return self
    end

    # def self.MasterBFM()
    #
    # end

    def slaverbfm_draw(info:0,repeat:0,rate:100)
"
AxiStreamSlaverBfm_c #(.DSIZE(#{@dsize}),.FreqM(#{intf_def_freqM})) SlaverBfm#{name} = new(#{name});

initial begin:#{name}_SLAVER_BLOCK
    wait(#{name}.aresetn);
    @(posedge #{name}.aclk);
    #{
        if repeat > 0
            "repeat(#{repeat})"
        else
            "forever"
        end
    }
    begin
        SlaverBfm#{name}.get_data(#{rate},#{info});
    end
end
"
    end

end

class BfmStream

    def slaverbfm(&block)
        import_axibfm_pkg
        @_init_tap_cnt_ ||= 1
        @_master_draw_exec_str_ ||= []
        @_init_master_draw_exec_str_ ||= []

        yield self
        belong_to_module.AxiStream_draw << slaverbfm_draw()

        return self
    end

    # def self.MasterBFM()
    #
    # end

    def add_slaver_bfm_recv(repeat:nil,rate:100,info:0)
        str =
    "#{
        if repeat > 0
            "repeat(#{repeat})"
        else
            "forever"
        end
    }
    begin
        SlaverBfm#{name}.get_data(#{rate},#{info});
    end"

        @_master_draw_exec_str_ << init_tap_draw(str.concat("\n"))
    end

    def slaverbfm_draw()
        init_str = @_init_master_draw_exec_str_.join("")
        slaver_str = @_master_draw_exec_str_.join("")
"
AxiStreamSlaverBfm_c #(.DSIZE(#{dsize}),.FreqM(#{intf_def_freqM})) SlaverBfm#{name} = new(#{name});

initial begin:#{name}_SLAVER_BLOCK
#{init_str}
    wait(#{name}.aresetn);
    @(posedge #{name}.aclk);
#{slaver_str}
end

"
    end
end
