
#2017-07-18 14:34:28 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _dynnamic_addr_cfg(server_ip:"server_ip",server_mac:"server_mac",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _dynnamic_addr_cfg_draw(server_ip:server_ip,server_mac:server_mac,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _dynnamic_addr_cfg_draw(server_ip:"server_ip",server_mac:"server_mac",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        large_name_len(server_ip,server_mac,tap_local_udp_ctrl_inf,tap_broadcast_udp_inf,send_inf)
"
dynnamic_addr_cfg dynnamic_addr_cfg_#{signal}_inst(
/*  output [31:0]        */ .server_ip              (#{align_signal(server_ip,q_mark=false)}),
/*  output [47:0]        */ .server_mac             (#{align_signal(server_mac,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .tap_local_udp_ctrl_inf (#{align_signal(tap_local_udp_ctrl_inf,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .tap_broadcast_udp_inf  (#{align_signal(tap_broadcast_udp_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .send_inf               (#{align_signal(send_inf,q_mark=false)})
);
"
    end
    
    def self.dynnamic_addr_cfg(server_ip:"server_ip",server_mac:"server_mac",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        return_stream = nil
        
        
        NC._dynnamic_addr_cfg(server_ip:server_ip,server_mac:server_mac,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_dynnamic_addr_cfg
        c0 = Clock.new(name:"dynnamic_addr_cfg_clk",freqM:148.5)
        r0 = Reset.new(name:"dynnamic_addr_cfg_rst_n",active:"low")

        Logic.new(name:"server_ip")
        Logic.new(name:"server_mac")
        AxiStream.new(name:"tap_local_udp_ctrl_inf",clock:c0,reset:r0)
        AxiStream.new(name:"tap_broadcast_udp_inf",clock:c0,reset:r0)
        AxiStream.new(name:"send_inf",clock:c0,reset:r0)
        
        
        AxiStream.dynnamic_addr_cfg(server_ip:server_ip,server_mac:server_mac,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_dynnamic_addr_cfg(server_ip:"server_ip",
        server_mac:"server_mac",
        tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",
        tap_broadcast_udp_inf:"tap_broadcast_udp_inf",
        send_inf:"send_inf")
        hash = TdlHash.new
        
        unless server_ip.is_a? Hash
            # hash.new_index(:server_ip) = server_ip
            if server_ip.is_a? BaseElm
                hash.[]=(:server_ip,server_ip,true)
            else
                hash.[]=(:server_ip,server_ip,false)
            end
        else
            # hash.new_index(:server_ip)= lambda { a = Logic.new(server_ip);a.name = "server_ip";return a }
            # hash[:server_ip] = lambda { a = Logic.new(server_ip);a.name = "server_ip";return a }
            lam = lambda {
                a = Logic.new(server_ip)
                unless server_ip[:name]
                    a.name = "server_ip"
                end
                return a }
            hash.[]=(:server_ip,lam,false)
        end
                

        unless server_mac.is_a? Hash
            # hash.new_index(:server_mac) = server_mac
            if server_mac.is_a? BaseElm
                hash.[]=(:server_mac,server_mac,true)
            else
                hash.[]=(:server_mac,server_mac,false)
            end
        else
            # hash.new_index(:server_mac)= lambda { a = Logic.new(server_mac);a.name = "server_mac";return a }
            # hash[:server_mac] = lambda { a = Logic.new(server_mac);a.name = "server_mac";return a }
            lam = lambda {
                a = Logic.new(server_mac)
                unless server_mac[:name]
                    a.name = "server_mac"
                end
                return a }
            hash.[]=(:server_mac,lam,false)
        end
                

        unless tap_local_udp_ctrl_inf.is_a? Hash
            # hash.new_index(:tap_local_udp_ctrl_inf) = tap_local_udp_ctrl_inf
            if tap_local_udp_ctrl_inf.is_a? BaseElm
                hash.[]=(:tap_local_udp_ctrl_inf,tap_local_udp_ctrl_inf,true)
            else
                hash.[]=(:tap_local_udp_ctrl_inf,tap_local_udp_ctrl_inf,false)
            end
        else
            # hash.new_index(:tap_local_udp_ctrl_inf)= lambda { a = AxiStream.new(tap_local_udp_ctrl_inf);a.name = "tap_local_udp_ctrl_inf";return a }
            # hash[:tap_local_udp_ctrl_inf] = lambda { a = AxiStream.new(tap_local_udp_ctrl_inf);a.name = "tap_local_udp_ctrl_inf";return a }
            lam = lambda {
                a = AxiStream.new(tap_local_udp_ctrl_inf)
                unless tap_local_udp_ctrl_inf[:name]
                    a.name = "tap_local_udp_ctrl_inf"
                end
                return a }
            hash.[]=(:tap_local_udp_ctrl_inf,lam,false)
        end
                

        unless tap_broadcast_udp_inf.is_a? Hash
            # hash.new_index(:tap_broadcast_udp_inf) = tap_broadcast_udp_inf
            if tap_broadcast_udp_inf.is_a? BaseElm
                hash.[]=(:tap_broadcast_udp_inf,tap_broadcast_udp_inf,true)
            else
                hash.[]=(:tap_broadcast_udp_inf,tap_broadcast_udp_inf,false)
            end
        else
            # hash.new_index(:tap_broadcast_udp_inf)= lambda { a = AxiStream.new(tap_broadcast_udp_inf);a.name = "tap_broadcast_udp_inf";return a }
            # hash[:tap_broadcast_udp_inf] = lambda { a = AxiStream.new(tap_broadcast_udp_inf);a.name = "tap_broadcast_udp_inf";return a }
            lam = lambda {
                a = AxiStream.new(tap_broadcast_udp_inf)
                unless tap_broadcast_udp_inf[:name]
                    a.name = "tap_broadcast_udp_inf"
                end
                return a }
            hash.[]=(:tap_broadcast_udp_inf,lam,false)
        end
                

        unless send_inf.is_a? Hash
            # hash.new_index(:send_inf) = send_inf
            if send_inf.is_a? BaseElm
                hash.[]=(:send_inf,send_inf,true)
            else
                hash.[]=(:send_inf,send_inf,false)
            end
        else
            # hash.new_index(:send_inf)= lambda { a = AxiStream.new(send_inf);a.name = "send_inf";return a }
            # hash[:send_inf] = lambda { a = AxiStream.new(send_inf);a.name = "send_inf";return a }
            lam = lambda {
                a = AxiStream.new(send_inf)
                unless send_inf[:name]
                    a.name = "send_inf"
                end
                return a }
            hash.[]=(:send_inf,lam,false)
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
            hash.check_use("dynnamic_addr_cfg")
            AxiStream.dynnamic_addr_cfg(hash)
        }
        return hash
    end
end
