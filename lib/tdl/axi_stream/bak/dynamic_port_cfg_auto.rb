
#2017-07-18 14:34:28 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiStream


    def _dynamic_port_cfg(udp_port:"udp_port",port_index:"port_index",valid:"valid",tap_ex_udp_ctrl_inf:"tap_ex_udp_ctrl_inf",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _dynamic_port_cfg_draw(udp_port:udp_port,port_index:port_index,valid:valid,tap_ex_udp_ctrl_inf:tap_ex_udp_ctrl_inf,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _dynamic_port_cfg_draw(udp_port:"udp_port",port_index:"port_index",valid:"valid",tap_ex_udp_ctrl_inf:"tap_ex_udp_ctrl_inf",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        large_name_len(udp_port,port_index,valid,tap_ex_udp_ctrl_inf,tap_local_udp_ctrl_inf,tap_broadcast_udp_inf,send_inf)
"
dynamic_port_cfg dynamic_port_cfg_#{signal}_inst(
/*  output [15:0]        */ .udp_port               (#{align_signal(udp_port,q_mark=false)}),
/*  output [7:0]         */ .port_index             (#{align_signal(port_index,q_mark=false)}),
/*  output               */ .valid                  (#{align_signal(valid,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .tap_ex_udp_ctrl_inf    (#{align_signal(tap_ex_udp_ctrl_inf,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .tap_local_udp_ctrl_inf (#{align_signal(tap_local_udp_ctrl_inf,q_mark=false)}),
/*  axi_stream_inf.mirror*/ .tap_broadcast_udp_inf  (#{align_signal(tap_broadcast_udp_inf,q_mark=false)}),
/*  axi_stream_inf.master*/ .send_inf               (#{align_signal(send_inf,q_mark=false)})
);
"
    end
    
    def self.dynamic_port_cfg(udp_port:"udp_port",port_index:"port_index",valid:"valid",tap_ex_udp_ctrl_inf:"tap_ex_udp_ctrl_inf",tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",tap_broadcast_udp_inf:"tap_broadcast_udp_inf",send_inf:"send_inf")
        return_stream = nil
        
        
        NC._dynamic_port_cfg(udp_port:udp_port,port_index:port_index,valid:valid,tap_ex_udp_ctrl_inf:tap_ex_udp_ctrl_inf,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_dynamic_port_cfg
        c0 = Clock.new(name:"dynamic_port_cfg_clk",freqM:148.5)
        r0 = Reset.new(name:"dynamic_port_cfg_rst_n",active:"low")

        Logic.new(name:"udp_port")
        Logic.new(name:"port_index")
        Logic.new(name:"valid")
        AxiStream.new(name:"tap_ex_udp_ctrl_inf",clock:c0,reset:r0)
        AxiStream.new(name:"tap_local_udp_ctrl_inf",clock:c0,reset:r0)
        AxiStream.new(name:"tap_broadcast_udp_inf",clock:c0,reset:r0)
        AxiStream.new(name:"send_inf",clock:c0,reset:r0)
        
        
        AxiStream.dynamic_port_cfg(udp_port:udp_port,port_index:port_index,valid:valid,tap_ex_udp_ctrl_inf:tap_ex_udp_ctrl_inf,tap_local_udp_ctrl_inf:tap_local_udp_ctrl_inf,tap_broadcast_udp_inf:tap_broadcast_udp_inf,send_inf:send_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_dynamic_port_cfg(udp_port:"udp_port",
        port_index:"port_index",
        valid:"valid",
        tap_ex_udp_ctrl_inf:"tap_ex_udp_ctrl_inf",
        tap_local_udp_ctrl_inf:"tap_local_udp_ctrl_inf",
        tap_broadcast_udp_inf:"tap_broadcast_udp_inf",
        send_inf:"send_inf")
        hash = TdlHash.new
        
        unless udp_port.is_a? Hash
            # hash.new_index(:udp_port) = udp_port
            if udp_port.is_a? BaseElm
                hash.[]=(:udp_port,udp_port,true)
            else
                hash.[]=(:udp_port,udp_port,false)
            end
        else
            # hash.new_index(:udp_port)= lambda { a = Logic.new(udp_port);a.name = "udp_port";return a }
            # hash[:udp_port] = lambda { a = Logic.new(udp_port);a.name = "udp_port";return a }
            lam = lambda {
                a = Logic.new(udp_port)
                unless udp_port[:name]
                    a.name = "udp_port"
                end
                return a }
            hash.[]=(:udp_port,lam,false)
        end
                

        unless port_index.is_a? Hash
            # hash.new_index(:port_index) = port_index
            if port_index.is_a? BaseElm
                hash.[]=(:port_index,port_index,true)
            else
                hash.[]=(:port_index,port_index,false)
            end
        else
            # hash.new_index(:port_index)= lambda { a = Logic.new(port_index);a.name = "port_index";return a }
            # hash[:port_index] = lambda { a = Logic.new(port_index);a.name = "port_index";return a }
            lam = lambda {
                a = Logic.new(port_index)
                unless port_index[:name]
                    a.name = "port_index"
                end
                return a }
            hash.[]=(:port_index,lam,false)
        end
                

        unless valid.is_a? Hash
            # hash.new_index(:valid) = valid
            if valid.is_a? BaseElm
                hash.[]=(:valid,valid,true)
            else
                hash.[]=(:valid,valid,false)
            end
        else
            # hash.new_index(:valid)= lambda { a = Logic.new(valid);a.name = "valid";return a }
            # hash[:valid] = lambda { a = Logic.new(valid);a.name = "valid";return a }
            lam = lambda {
                a = Logic.new(valid)
                unless valid[:name]
                    a.name = "valid"
                end
                return a }
            hash.[]=(:valid,lam,false)
        end
                

        unless tap_ex_udp_ctrl_inf.is_a? Hash
            # hash.new_index(:tap_ex_udp_ctrl_inf) = tap_ex_udp_ctrl_inf
            if tap_ex_udp_ctrl_inf.is_a? BaseElm
                hash.[]=(:tap_ex_udp_ctrl_inf,tap_ex_udp_ctrl_inf,true)
            else
                hash.[]=(:tap_ex_udp_ctrl_inf,tap_ex_udp_ctrl_inf,false)
            end
        else
            # hash.new_index(:tap_ex_udp_ctrl_inf)= lambda { a = AxiStream.new(tap_ex_udp_ctrl_inf);a.name = "tap_ex_udp_ctrl_inf";return a }
            # hash[:tap_ex_udp_ctrl_inf] = lambda { a = AxiStream.new(tap_ex_udp_ctrl_inf);a.name = "tap_ex_udp_ctrl_inf";return a }
            lam = lambda {
                a = AxiStream.new(tap_ex_udp_ctrl_inf)
                unless tap_ex_udp_ctrl_inf[:name]
                    a.name = "tap_ex_udp_ctrl_inf"
                end
                return a }
            hash.[]=(:tap_ex_udp_ctrl_inf,lam,false)
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
            hash.check_use("dynamic_port_cfg")
            AxiStream.dynamic_port_cfg(hash)
        }
        return hash
    end
end
