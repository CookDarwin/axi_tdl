
#2017-06-26 17:55:08 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class AxiLite


    def _axis_wrapper_oled(oled_sdin:"oled_sdin",oled_sclk:"oled_sclk",oled_dc:"oled_dc",oled_res:"oled_res",oled_vbat:"oled_vbat",oled_vdd:"oled_vdd",trigger_toggle:"trigger_toggle",lite_ctrl_inf:"lite_ctrl_inf",ctrl_inf:"ctrl_inf")
        return_stream = self
        
        
        

        $_draw = lambda { _axis_wrapper_oled_draw(oled_sdin:oled_sdin,oled_sclk:oled_sclk,oled_dc:oled_dc,oled_res:oled_res,oled_vbat:oled_vbat,oled_vdd:oled_vdd,trigger_toggle:trigger_toggle,lite_ctrl_inf:lite_ctrl_inf,ctrl_inf:ctrl_inf) }
        @correlation_proc += $_draw.call
        return return_stream
    end

    def _axis_wrapper_oled_draw(oled_sdin:"oled_sdin",oled_sclk:"oled_sclk",oled_dc:"oled_dc",oled_res:"oled_res",oled_vbat:"oled_vbat",oled_vdd:"oled_vdd",trigger_toggle:"trigger_toggle",lite_ctrl_inf:"lite_ctrl_inf",ctrl_inf:"ctrl_inf")
        large_name_len(oled_sdin,oled_sclk,oled_dc,oled_res,oled_vbat,oled_vdd,trigger_toggle,lite_ctrl_inf,ctrl_inf)
