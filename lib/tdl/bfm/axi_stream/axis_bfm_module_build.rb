
class AxiStreamBFMModuleBuild

    def use_yaml_bfm(yaml_file)

        sdlm = TechBenchModule.new(name:File.basename(yaml_file,".*"),out_sv_path:File.expand_path(File.dirname(yaml_file)))
        axis_bp = AxiStreamBFMParse.new(yaml_file)
        AxiStreamBFMModuleBuild.new.build_streams_bfm(sdlm,axis_bp.hash)

        return sdlm
    end

    def build_streams_bfm(sdlm,yaml_hash)
        yaml_hash.each do |k,v|

            if(v['type'] == "master")
                build_single_master_stream_bfm(sdlm,k,v)
            elsif v['type'] == "slaver"
                build_single_slaver_stream_bfm(sdlm,k,v)
            else
                raise TdlError.new(" Error type[#{v['type']}] for #{k}")
            end
        end
    end

    def set_bfm_pkg_import(bfmstream)
        bfmstream.instance_variable_set("@__AXI_BFM_IMPORT__",true) if @__AXI_BFM_IMPORT__
        @__AXI_BFM_IMPORT__ = true
    end

    def build_single_master_stream_bfm(sdlm,stream_name,stream_hash)
        # sdlm.instance_exec(stream_name) do |stream_name|
        #
        #     Def().bfm_stream(name:)
        # end
        a = sdlm.AxiStream.master(stream_name,freqM:   stream_hash["FreqM"].to_f)

        ba = sdlm.Def.bfm_stream(name:"#{stream_name}_b",freqM:  stream_hash["FreqM"].to_f,clock: a.aclk,reset: a.aresetn, dsize: stream_hash["dsize"].to_i )

        a.direct(up_stream: ba)

        set_bfm_pkg_import(ba)

        ba.masterbfm(info:stream_hash["info"],wait: nil,wait_every_raising: nil,wdata_name: "wdata_queue") do |b|
            b.init_exec("#(#{stream_hash["wait"]})") if stream_hash["wait"]

            stream_hash["queue"].each do |burst|
                buidl_master_burst(ba,burst,stream_hash['dsize'].to_i)
            end

        end
        @__AXI_BFM_IMPORT__ = true
    end

    def buidl_master_burst(bfmstream,bhash,dsize)
        bfmstream.exec("wdata_queue = {}")
        if(bhash['repeat'])
            bfmstream.repeat(bhash['repeat'].to_i) do
                bfmstream.exec("#(#{(bhash["pre_wait"])})") if bhash["pre_wait"]
                build_master_contect(bfmstream,bhash['contect'],bhash['length'].to_i,dsize.to_i)
                bfmstream.gen_axi_stream(len:0,rate:bhash['persent'].to_i)
                bfmstream.exec("#(#{(bhash["post_wait"])})") if bhash["post_wait"]
            end
        else
            bfmstream.exec("#(#{(bhash["pre_wait"])})") if bhash["pre_wait"]
            build_master_contect(bfmstream,bhash['contect'],bhash['length'].to_i,dsize.to_i)
            bfmstream.gen_axi_stream(len:0,rate:bhash['persent'].to_i)
            bfmstream.exec("#(#{(bhash["post_wait"])})") if bhash["post_wait"]
        end

    end

    def build_master_contect(bfmstream,contect_str,length,dsize)
        random_exp = /random\s*\(\s*(?<a>\d+)\s*,\s*(?<b>\d+)\s*\)/i
        range_exp = /range\s*\(\s*(?<a>\d+)\s*,\s*(?<b>\d+)\s*\)/i
        origin_exp = /^\d+\s*,\s*\d+/

        if contect_str.match random_exp
            str =
            "for(int II=0;II<#{length};II++)
            wdata_queue[II] = $urandom_range(#{$~[:a]},#{$~[:b]})"
        elsif contect_str.match range_exp
            str =
            "for(int II=0;II<#{length};II++)
            wdata_queue[II] = (II) % (#{($~[:a].to_i - $~[:b].to_i).abs}) + #{$~[:a]}"
        elsif contect_str.match origin_exp
            list = contect_str.strip.split(",")
            if list.length < length
                list  = list + list[0,length - list.length]
            end
            str = "wdata_queue    = {>>{#{list[0,length].map { |e| "#{dsize}'d#{e}" }.join(",")}}}"
        end

        bfmstream.exec(str)

    end

    def build_single_slaver_stream_bfm(sdlm,stream_name,stream_hash)
        a = sdlm.AxiStream.slaver(stream_name,freqM:   stream_hash["FreqM"].to_f)

        ba = sdlm.Def.bfm_stream(name:"#{stream_name}_b",freqM:  stream_hash["FreqM"].to_f,clock: a.aclk,reset: a.aresetn, dsize: stream_hash["dsize"].to_i )
        set_bfm_pkg_import(ba)

        a.direct(down_stream: ba)

        if stream_hash['info']
            info_str = 1
        else
            info_str = 0
        end

        ba.slaverbfm do |b|
            ba.init_exec("#(#{stream_hash['wait']})")
            stream_hash['queue'].each do |burst|
                ba.add_slaver_bfm_recv(repeat:burst['repeat'],rate:burst['persent'].to_i,info:info_str)
            end
        end
    end

end
