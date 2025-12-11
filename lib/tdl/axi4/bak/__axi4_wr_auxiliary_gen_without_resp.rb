
#2017-09-25 15:09:18 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _axi4_wr_auxiliary_gen_without_resp(stream_en:"stream_en",id_add_len_in:"id_add_len_in",axi_wr_aux:"axi_wr_aux")

        Tdl.add_to_all_file_paths(['axi4_wr_auxiliary_gen_without_resp','../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv'])
        return_stream = self

        id_add_len_in = AxiStream.same_name_socket(:from_up,mix=true,id_add_len_in) unless id_add_len_in.is_a? String
        axi_wr_aux = Axi4.same_name_socket(:mirror,mix=true,axi_wr_aux) unless axi_wr_aux.is_a? String




         @instance_draw_stack << lambda { _axi4_wr_auxiliary_gen_without_resp_draw(stream_en:stream_en,id_add_len_in:id_add_len_in,axi_wr_aux:axi_wr_aux) }
        return return_stream
    end

    def _axi4_wr_auxiliary_gen_without_resp_draw(stream_en:"stream_en",id_add_len_in:"id_add_len_in",axi_wr_aux:"axi_wr_aux")

        large_name_len(stream_en,id_add_len_in,axi_wr_aux)
"
// FilePath:::../../axi/AXI4/axi4_wr_auxiliary_gen_without_resp.sv
axi4_wr_auxiliary_gen_without_resp axi4_wr_auxiliary_gen_without_resp_#{signal}_inst(
/*  output                       */ .stream_en     (#{align_signal(stream_en,q_mark=false)}),
/*  axi_stream_inf.slaver        */ .id_add_len_in (#{align_signal(id_add_len_in,q_mark=false)}),
/*  axi_inf.master_wr_aux_no_resp*/ .axi_wr_aux    (#{align_signal(axi_wr_aux,q_mark=false)})
);
assign #{axi_wr_aux.signal}.axi_bready  = 1'b1; 
"
    end

    def self.axi4_wr_auxiliary_gen_without_resp(stream_en:"stream_en",id_add_len_in:"id_add_len_in",axi_wr_aux:"axi_wr_aux")
        return_stream = nil


        NC._axi4_wr_auxiliary_gen_without_resp(stream_en:stream_en,id_add_len_in:id_add_len_in,axi_wr_aux:axi_wr_aux)
        return return_stream
    end


end


class TdlTest

    def self.test_axi4_wr_auxiliary_gen_without_resp
        c0 = Clock.new(name:"axi4_wr_auxiliary_gen_without_resp_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_wr_auxiliary_gen_without_resp_rst_n",active:"low")

        stream_en = Logic.new(name:"stream_en")
        id_add_len_in = AxiStream.new(name:"id_add_len_in",clock:c0,reset:r0)
        axi_wr_aux = Axi4.new(name:"axi_wr_aux",clock:c0,reset:r0)


        AxiStream.axi4_wr_auxiliary_gen_without_resp(stream_en:stream_en,id_add_len_in:id_add_len_in,axi_wr_aux:axi_wr_aux)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_wr_auxiliary_gen_without_resp(
        stream_en:"stream_en",
        id_add_len_in:"id_add_len_in",
        axi_wr_aux:"axi_wr_aux")
        hash = TdlHash.new

        unless stream_en.is_a? Hash
            # hash.new_index(:stream_en) = stream_en
            if stream_en.is_a? BaseElm
                hash.[]=(:stream_en,stream_en,true);hash[:stream_en];
                # hash.[]=(:stream_en,stream_en,false)
            elsif stream_en.is_a? GlobalSignalProc
                hash.[]=(:stream_en,stream_en,true)
            else
                hash.[]=(:stream_en,stream_en,false)
            end
        else
            # hash.new_index(:stream_en)= lambda { a = Logic.new(stream_en);a.name = "stream_en";return a }
            # hash[:stream_en] = lambda { a = Logic.new(stream_en);a.name = "stream_en";return a }
            raise TdlError.new('axi4_wr_auxiliary_gen_without_resp Logic stream_en TdlHash cant include Proc') if stream_en.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Logic.new(stream_en)
                unless stream_en[:name]
                    a.name = "stream_en"
                end
                return a }
            hash.[]=(:stream_en,lam,false)
        end


        unless id_add_len_in.is_a? Hash
            # hash.new_index(:id_add_len_in) = id_add_len_in
            if id_add_len_in.is_a? BaseElm
                hash.[]=(:id_add_len_in,id_add_len_in,true);hash[:id_add_len_in];
                # hash.[]=(:id_add_len_in,id_add_len_in,false)
            elsif id_add_len_in.is_a? GlobalSignalProc
                hash.[]=(:id_add_len_in,id_add_len_in,true)
            else
                hash.[]=(:id_add_len_in,id_add_len_in,false)
            end
        else
            # hash.new_index(:id_add_len_in)= lambda { a = AxiStream.new(id_add_len_in);a.name = "id_add_len_in";return a }
            # hash[:id_add_len_in] = lambda { a = AxiStream.new(id_add_len_in);a.name = "id_add_len_in";return a }
            raise TdlError.new('axi4_wr_auxiliary_gen_without_resp AxiStream id_add_len_in TdlHash cant include Proc') if id_add_len_in.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = AxiStream.new(id_add_len_in)
                unless id_add_len_in[:name]
                    a.name = "id_add_len_in"
                end
                return a }
            hash.[]=(:id_add_len_in,lam,false)
        end


        unless axi_wr_aux.is_a? Hash
            # hash.new_index(:axi_wr_aux) = axi_wr_aux
            if axi_wr_aux.is_a? BaseElm
                hash.[]=(:axi_wr_aux,axi_wr_aux,true);hash[:axi_wr_aux];
                # hash.[]=(:axi_wr_aux,axi_wr_aux,false)
            elsif axi_wr_aux.is_a? GlobalSignalProc
                hash.[]=(:axi_wr_aux,axi_wr_aux,true)
            else
                hash.[]=(:axi_wr_aux,axi_wr_aux,false)
            end
        else
            # hash.new_index(:axi_wr_aux)= lambda { a = Axi4.new(axi_wr_aux);a.name = "axi_wr_aux";return a }
            # hash[:axi_wr_aux] = lambda { a = Axi4.new(axi_wr_aux);a.name = "axi_wr_aux";return a }
            raise TdlError.new('axi4_wr_auxiliary_gen_without_resp Axi4 axi_wr_aux TdlHash cant include Proc') if axi_wr_aux.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(axi_wr_aux)
                unless axi_wr_aux[:name]
                    a.name = "axi_wr_aux"
                end
                return a }
            hash.[]=(:axi_wr_aux,lam,false)
        end


        Tdl.module_stack  << lambda {
            hash.each do |k,v|
                if v.is_a? Proc
                    hash.[]=(k,v.call,false)
                elsif v.is_a? Array
                #    unless v.empty?
                #        if v[0].is_a? Axi4
                #            cm = v[0].copy(name:k,idsize:Math.log2(v.length).ceil+v[0].idsize)
                #        else
                #            cm = v[0].copy(name:k)
                #        end
                #        cm.<<(*v)
                #        # hash[k] = cm
                #        hash.[]=(k,cm)
                #    else
                #        hash.[]=(k,nil,false)
                #    end
                else
                    # hash[k] = v
                end
            end
            hash.check_use("axi4_wr_auxiliary_gen_without_resp")
            AxiStream.axi4_wr_auxiliary_gen_without_resp(hash)
        }
        hash.open_error = true
        return hash
    end
end