"
axis_wrapper_oled axis_wrapper_oled_#{signal}_inst(
/*  output               */ .oled_sdin      (#{align_signal(oled_sdin,q_mark=false)}),
/*  output               */ .oled_sclk      (#{align_signal(oled_sclk,q_mark=false)}),
/*  output               */ .oled_dc        (#{align_signal(oled_dc,q_mark=false)}),
/*  output               */ .oled_res       (#{align_signal(oled_res,q_mark=false)}),
/*  output               */ .oled_vbat      (#{align_signal(oled_vbat,q_mark=false)}),
/*  output               */ .oled_vdd       (#{align_signal(oled_vdd,q_mark=false)}),
/*  input                */ .trigger_toggle (#{align_signal(trigger_toggle,q_mark=false)}),
/*  axi_lite_inf.slaver  */ .lite_ctrl_inf  (#{align_signal(lite_ctrl_inf,q_mark=false)}),
/*  axi_stream_inf.slaver*/ .ctrl_inf       (#{align_signal(ctrl_inf,q_mark=false)})
);
"
    end
    
    def self.axis_wrapper_oled(oled_sdin:"oled_sdin",oled_sclk:"oled_sclk",oled_dc:"oled_dc",oled_res:"oled_res",oled_vbat:"oled_vbat",oled_vdd:"oled_vdd",trigger_toggle:"trigger_toggle",lite_ctrl_inf:"lite_ctrl_inf",ctrl_inf:"ctrl_inf")
        return_stream = nil
        
        
        NC._axis_wrapper_oled(oled_sdin:oled_sdin,oled_sclk:oled_sclk,oled_dc:oled_dc,oled_res:oled_res,oled_vbat:oled_vbat,oled_vdd:oled_vdd,trigger_toggle:trigger_toggle,lite_ctrl_inf:lite_ctrl_inf,ctrl_inf:ctrl_inf)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axis_wrapper_oled
        c0 = Clock.new(name:"axis_wrapper_oled_clk",freqM:148.5)
        r0 = Reset.new(name:"axis_wrapper_oled_rst_n",active:"low")

        Logic.new(name:"oled_sdin")
        Logic.new(name:"oled_sclk")
        Logic.new(name:"oled_dc")
        Logic.new(name:"oled_res")
        Logic.new(name:"oled_vbat")
        Logic.new(name:"oled_vdd")
        Logic.new(name:"trigger_toggle")
        AxiLite.new(name:"lite_ctrl_inf",clock:c0,reset:r0)
        AxiStream.new(name:"ctrl_inf",clock:c0,reset:r0)
        
        
        AxiLite.axis_wrapper_oled(oled_sdin:oled_sdin,oled_sclk:oled_sclk,oled_dc:oled_dc,oled_res:oled_res,oled_vbat:oled_vbat,oled_vdd:oled_vdd,trigger_toggle:trigger_toggle,lite_ctrl_inf:lite_ctrl_inf,ctrl_inf:ctrl_inf)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def self.inst_axis_wrapper_oled(oled_sdin:"oled_sdin",oled_sclk:"oled_sclk",oled_dc:"oled_dc",oled_res:"oled_res",oled_vbat:"oled_vbat",oled_vdd:"oled_vdd",trigger_toggle:"trigger_toggle",lite_ctrl_inf:"lite_ctrl_inf",ctrl_inf:"ctrl_inf")
        hash = TdlHash.new
        
        unless oled_sdin.is_a? Hash
            # hash.new_index(:oled_sdin) = oled_sdin
            if oled_sdin.is_a? InfElm
                hash.[]=(:oled_sdin,oled_sdin,true)
            else
                hash.[]=(:oled_sdin,oled_sdin,false)
            end
        else
            # hash.new_index(:oled_sdin)= lambda { a = Logic.new(oled_sdin);a.name = "oled_sdin";return a }
            # hash[:oled_sdin] = lambda { a = Logic.new(oled_sdin);a.name = "oled_sdin";return a }
            hash.[]=(:oled_sdin,lambda { a = Logic.new(oled_sdin);a.name = "oled_sdin";return a },false)
        end
                

        unless oled_sclk.is_a? Hash
            # hash.new_index(:oled_sclk) = oled_sclk
            if oled_sclk.is_a? InfElm
                hash.[]=(:oled_sclk,oled_sclk,true)
            else
                hash.[]=(:oled_sclk,oled_sclk,false)
            end
        else
            # hash.new_index(:oled_sclk)= lambda { a = Logic.new(oled_sclk);a.name = "oled_sclk";return a }
            # hash[:oled_sclk] = lambda { a = Logic.new(oled_sclk);a.name = "oled_sclk";return a }
            hash.[]=(:oled_sclk,lambda { a = Logic.new(oled_sclk);a.name = "oled_sclk";return a },false)
        end
                

        unless oled_dc.is_a? Hash
            # hash.new_index(:oled_dc) = oled_dc
            if oled_dc.is_a? InfElm
                hash.[]=(:oled_dc,oled_dc,true)
            else
                hash.[]=(:oled_dc,oled_dc,false)
            end
        else
            # hash.new_index(:oled_dc)= lambda { a = Logic.new(oled_dc);a.name = "oled_dc";return a }
            # hash[:oled_dc] = lambda { a = Logic.new(oled_dc);a.name = "oled_dc";return a }
            hash.[]=(:oled_dc,lambda { a = Logic.new(oled_dc);a.name = "oled_dc";return a },false)
        end
                

        unless oled_res.is_a? Hash
            # hash.new_index(:oled_res) = oled_res
            if oled_res.is_a? InfElm
                hash.[]=(:oled_res,oled_res,true)
            else
                hash.[]=(:oled_res,oled_res,false)
            end
        else
            # hash.new_index(:oled_res)= lambda { a = Logic.new(oled_res);a.name = "oled_res";return a }
            # hash[:oled_res] = lambda { a = Logic.new(oled_res);a.name = "oled_res";return a }
            hash.[]=(:oled_res,lambda { a = Logic.new(oled_res);a.name = "oled_res";return a },false)
        end
                

        unless oled_vbat.is_a? Hash
            # hash.new_index(:oled_vbat) = oled_vbat
            if oled_vbat.is_a? InfElm
                hash.[]=(:oled_vbat,oled_vbat,true)
            else
                hash.[]=(:oled_vbat,oled_vbat,false)
            end
        else
            # hash.new_index(:oled_vbat)= lambda { a = Logic.new(oled_vbat);a.name = "oled_vbat";return a }
            # hash[:oled_vbat] = lambda { a = Logic.new(oled_vbat);a.name = "oled_vbat";return a }
            hash.[]=(:oled_vbat,lambda { a = Logic.new(oled_vbat);a.name = "oled_vbat";return a },false)
        end
                

        unless oled_vdd.is_a? Hash
            # hash.new_index(:oled_vdd) = oled_vdd
            if oled_vdd.is_a? InfElm
                hash.[]=(:oled_vdd,oled_vdd,true)
            else
                hash.[]=(:oled_vdd,oled_vdd,false)
            end
        else
            # hash.new_index(:oled_vdd)= lambda { a = Logic.new(oled_vdd);a.name = "oled_vdd";return a }
            # hash[:oled_vdd] = lambda { a = Logic.new(oled_vdd);a.name = "oled_vdd";return a }
            hash.[]=(:oled_vdd,lambda { a = Logic.new(oled_vdd);a.name = "oled_vdd";return a },false)
        end
                

        unless trigger_toggle.is_a? Hash
            # hash.new_index(:trigger_toggle) = trigger_toggle
            if trigger_toggle.is_a? InfElm
                hash.[]=(:trigger_toggle,trigger_toggle,true)
            else
                hash.[]=(:trigger_toggle,trigger_toggle,false)
            end
        else
            # hash.new_index(:trigger_toggle)= lambda { a = Logic.new(trigger_toggle);a.name = "trigger_toggle";return a }
            # hash[:trigger_toggle] = lambda { a = Logic.new(trigger_toggle);a.name = "trigger_toggle";return a }
            hash.[]=(:trigger_toggle,lambda { a = Logic.new(trigger_toggle);a.name = "trigger_toggle";return a },false)
        end
                

        unless lite_ctrl_inf.is_a? Hash
            # hash.new_index(:lite_ctrl_inf) = lite_ctrl_inf
            if lite_ctrl_inf.is_a? InfElm
                hash.[]=(:lite_ctrl_inf,lite_ctrl_inf,true)
            else
                hash.[]=(:lite_ctrl_inf,lite_ctrl_inf,false)
            end
        else
            # hash.new_index(:lite_ctrl_inf)= lambda { a = AxiLite.new(lite_ctrl_inf);a.name = "lite_ctrl_inf";return a }
            # hash[:lite_ctrl_inf] = lambda { a = AxiLite.new(lite_ctrl_inf);a.name = "lite_ctrl_inf";return a }
            hash.[]=(:lite_ctrl_inf,lambda { a = AxiLite.new(lite_ctrl_inf);a.name = "lite_ctrl_inf";return a },false)
        end
                

        unless ctrl_inf.is_a? Hash
            # hash.new_index(:ctrl_inf) = ctrl_inf
            if ctrl_inf.is_a? InfElm
                hash.[]=(:ctrl_inf,ctrl_inf,true)
            else
                hash.[]=(:ctrl_inf,ctrl_inf,false)
            end
        else
            # hash.new_index(:ctrl_inf)= lambda { a = AxiStream.new(ctrl_inf);a.name = "ctrl_inf";return a }
            # hash[:ctrl_inf] = lambda { a = AxiStream.new(ctrl_inf);a.name = "ctrl_inf";return a }
            hash.[]=(:ctrl_inf,lambda { a = AxiStream.new(ctrl_inf);a.name = "ctrl_inf";return a },false)
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
            hash.check_use("axis_wrapper_oled")
            AxiLite.axis_wrapper_oled(hash)
        }
        return hash
    end
end
