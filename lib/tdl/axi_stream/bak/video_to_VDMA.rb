
#2017-06-21 14:20:16 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def video_to_vdma(mode:"LINE",base_addr:"base_addr",video_inf:"video_inf",axi_master:"axi_master",down_stream:nil)

        axi_master = self

        $_draw = lambda { video_to_vdma_draw(mode:mode,base_addr:base_addr,video_inf:video_inf,axi_master:axi_master,down_stream:down_stream) }
        @correlation_proc += $_draw.call
        return self
    end

    def video_to_vdma_draw(mode:"LINE",base_addr:"base_addr",video_inf:"video_inf",axi_master:"axi_master",down_stream:nil)
        large_name_len(mode,base_addr,video_inf,axi_master)
"
video_to_VDMA#(
    .MODE    (#{align_signal(mode)})
) video_to_vdma_#{signal}_inst(
/*  input  [31:0]              */ .base_addr  (#{align_signal(base_addr,q_mark=false)}),
/*  video_native_inf.compact_in*/ .video_inf  (#{align_signal(video_inf,q_mark=false)}),
/*  axi_inf.master             */ .axi_master (#{align_signal(axi_master,q_mark=false)})
);
"
    end

    def self.video_to_vdma(mode:"LINE",base_addr:"base_addr",video_inf:"video_inf",axi_master:"axi_master",down_stream:nil)

        if down_stream.is_a? Axi4
            down_stream.video_to_vdma(mode:mode,base_addr:base_addr,video_inf:video_inf,axi_master:axi_master,down_stream:down_stream)
        elsif axi_master.is_a? Axi4
            axi_master.video_to_vdma(mode:mode,base_addr:base_addr,video_inf:video_inf,axi_master:axi_master,down_stream:down_stream)
        else
            NC.video_to_vdma(mode:mode,base_addr:base_addr,video_inf:video_inf,axi_master:axi_master,down_stream:down_stream)
        end

    end


end


class TdlTest

    def self.test_video_to_vdma
        c0 = Clock.new(name:"video_to_vdma_clk",freqM:148.5)
        r0 = Reset.new(name:"video_to_vdma_rst_n",active:"low")

        Parameter.new(name:"mode",value:"LINE")
        Logic.new(name:"base_addr")
        VideoInf.new(name:"video_inf",clock:c0,reset:r0)
        Axi4.new(name:"axi_master",clock:c0,reset:r0)

        down_stream = axi_master
        Axi4.video_to_vdma(mode:mode,base_addr:base_addr,video_inf:video_inf,axi_master:axi_master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_video_to_vdma(mode:"LINE",base_addr:"base_addr",video_inf:"video_inf",axi_master:"axi_master")
        hash = TdlHash.new

        unless mode.is_a? Hash
            # hash.new_index(:mode) = mode
            if mode.is_a? InfElm
                hash.[]=(:mode,mode,true)
            else
                hash.[]=(:mode,mode,false)
            end
        else
            # hash.new_index(:mode)= lambda { a = Parameter.new(mode);a.name = "mode";return a }
            # hash[:mode] = lambda { a = Parameter.new(mode);a.name = "mode";return a }
            hash.[]=(:mode,lambda { a = Parameter.new(mode);a.name = "mode";return a },false)
        end


        unless base_addr.is_a? Hash
            # hash.new_index(:base_addr) = base_addr
            if base_addr.is_a? InfElm
                hash.[]=(:base_addr,base_addr,true)
            else
                hash.[]=(:base_addr,base_addr,false)
            end
        else
            # hash.new_index(:base_addr)= lambda { a = Logic.new(base_addr);a.name = "base_addr";return a }
            # hash[:base_addr] = lambda { a = Logic.new(base_addr);a.name = "base_addr";return a }
            hash.[]=(:base_addr,lambda { a = Logic.new(base_addr);a.name = "base_addr";return a },false)
        end


        unless video_inf.is_a? Hash
            # hash.new_index(:video_inf) = video_inf
            if video_inf.is_a? InfElm
                hash.[]=(:video_inf,video_inf,true)
            else
                hash.[]=(:video_inf,video_inf,false)
            end
        else
            # hash.new_index(:video_inf)= lambda { a = VideoInf.new(video_inf);a.name = "video_inf";return a }
            # hash[:video_inf] = lambda { a = VideoInf.new(video_inf);a.name = "video_inf";return a }
            hash.[]=(:video_inf,lambda { a = VideoInf.new(video_inf);a.name = "video_inf";return a },false)
        end


        unless axi_master.is_a? Hash
            # hash.new_index(:axi_master) = axi_master
            if axi_master.is_a? InfElm
                hash.[]=(:axi_master,axi_master,true)
            else
                hash.[]=(:axi_master,axi_master,false)
            end
        else
            # hash.new_index(:axi_master)= lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            # hash[:axi_master] = lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a }
            hash.[]=(:axi_master,lambda { a = Axi4.new(axi_master);a.name = "axi_master";return a },false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                    unless v.empty?
                        if v[0].is_a? Axi4
                            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                        else
                            cm = v[0].copy(name:k)
                        end
                        cm.<<(*v)
                        # hash[k] = cm
                        hash.[]=(k,cm)
                    else
                        hash.[]=(k,nil,false)
                    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("video_to_vdma")
            Axi4.video_to_vdma(hash)
        }
        return hash
    end
end
