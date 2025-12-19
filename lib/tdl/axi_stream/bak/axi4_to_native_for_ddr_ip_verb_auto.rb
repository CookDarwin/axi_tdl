
#2017-06-26 17:55:08 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_to_native_for_ddr_ip_verb(addr_width:27,data_width:256,app_addr:"app_addr",app_cmd:"app_cmd",app_en:"app_en",app_wdf_data:"app_wdf_data",app_wdf_end:"app_wdf_end",app_wdf_mask:"app_wdf_mask",app_wdf_wren:"app_wdf_wren",app_rd_data:"app_rd_data",app_rd_data_end:"app_rd_data_end",app_rd_data_valid:"app_rd_data_valid",app_rdy:"app_rdy",app_wdf_rdy:"app_wdf_rdy",init_calib_complete:"init_calib_complete",axi_inf:"axi_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _axi4_to_native_for_ddr_ip_verb_draw(addr_width:addr_width,data_width:data_width,app_addr:app_addr,app_cmd:app_cmd,app_en:app_en,app_wdf_data:app_wdf_data,app_wdf_end:app_wdf_end,app_wdf_mask:app_wdf_mask,app_wdf_wren:app_wdf_wren,app_rd_data:app_rd_data,app_rd_data_end:app_rd_data_end,app_rd_data_valid:app_rd_data_valid,app_rdy:app_rdy,app_wdf_rdy:app_wdf_rdy,init_calib_complete:init_calib_complete,axi_inf:axi_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _axi4_to_native_for_ddr_ip_verb_draw(addr_width:27,data_width:256,app_addr:"app_addr",app_cmd:"app_cmd",app_en:"app_en",app_wdf_data:"app_wdf_data",app_wdf_end:"app_wdf_end",app_wdf_mask:"app_wdf_mask",app_wdf_wren:"app_wdf_wren",app_rd_data:"app_rd_data",app_rd_data_end:"app_rd_data_end",app_rd_data_valid:"app_rd_data_valid",app_rdy:"app_rdy",app_wdf_rdy:"app_wdf_rdy",init_calib_complete:"init_calib_complete",axi_inf:"axi_inf")
        large_name_len(addr_width,data_width,app_addr,app_cmd,app_en,app_wdf_data,app_wdf_end,app_wdf_mask,app_wdf_wren,app_rd_data,app_rd_data_end,app_rd_data_valid,app_rdy,app_wdf_rdy,init_calib_complete,axi_inf)
