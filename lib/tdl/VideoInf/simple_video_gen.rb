# require_relative "./video_lib"
# require_relative ".././videoinf"
# require_relative ".././tdl"

class VideoInf

    def simple_video_gen(mode:"1080P@60",enable:nil)
        video_master = self
        # $_draw = lambda { simple_video_gen_draw(video_master:video_master,mode:mode,enable:enable) }
        # @correlation_proc += $_draw.call
        belong_to_module.VideoInf_draw << simple_video_gen_draw(video_master:video_master,mode:mode,enable:enable)
        return video_master
    end

    def simple_video_gen_draw(video_master:self,mode:nil,enable:nil)
        large_name_len(video_master,mode)
"simple_video_gen_A2 #(
    .MODE   (#{align_signal(mode)}),
    .DSIZE  (#{align_signal(signal,false)}.DSIZE)
)simple_video_gen_A2_#{(signal)}_inst(
/*  input                         */  .enable   (#{align_signal(enable)}),
/*  video_native_inf.compact_out  */  .inf      (#{align_signal(video_master)})
);"
    end

    def self.simple_video_gen(video_master:nil,mode:nil,enable:nil,copy_inf:nil,belong_to_module:nil)
        unless video_master
            video_master = belong_to_module.Def.videoinf(name:copy_inf.name+"_cp",clock:copy_inf.clock,reset:copy_inf.reset,dsize:copy_inf.dsize,dimension:copy_inf.dimension)
        end

        video_master.simple_video_gen(mode:mode,enable:enable)
    end
end

# class TdlTest
#
#     def self.test_simple_video_gen
#         c0 = Clock.new(name:"时钟",freqM:148.5)
#         r0 = Reset.new(name:"复位",active:"low")
#         p0 = Parameter.new(name:"P0",value:24)
#         data = VideoInf.new(name:"in",clock:c0,reset:r0,dsize:p0)
#         VideoInf.simple_video_gen(mode:"1080P@50",enable:"1'b1",copy_inf:data)
#         puts_sv Tdl.inst,Tdl.draw
#         Tdl.clear
#     end
# end
