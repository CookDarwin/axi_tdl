# require_relative "./video_lib"
# require_relative ".././videoinf"
# require_relative ".././tdl"

class VideoInf

    def from_axi4(axi4_master:nil,video_slaver:nil,mode:"LINE",base_addr:nil)
        unless axi4_master
            axi4_master = Axi4.new(name:@name+"_f_v",clock:@clock,reset:@reset,dsize:@dsize,max_len:2**32,mode:Axi4::ONLY_READ)
        end
        unless video_slaver
            video_slaver = self.copy()
        end
        video_master = self
        $_draw = lambda { video_from_axi4_draw(axi4_master:axi4_master,video_slaver:video_slaver,video_master:video_master,mode:"LINE",base_addr:base_addr) }
        @correlation_proc += $_draw.call
        return axi4_master
    end

    def video_from_axi4_draw(axi4_master:nil,video_slaver:nil,video_master:self,mode:"LINE",base_addr:nil)
        large_name_len(axi4_master,video_slaver,video_master,mode,base_addr)
"\nvideo_from_axi4 #(
    .MODE       (#{align_signal(mode)})    //LINE ONCE
)video_from_axi4_#{signal}_inst(
/*  input [31:0]                 */   .base_addr        (#{align_signal(base_addr)}),
/*  video_native_inf.compact_in  */   .in_video_inf     (#{align_signal(video_slaver)}),
/*  video_native_inf.compact_out */   .out_video_inf    (#{align_signal(video_master)}),
/*  axi_inf.master_rd            */   .axi_master       (#{align_signal(axi4_master)})
);\n"
    end

    def self.video_from_axi4(axi4_master:nil,video_slaver:nil,video_master:nil,mode:"LINE",base_addr:nil)
        if video_slaver
            video_name  = video_slaver.name
            video_clock = video_slaver.clock
            video_reset = video_slaver.reset
            video_dsize = video_slaver.dsize
        elsif video_master
            video_name  = video_master.name
            video_clock = video_master.clock
            video_reset = video_master.reset
            video_dsize = video_master.dsize
        else axi4_master
            video_name  = axi4_master.name
            video_clock = axi4_master.clock
            video_reset = axi4_master.reset
            video_dsize = axi4_master.dsize
        end

        unless axi4_master
            new_axi4_master = Axi4.new(name:video_name+"_to_v",clock:video_clock,reset:video_reset,dsize:video_dsize,max_len:2**32,mode:Axi4::ONLY_READ)
        else
            new_axi4_master = axi4_master
        end

        unless video_slaver
            new_video_slaver = VideoInf.new(name:video_name+"_slaver",clock:video_clock,reset:video_reset,dsize:video_dsize)
        else
            new_video_slaver = video_slaver
        end

        unless video_master
            new_video_master = VideoInf.new(name:video_name+"_master",clock:video_clock,reset:video_reset,dsize:video_dsize)
        else
            new_video_master = video_master
        end

        new_video_master.from_axi4(axi4_master:new_axi4_master,video_slaver:new_video_slaver,mode:mode,base_addr:base_addr)

        unless axi4_master
            return new_axi4_master
        end

        unless video_slaver
            return new_video_master
        end

        unless video_master
            return new_video_master
        end
    end
end

class Axi4

    def to_video(video_slaver:nil,video_master:nil,mode:"LINE",base_addr:nil)
        VideoInf.video_from_axi4(axi4_master:self,video_slaver:video_slaver,video_master:video_master,mode:mode,base_addr:base_addr)
    end

    def self.video_from_axi4(axi4_master:nil,video_slaver:nil,video_master:nil,mode:"LINE",base_addr:nil)
        VideoInf.video_from_axi4(axi4_master:axi4_master,video_slaver:video_slaver,video_master:video_master,mode:mode,base_addr:base_addr)
    end
end

class TdlTest

    def self.test_video_from_axi4
        c0 = Clock.new(name:"时钟",freqM:148.5)
        r0 = Reset.new(name:"复位",active:"low")
        p0 = Parameter.new(name:"P0",value:24)
        axi4_master = Axi4.new(name:"out",clock:c0,reset:r0,dsize:p0)
        data_slaver = VideoInf.new(name:"in",clock:c0,reset:r0,dsize:p0)
        Axi4.video_from_axi4(axi4_master:axi4_master,video_slaver:data_slaver,base_addr:"12'd0")
        puts_sv Tdl.inst,Tdl.draw
        Tdl.clear
    end

end