"
axi4_to_native_for_ddr_ip_verb#(
    .ADDR_WIDTH    (#{align_signal(addr_width)}),
    .DATA_WIDTH    (#{align_signal(data_width)})
) axi4_to_native_for_ddr_ip_verb_#{signal}_inst(
/*  output [ADDR_WIDTH-1:0]  */ .app_addr            (#{align_signal(app_addr,q_mark=false)}),
/*  output [2:0]             */ .app_cmd             (#{align_signal(app_cmd,q_mark=false)}),
/*  output                   */ .app_en              (#{align_signal(app_en,q_mark=false)}),
/*  output [DATA_WIDTH-1:0]  */ .app_wdf_data        (#{align_signal(app_wdf_data,q_mark=false)}),
/*  output                   */ .app_wdf_end         (#{align_signal(app_wdf_end,q_mark=false)}),
/*  output [DATA_WIDTH/8-1:0]*/ .app_wdf_mask        (#{align_signal(app_wdf_mask,q_mark=false)}),
/*  output                   */ .app_wdf_wren        (#{align_signal(app_wdf_wren,q_mark=false)}),
/*  input  [DATA_WIDTH-1:0]  */ .app_rd_data         (#{align_signal(app_rd_data,q_mark=false)}),
/*  input                    */ .app_rd_data_end     (#{align_signal(app_rd_data_end,q_mark=false)}),
/*  input                    */ .app_rd_data_valid   (#{align_signal(app_rd_data_valid,q_mark=false)}),
/*  input                    */ .app_rdy             (#{align_signal(app_rdy,q_mark=false)}),
/*  input                    */ .app_wdf_rdy         (#{align_signal(app_wdf_rdy,q_mark=false)}),
/*  input                    */ .init_calib_complete (#{align_signal(init_calib_complete,q_mark=false)}),
/*  axi_inf.slaver           */ .axi_inf             (#{align_signal(axi_inf,q_mark=false)})
);
"
    end
    
    def self.axi4_to_native_for_ddr_ip_verb(addr_width:27,data_width:256,app_addr:"app_addr",app_cmd:"app_cmd",app_en:"app_en",app_wdf_data:"app_wdf_data",app_wdf_end:"app_wdf_end",app_wdf_mask:"app_wdf_mask",app_wdf_wren:"app_wdf_wren",app_rd_data:"app_rd_data",app_rd_data_end:"app_rd_data_end",app_rd_data_valid:"app_rd_data_valid",app_rdy:"app_rdy",app_wdf_rdy:"app_wdf_rdy",init_calib_complete:"init_calib_complete",axi_inf:"axi_inf")
        return_stream = nil
        
        
        NC._axi4_to_native_for_ddr_ip_verb(addr_width:addr_width,data_width:data_width,app_addr:app_addr,app_cmd:app_cmd,app_en:app_en,app_wdf_data:app_wdf_data,app_wdf_end:app_wdf_end,app_wdf_mask:app_wdf_mask,app_wdf_wren:app_wdf_wren,app_rd_data:app_rd_data,app_rd_data_end:app_rd_data_end,app_rd_data_valid:app_rd_data_valid,app_rdy:app_rdy,app_wdf_rdy:app_wdf_rdy,init_calib_complete:init_calib_complete,axi_inf:axi_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_to_native_for_ddr_ip_verb
        c0 = Clock.new(name:"axi4_to_native_for_ddr_ip_verb_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_to_native_for_ddr_ip_verb_rst_n",active:"low")

        Parameter.new(name:"addr_width",value:27)
        Parameter.new(name:"data_width",value:256)
        Logic.new(name:"app_addr")
        Logic.new(name:"app_cmd")
        Logic.new(name:"app_en")
        Logic.new(name:"app_wdf_data")
        Logic.new(name:"app_wdf_end")
        Logic.new(name:"app_wdf_mask")
        Logic.new(name:"app_wdf_wren")
        Logic.new(name:"app_rd_data")
        Logic.new(name:"app_rd_data_end")
        Logic.new(name:"app_rd_data_valid")
        Logic.new(name:"app_rdy")
        Logic.new(name:"app_wdf_rdy")
        Logic.new(name:"init_calib_complete")
        Axi4.new(name:"axi_inf",clock:c0,reset:r0)
        
        
        Axi4.axi4_to_native_for_ddr_ip_verb(addr_width:addr_width,data_width:data_width,app_addr:app_addr,app_cmd:app_cmd,app_en:app_en,app_wdf_data:app_wdf_data,app_wdf_end:app_wdf_end,app_wdf_mask:app_wdf_mask,app_wdf_wren:app_wdf_wren,app_rd_data:app_rd_data,app_rd_data_end:app_rd_data_end,app_rd_data_valid:app_rd_data_valid,app_rdy:app_rdy,app_wdf_rdy:app_wdf_rdy,init_calib_complete:init_calib_complete,axi_inf:axi_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_axi4_to_native_for_ddr_ip_verb(addr_width:27,data_width:256,app_addr:"app_addr",app_cmd:"app_cmd",app_en:"app_en",app_wdf_data:"app_wdf_data",app_wdf_end:"app_wdf_end",app_wdf_mask:"app_wdf_mask",app_wdf_wren:"app_wdf_wren",app_rd_data:"app_rd_data",app_rd_data_end:"app_rd_data_end",app_rd_data_valid:"app_rd_data_valid",app_rdy:"app_rdy",app_wdf_rdy:"app_wdf_rdy",init_calib_complete:"init_calib_complete",axi_inf:"axi_inf")
        hash = TdlHash.new
        
        unless addr_width.is_a? Hash
            # hash.new_index(:addr_width) = addr_width
            if addr_width.is_a? InfElm
                hash.[]=(:addr_width,addr_width,true)
            else
                hash.[]=(:addr_width,addr_width,false)
            end
        else
            # hash.new_index(:addr_width)= lambda { a = Parameter.new(addr_width);a.name = "addr_width";return a }
            # hash[:addr_width] = lambda { a = Parameter.new(addr_width);a.name = "addr_width";return a }
            hash.[]=(:addr_width,lambda { a = Parameter.new(addr_width);a.name = "addr_width";return a },false)
        end
                

        unless data_width.is_a? Hash
            # hash.new_index(:data_width) = data_width
            if data_width.is_a? InfElm
                hash.[]=(:data_width,data_width,true)
            else
                hash.[]=(:data_width,data_width,false)
            end
        else
            # hash.new_index(:data_width)= lambda { a = Parameter.new(data_width);a.name = "data_width";return a }
            # hash[:data_width] = lambda { a = Parameter.new(data_width);a.name = "data_width";return a }
            hash.[]=(:data_width,lambda { a = Parameter.new(data_width);a.name = "data_width";return a },false)
        end
                

        unless app_addr.is_a? Hash
            # hash.new_index(:app_addr) = app_addr
            if app_addr.is_a? InfElm
                hash.[]=(:app_addr,app_addr,true)
            else
                hash.[]=(:app_addr,app_addr,false)
            end
        else
            # hash.new_index(:app_addr)= lambda { a = Logic.new(app_addr);a.name = "app_addr";return a }
            # hash[:app_addr] = lambda { a = Logic.new(app_addr);a.name = "app_addr";return a }
            hash.[]=(:app_addr,lambda { a = Logic.new(app_addr);a.name = "app_addr";return a },false)
        end
                

        unless app_cmd.is_a? Hash
            # hash.new_index(:app_cmd) = app_cmd
            if app_cmd.is_a? InfElm
                hash.[]=(:app_cmd,app_cmd,true)
            else
                hash.[]=(:app_cmd,app_cmd,false)
            end
        else
            # hash.new_index(:app_cmd)= lambda { a = Logic.new(app_cmd);a.name = "app_cmd";return a }
            # hash[:app_cmd] = lambda { a = Logic.new(app_cmd);a.name = "app_cmd";return a }
            hash.[]=(:app_cmd,lambda { a = Logic.new(app_cmd);a.name = "app_cmd";return a },false)
        end
                

        unless app_en.is_a? Hash
            # hash.new_index(:app_en) = app_en
            if app_en.is_a? InfElm
                hash.[]=(:app_en,app_en,true)
            else
                hash.[]=(:app_en,app_en,false)
            end
        else
            # hash.new_index(:app_en)= lambda { a = Logic.new(app_en);a.name = "app_en";return a }
            # hash[:app_en] = lambda { a = Logic.new(app_en);a.name = "app_en";return a }
            hash.[]=(:app_en,lambda { a = Logic.new(app_en);a.name = "app_en";return a },false)
        end
                

        unless app_wdf_data.is_a? Hash
            # hash.new_index(:app_wdf_data) = app_wdf_data
            if app_wdf_data.is_a? InfElm
                hash.[]=(:app_wdf_data,app_wdf_data,true)
            else
                hash.[]=(:app_wdf_data,app_wdf_data,false)
            end
        else
            # hash.new_index(:app_wdf_data)= lambda { a = Logic.new(app_wdf_data);a.name = "app_wdf_data";return a }
            # hash[:app_wdf_data] = lambda { a = Logic.new(app_wdf_data);a.name = "app_wdf_data";return a }
            hash.[]=(:app_wdf_data,lambda { a = Logic.new(app_wdf_data);a.name = "app_wdf_data";return a },false)
        end
                

        unless app_wdf_end.is_a? Hash
            # hash.new_index(:app_wdf_end) = app_wdf_end
            if app_wdf_end.is_a? InfElm
                hash.[]=(:app_wdf_end,app_wdf_end,true)
            else
                hash.[]=(:app_wdf_end,app_wdf_end,false)
            end
        else
            # hash.new_index(:app_wdf_end)= lambda { a = Logic.new(app_wdf_end);a.name = "app_wdf_end";return a }
            # hash[:app_wdf_end] = lambda { a = Logic.new(app_wdf_end);a.name = "app_wdf_end";return a }
            hash.[]=(:app_wdf_end,lambda { a = Logic.new(app_wdf_end);a.name = "app_wdf_end";return a },false)
        end
                

        unless app_wdf_mask.is_a? Hash
            # hash.new_index(:app_wdf_mask) = app_wdf_mask
            if app_wdf_mask.is_a? InfElm
                hash.[]=(:app_wdf_mask,app_wdf_mask,true)
            else
                hash.[]=(:app_wdf_mask,app_wdf_mask,false)
            end
        else
            # hash.new_index(:app_wdf_mask)= lambda { a = Logic.new(app_wdf_mask);a.name = "app_wdf_mask";return a }
            # hash[:app_wdf_mask] = lambda { a = Logic.new(app_wdf_mask);a.name = "app_wdf_mask";return a }
            hash.[]=(:app_wdf_mask,lambda { a = Logic.new(app_wdf_mask);a.name = "app_wdf_mask";return a },false)
        end
                

        unless app_wdf_wren.is_a? Hash
            # hash.new_index(:app_wdf_wren) = app_wdf_wren
            if app_wdf_wren.is_a? InfElm
                hash.[]=(:app_wdf_wren,app_wdf_wren,true)
            else
                hash.[]=(:app_wdf_wren,app_wdf_wren,false)
            end
        else
            # hash.new_index(:app_wdf_wren)= lambda { a = Logic.new(app_wdf_wren);a.name = "app_wdf_wren";return a }
            # hash[:app_wdf_wren] = lambda { a = Logic.new(app_wdf_wren);a.name = "app_wdf_wren";return a }
            hash.[]=(:app_wdf_wren,lambda { a = Logic.new(app_wdf_wren);a.name = "app_wdf_wren";return a },false)
        end
                

        unless app_rd_data.is_a? Hash
            # hash.new_index(:app_rd_data) = app_rd_data
            if app_rd_data.is_a? InfElm
                hash.[]=(:app_rd_data,app_rd_data,true)
            else
                hash.[]=(:app_rd_data,app_rd_data,false)
            end
        else
            # hash.new_index(:app_rd_data)= lambda { a = Logic.new(app_rd_data);a.name = "app_rd_data";return a }
            # hash[:app_rd_data] = lambda { a = Logic.new(app_rd_data);a.name = "app_rd_data";return a }
            hash.[]=(:app_rd_data,lambda { a = Logic.new(app_rd_data);a.name = "app_rd_data";return a },false)
        end
                

        unless app_rd_data_end.is_a? Hash
            # hash.new_index(:app_rd_data_end) = app_rd_data_end
            if app_rd_data_end.is_a? InfElm
                hash.[]=(:app_rd_data_end,app_rd_data_end,true)
            else
                hash.[]=(:app_rd_data_end,app_rd_data_end,false)
            end
        else
            # hash.new_index(:app_rd_data_end)= lambda { a = Logic.new(app_rd_data_end);a.name = "app_rd_data_end";return a }
            # hash[:app_rd_data_end] = lambda { a = Logic.new(app_rd_data_end);a.name = "app_rd_data_end";return a }
            hash.[]=(:app_rd_data_end,lambda { a = Logic.new(app_rd_data_end);a.name = "app_rd_data_end";return a },false)
        end
                

        unless app_rd_data_valid.is_a? Hash
            # hash.new_index(:app_rd_data_valid) = app_rd_data_valid
            if app_rd_data_valid.is_a? InfElm
                hash.[]=(:app_rd_data_valid,app_rd_data_valid,true)
            else
                hash.[]=(:app_rd_data_valid,app_rd_data_valid,false)
            end
        else
            # hash.new_index(:app_rd_data_valid)= lambda { a = Logic.new(app_rd_data_valid);a.name = "app_rd_data_valid";return a }
            # hash[:app_rd_data_valid] = lambda { a = Logic.new(app_rd_data_valid);a.name = "app_rd_data_valid";return a }
            hash.[]=(:app_rd_data_valid,lambda { a = Logic.new(app_rd_data_valid);a.name = "app_rd_data_valid";return a },false)
        end
                

        unless app_rdy.is_a? Hash
            # hash.new_index(:app_rdy) = app_rdy
            if app_rdy.is_a? InfElm
                hash.[]=(:app_rdy,app_rdy,true)
            else
                hash.[]=(:app_rdy,app_rdy,false)
            end
        else
            # hash.new_index(:app_rdy)= lambda { a = Logic.new(app_rdy);a.name = "app_rdy";return a }
            # hash[:app_rdy] = lambda { a = Logic.new(app_rdy);a.name = "app_rdy";return a }
            hash.[]=(:app_rdy,lambda { a = Logic.new(app_rdy);a.name = "app_rdy";return a },false)
        end
                

        unless app_wdf_rdy.is_a? Hash
            # hash.new_index(:app_wdf_rdy) = app_wdf_rdy
            if app_wdf_rdy.is_a? InfElm
                hash.[]=(:app_wdf_rdy,app_wdf_rdy,true)
            else
                hash.[]=(:app_wdf_rdy,app_wdf_rdy,false)
            end
        else
            # hash.new_index(:app_wdf_rdy)= lambda { a = Logic.new(app_wdf_rdy);a.name = "app_wdf_rdy";return a }
            # hash[:app_wdf_rdy] = lambda { a = Logic.new(app_wdf_rdy);a.name = "app_wdf_rdy";return a }
            hash.[]=(:app_wdf_rdy,lambda { a = Logic.new(app_wdf_rdy);a.name = "app_wdf_rdy";return a },false)
        end
                

        unless init_calib_complete.is_a? Hash
            # hash.new_index(:init_calib_complete) = init_calib_complete
            if init_calib_complete.is_a? InfElm
                hash.[]=(:init_calib_complete,init_calib_complete,true)
            else
                hash.[]=(:init_calib_complete,init_calib_complete,false)
            end
        else
            # hash.new_index(:init_calib_complete)= lambda { a = Logic.new(init_calib_complete);a.name = "init_calib_complete";return a }
            # hash[:init_calib_complete] = lambda { a = Logic.new(init_calib_complete);a.name = "init_calib_complete";return a }
            hash.[]=(:init_calib_complete,lambda { a = Logic.new(init_calib_complete);a.name = "init_calib_complete";return a },false)
        end
                

        unless axi_inf.is_a? Hash
            # hash.new_index(:axi_inf) = axi_inf
            if axi_inf.is_a? InfElm
                hash.[]=(:axi_inf,axi_inf,true)
            else
                hash.[]=(:axi_inf,axi_inf,false)
            end
        else
            # hash.new_index(:axi_inf)= lambda { a = Axi4.new(axi_inf);a.name = "axi_inf";return a }
            # hash[:axi_inf] = lambda { a = Axi4.new(axi_inf);a.name = "axi_inf";return a }
            hash.[]=(:axi_inf,lambda { a = Axi4.new(axi_inf);a.name = "axi_inf";return a },false)
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
            hash.check_use("axi4_to_native_for_ddr_ip_verb")
            Axi4.axi4_to_native_for_ddr_ip_verb(hash)
        }
        return hash
    end
end
