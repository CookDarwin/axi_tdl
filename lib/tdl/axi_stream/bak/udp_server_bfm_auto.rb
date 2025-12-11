
#2017-07-18 14:34:28 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _udp_server_bfm(tx_udp_inf:"tx_udp_inf",rx_udp_inf:"rx_udp_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _udp_server_bfm_draw(tx_udp_inf:tx_udp_inf,rx_udp_inf:rx_udp_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _udp_server_bfm_draw(tx_udp_inf:"tx_udp_inf",rx_udp_inf:"rx_udp_inf")
        large_name_len(tx_udp_inf,rx_udp_inf)
"
udp_server_bfm udp_server_bfm_#{signal}_inst(
/*  axi_stream_inf.master*/ .tx_udp_inf (#{align_signal(tx_udp_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .rx_udp_inf (#{align_signal(rx_udp_inf,q_mark=false)})
);
"
    end
    
    def self.udp_server_bfm(tx_udp_inf:"tx_udp_inf",rx_udp_inf:"rx_udp_inf")
        return_stream = nil
        
        
        NC._udp_server_bfm(tx_udp_inf:tx_udp_inf,rx_udp_inf:rx_udp_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_udp_server_bfm
        c0 = Clock.new(name:"udp_server_bfm_clk",freqM:148.5)
        r0 = Reset.new(name:"udp_server_bfm_rst_n",active:"low")

        AxiStream.new(name:"tx_udp_inf",clock:c0,reset:r0)
        AxiStream.new(name:"rx_udp_inf",clock:c0,reset:r0)
        
        
        AxiStream.udp_server_bfm(tx_udp_inf:tx_udp_inf,rx_udp_inf:rx_udp_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_udp_server_bfm(tx_udp_inf:"tx_udp_inf",
        rx_udp_inf:"rx_udp_inf")
        hash = TdlHash.new
        
        unless tx_udp_inf.is_a? Hash
            # hash.new_index(:tx_udp_inf) = tx_udp_inf
            if tx_udp_inf.is_a? BaseElm
                hash.[]=(:tx_udp_inf,tx_udp_inf,true)
            else
                hash.[]=(:tx_udp_inf,tx_udp_inf,false)
            end
        else
            # hash.new_index(:tx_udp_inf)= lambda { a = AxiStream.new(tx_udp_inf);a.name = "tx_udp_inf";return a }
            # hash[:tx_udp_inf] = lambda { a = AxiStream.new(tx_udp_inf);a.name = "tx_udp_inf";return a }
            lam = lambda {
                a = AxiStream.new(tx_udp_inf)
                unless tx_udp_inf[:name]
                    a.name = "tx_udp_inf"
                end
                return a }
            hash.[]=(:tx_udp_inf,lam,false)
        end
                

        unless rx_udp_inf.is_a? Hash
            # hash.new_index(:rx_udp_inf) = rx_udp_inf
            if rx_udp_inf.is_a? BaseElm
                hash.[]=(:rx_udp_inf,rx_udp_inf,true)
            else
                hash.[]=(:rx_udp_inf,rx_udp_inf,false)
            end
        else
            # hash.new_index(:rx_udp_inf)= lambda { a = AxiStream.new(rx_udp_inf);a.name = "rx_udp_inf";return a }
            # hash[:rx_udp_inf] = lambda { a = AxiStream.new(rx_udp_inf);a.name = "rx_udp_inf";return a }
            lam = lambda {
                a = AxiStream.new(rx_udp_inf)
                unless rx_udp_inf[:name]
                    a.name = "rx_udp_inf"
                end
                return a }
            hash.[]=(:rx_udp_inf,lam,false)
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
            hash.check_use("udp_server_bfm")
            AxiStream.udp_server_bfm(hash)
        }
        return hash
    end
end
