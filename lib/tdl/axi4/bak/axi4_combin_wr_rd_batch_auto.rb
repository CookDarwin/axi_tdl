
#2017-12-27 10:16:00 +0800
#require_relative ".././tdl"
require_relative '..\..\tdl\tdl'

class Axi4


    def _axi4_combin_wr_rd_batch(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master"
    )

        Tdl.add_to_all_file_paths(['axi4_combin_wr_rd_batch','../../axi/AXI4/axi4_combin_wr_rd_batch.sv'])
        return_stream = self
        
        wr_slaver = Axi4.same_name_socket(:mirror,mix=true,wr_slaver) unless wr_slaver.is_a? String
        rd_slaver = Axi4.same_name_socket(:mirror,mix=true,rd_slaver) unless rd_slaver.is_a? String
        master = Axi4.same_name_socket(:to_down,mix=true,master) unless master.is_a? String
        
        
        

         @instance_draw_stack << lambda { _axi4_combin_wr_rd_batch_draw(
            wr_slaver:wr_slaver,
            rd_slaver:rd_slaver,
            master:master) }
        return return_stream
    end

    def _axi4_combin_wr_rd_batch_draw(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master"
    )

        large_name_len(
            wr_slaver,
            rd_slaver,
            master
        )
"
// FilePath:::../../axi/AXI4/axi4_combin_wr_rd_batch.sv
axi4_combin_wr_rd_batch axi4_combin_wr_rd_batch_#{signal}_inst(
/*  axi_inf.slaver_wr*/ .wr_slaver (#{align_signal(wr_slaver,q_mark=false)}),
/*  axi_inf.slaver_rd*/ .rd_slaver (#{align_signal(rd_slaver,q_mark=false)}),
/*  axi_inf.master   */ .master    (#{align_signal(master,q_mark=false)})
);
"
    end
    
    def self.axi4_combin_wr_rd_batch(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master"
    )
        return_stream = nil
        
        
        Axi4.NC._axi4_combin_wr_rd_batch(
            wr_slaver:wr_slaver,
                rd_slaver:rd_slaver,
                master:master)
        return return_stream
    end
        

end


class TdlTest

    def self.test_axi4_combin_wr_rd_batch
        c0 = Clock.new(name:"axi4_combin_wr_rd_batch_clk",freqM:148.5)
        r0 = Reset.new(name:"axi4_combin_wr_rd_batch_rst_n",active:"low")

        wr_slaver = Axi4.new(name:"wr_slaver",clock:c0,reset:r0)
        rd_slaver = Axi4.new(name:"rd_slaver",clock:c0,reset:r0)
        master = Axi4.new(name:"master",clock:c0,reset:r0)
        
        
        Axi4.axi4_combin_wr_rd_batch(
            wr_slaver:wr_slaver,
            rd_slaver:rd_slaver,
            master:master)

        puts_sv Tdl.inst,Tdl.draw
    end

end

class Tdl

    def Tdl.inst_axi4_combin_wr_rd_batch(
        wr_slaver:"wr_slaver",
        rd_slaver:"rd_slaver",
        master:"master")
        hash = TdlHash.new
        
        unless wr_slaver.is_a? Hash
            hash.case_record(:wr_slaver,wr_slaver)
        else
            # hash.new_index(:wr_slaver)= lambda { a = Axi4.new(wr_slaver);a.name = "wr_slaver";return a }
            # hash[:wr_slaver] = lambda { a = Axi4.new(wr_slaver);a.name = "wr_slaver";return a }
            raise TdlError.new('axi4_combin_wr_rd_batch Axi4 wr_slaver TdlHash cant include Proc') if wr_slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(wr_slaver)
                unless wr_slaver[:name]
                    a.name = "wr_slaver"
                end
                return a }
            hash.[]=(:wr_slaver,lam,false)
        end
                

        unless rd_slaver.is_a? Hash
            hash.case_record(:rd_slaver,rd_slaver)
        else
            # hash.new_index(:rd_slaver)= lambda { a = Axi4.new(rd_slaver);a.name = "rd_slaver";return a }
            # hash[:rd_slaver] = lambda { a = Axi4.new(rd_slaver);a.name = "rd_slaver";return a }
            raise TdlError.new('axi4_combin_wr_rd_batch Axi4 rd_slaver TdlHash cant include Proc') if rd_slaver.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(rd_slaver)
                unless rd_slaver[:name]
                    a.name = "rd_slaver"
                end
                return a }
            hash.[]=(:rd_slaver,lam,false)
        end
                

        unless master.is_a? Hash
            hash.case_record(:master,master)
        else
            # hash.new_index(:master)= lambda { a = Axi4.new(master);a.name = "master";return a }
            # hash[:master] = lambda { a = Axi4.new(master);a.name = "master";return a }
            raise TdlError.new('axi4_combin_wr_rd_batch Axi4 master TdlHash cant include Proc') if master.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = Axi4.new(master)
                unless master[:name]
                    a.name = "master"
                end
                return a }
            hash.[]=(:master,lam,false)
        end
                

        hash.push_to_module_stack(Axi4,:axi4_combin_wr_rd_batch)
        hash.open_error = true
        return hash
    end
end
