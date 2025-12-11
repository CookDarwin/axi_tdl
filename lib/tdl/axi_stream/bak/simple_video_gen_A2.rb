
#2017-06-21 14:20:16 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class VideoInf


    def _simple_video_gen_a2(mode:"1080P@60",dsize:24,enable:"enable",inf:"inf")



        $_draw = lambda { _simple_video_gen_a2_draw(mode:mode,dsize:dsize,enable:enable,inf:inf) }
        @correlation_proc += $_draw.call
        return self
    end

    def _simple_video_gen_a2_draw(mode:"1080P@60",dsize:24,enable:"enable",inf:"inf")
        large_name_len(mode,dsize,enable,inf)
"
simple_video_gen_A2#(
    .MODE     (#{align_signal(mode)}),
    .DSIZE    (#{align_signal(dsize)})
) simple_video_gen_a2_#{signal}_inst(
/*  input                       */ .enable (#{align_signal(enable,q_mark=false)}),
/*  video_native_inf.compact_out*/ .inf    (#{align_signal(inf,q_mark=false)})
);
"
    end

    def self.simple_video_gen_a2(mode:"1080P@60",dsize:24,enable:"enable",inf:"inf")
        NC._simple_video_gen_a2(mode:mode,dsize:dsize,enable:enable,inf:inf)

    end


end


class TdlTest

    def self.test_simple_video_gen_a2
        c0 = Clock.new(name:"simple_video_gen_a2_clk",freqM:148.5)
        r0 = Reset.new(name:"simple_video_gen_a2_rst_n",active:"low")

        Parameter.new(name:"mode",value:"1080P@60")
        Parameter.new(name:"dsize",value:24)
        Logic.new(name:"enable")
        VideoInf.new(name:"inf",clock:c0,reset:r0)


        VideoInf.simple_video_gen_a2(mode:mode,dsize:dsize,enable:enable,inf:inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_simple_video_gen_a2(mode:"1080P@60",dsize:24,enable:"enable",inf:"inf")
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


        unless dsize.is_a? Hash
            # hash.new_index(:dsize) = dsize
            if dsize.is_a? InfElm
                hash.[]=(:dsize,dsize,true)
            else
                hash.[]=(:dsize,dsize,false)
            end
        else
            # hash.new_index(:dsize)= lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            # hash[:dsize] = lambda { a = Parameter.new(dsize);a.name = "dsize";return a }
            hash.[]=(:dsize,lambda { a = Parameter.new(dsize);a.name = "dsize";return a },false)
        end


        unless enable.is_a? Hash
            # hash.new_index(:enable) = enable
            if enable.is_a? InfElm
                hash.[]=(:enable,enable,true)
            else
                hash.[]=(:enable,enable,false)
            end
        else
            # hash.new_index(:enable)= lambda { a = Logic.new(enable);a.name = "enable";return a }
            # hash[:enable] = lambda { a = Logic.new(enable);a.name = "enable";return a }
            hash.[]=(:enable,lambda { a = Logic.new(enable);a.name = "enable";return a },false)
        end


        unless inf.is_a? Hash
            # hash.new_index(:inf) = inf
            if inf.is_a? InfElm
                hash.[]=(:inf,inf,true)
            else
                hash.[]=(:inf,inf,false)
            end
        else
            # hash.new_index(:inf)= lambda { a = VideoInf.new(inf);a.name = "inf";return a }
            # hash[:inf] = lambda { a = VideoInf.new(inf);a.name = "inf";return a }
            hash.[]=(:inf,lambda { a = VideoInf.new(inf);a.name = "inf";return a },false)
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
            hash.check_use("simple_video_gen_a2")
            VideoInf.simple_video_gen_a2(hash)
        }
        return hash
    end
end
