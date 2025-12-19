# require_relative "./video_lib"
# require_relative ".././videoinf"
# require_relative ".././tdl"

class VideoInf

    def to_axi4(axi4_master:nil,mode:"LINE",base_addr:nil)
        unless axi4_master
            axi4_master = Axi4.new(name:@name+"_f_v",clock:@clock,reset:@reset,dsize:@dsize,max_len:2**32,mode:Axi4::ONLY_WRITE)
        end
        video_slaver = self
        # $_draw = lambda { video_to_axi4_draw(video_slaver:video_slaver,axi4_master:axi4_master,mode:mode,base_addr:base_addr) }
        # @correlation_proc += $_draw.call
        belong_to_module.VideoInf_draw << video_to_axi4_draw(video_slaver:video_slaver,axi4_master:axi4_master,mode:mode,base_addr:base_addr)

        return axi4_master
    end

    def video_to_axi4_draw(video_slaver:self,axi4_master:nil,mode:nil,base_addr:nil)
        large_name_len(video_slaver,axi4_master,mode,base_addr)
"\nvideo_to_axi4 #(
    .MODE       (#{align_signal(mode)})    //LINE ONCE
)video_to_axi4_#{signal}_inst(
/*  input [31:0]               */  .base_addr   (#{align_signal(base_addr)}),
/*  video_native_inf.compact_in*/  .video_inf   (#{align_signal(video_slaver)}),
/*  axi_inf.master_wr          */  .axi_master  (#{align_signal(axi4_master)})
);\n"
    end

    def self.video_to_axi4(axi4_master:nil,video_slaver:nil,mode:"LINE",base_addr:nil)
        if video_slaver
            if axi4_master
                video_slaver.to_axi4(axi4_master:axi4_master,mode:mode,base_addr:base_addr)
            else
                new_obj = video_slaver.belong_to_module.Def.axi4(name:video_slaver.name+"_f_v",clock:video_slaver.clock,reset:video_slaver.reset,dsize:video_slaver.dsize,max_len:2**32,mode:Axi4::ONLY_WRITE)
                video_slaver.to_axi4(axi4_master:new_obj,mode:mode)
                return new_obj
            end
        elsif axi4_master
            if video_slaver
                video_slaver.to_axi4(axi4_master:axi4_master,mode:mode,base_addr:base_addr)
            else
                new_obj = axi4_master.belong_to_module.Def.videoinf(name:axi4_master.name+"_to_as",clock:axi4_master.clock,reset:axi4_master.reset,dsize:axi4_master.dsize)
                new_obj.to_axi4(axi4_master:axi4_master,mode:mode,base_addr:base_addr)
            end
        end
    end

end

class Axi4

    def from_video(video_slaver:nil,mode:"LINE",base_addr:nil)
        video_slaver.to_axi4(axi4_master:self,mode:mode,base_addr:base_addr)
    end

    def self.video_to_axi4(axi4_master:nil,video_slaver:nil,mode:"LINE",base_addr:nil)
        VideoInf.video_to_axi4(axi4_master:axi4_master,video_slaver:video_slaver,mode:mode,base_addr:base_addr)
    end

end

# class TdlTest
#
#     def self.test_video_to_axi4
#         c0 = Clock.new(name:"时钟",freqM:148.5)
#         r0 = Reset.new(name:"复位",active:"low")
#         axi4_master = Axi4.new(name:"out",clock:c0,reset:r0)
#         data_in = VideoInf.new(name:"in",clock:c0,reset:r0)
#         # VideoInf.video_to_axi4(axi4_master:axi4_master,video_slaver:data_in,base_addr:"12'd0")
#         data_in.to_axi4(axi4_master:axi4_master,base_addr:"12'd0")
#         puts_sv Tdl.inst,Tdl.draw
#         Tdl.clear
#     end
# end
