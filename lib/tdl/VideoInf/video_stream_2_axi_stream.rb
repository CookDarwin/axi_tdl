# require_relative "./video_lib"
# require_relative ".././videoinf"
# require_relative ".././tdl"

class VideoInf

    def to_axi_stream(axis_master:nil,mode:"LINE")
        videos = self
        $_draw = lambda { video_stream_2_axi_stream_draw(videos:videos,axis:axi_master,mode:mode) }
        @correlation_proc += $_draw.call
        return axi_master
    end

    def video_stream_2_axi_stream_draw(videos:self,axis:nil,mode:nil)
        large_name_len(videos,axis,mode)
"\nvideo_stream_2_axi_stream #(
    .MODE       (#{align_signal(mode)})       //LINE FRAME
)video_stream_2_axi_stream_#{signal}_inst(
/*  video_native_inf.compact_in */  .video_inf  (#{align_signal(videos)}),
/*  axi_stream_inf.master       */  .axis_out   (#{align_signal(axis)})
);\n"
    end

    def self.video_stream_2_axi_stream(video_slaver:nil,axis_master:nil,mode:"LINE")
        if video_slaver
            if axis_master
                video_slaver.to_axi_stream(axis_master:axis_master,mode:mode)
            else
                new_obj = AxiStream.new(name:video_slaver.name+"_f_v",clock:video_slaver.clock,reset:video_slaver.reset,dsize:video_slaver.dsize)
                video_slaver.to_axi_stream(axis_master:new_obj,mode:mode)
                return new_obj
            end
        elsif axis_master
            if video_slaver
                video_slaver.to_axi_stream(axis_master:axis_master,mode:mode)
            else
                new_obj = VideoInf.new(name:axis_master.name+"_to_as",clock:axis_master.clock,reset:axis_master.reset,dsize:axis_master.dsize)
                new_obj.to_axi_stream(axis_master:axis_master,mode:mode)
            end
        end
    end
end

class AxiStream

    def from_video_stream(video_slaver:nil,mode:"LINE")
        video_inf.to_axi_stream(axi_master:self,mode:mode)
        return video_slaver
    end

    def self.video_stream_2_axi_stream(video_slaver:nil,axis_master:nil,mode:"LINE")
        VideoInf.video_stream_2_axi_stream(video_slaver:video_slaver,axis_master:axis_master,mode:"LINE")
    end
end

class TdlTest

    def self.video_stream_2_axi_stream
        c0 = Clock.new(name:"时钟",freqM:148.5)
        r0 = Reset.new(name:"复位",active:"low")
        axis_master = AxiStream.new(name:"out",clock:c0,reset:r0)
        data_in = VideoInf.new(name:"in",clock:c0,reset:r0)
        AxiStream.video_stream_2_axi_stream(axis_master:axis_master,video_slaver:data_in)
        puts_sv Tdl.inst,Tdl.draw
    end

end
