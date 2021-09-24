
module AxiTdl

    module LogicVerify 

        class Iteration

            def initialize(length: 1024, data: [0], dsize: 8)
                @data = data.to_a * (length / data.size + 1)
                @length = length
                @dsize = dsize
            end

            def to_a 
                collect = []
                index = 0
                while true 
                    
                    collect << [ index, @data[index] ]
                    
                    if @length <= index + 1
                        break 
                    end
                    index += 1
                end

                collect 
            end

            def context
                collect = []
                to_a.each do |index, data|
                    u0 = data % (2**@dsize)
                    collect << u0
                end

                collect.map do |e| 
                    "%0#{(@dsize )/4  + ( ((@dsize)%4 == 0) ? 0 : 1 )}x"%e
                end
                # collect
            end

            def coe 
                collect = []
                xxx = context
                xxx.each_index do |index|
                    collect << "@%04x #{xxx[index]}\n"%index
                end
                collect.join("")
            end

        end
    end
end

class Logic 

    def to_sim_source_coe(data: (0...100).to_a, posedge: nil ,negedge: nil ,loop_coe: true)
        raise TdlError.new(" posedge negedge both nil") unless (posedge || negedge )
        # raise TdlError.new "file cant be empty"  unless file

        file = File.join(AxiTdl::TDL_PATH,"./auto_script/tmp/","#{self.name}_#{@belong_to_module._auto_name_incr_index_}.coe")
        _len = 1000
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            require_hdl 'logic_sim_model.sv'
            itr = AxiTdl::LogicVerify::Iteration.new(length: data.size, data: data )
            File.open(file,'w') do |f|
                f.puts itr.coe
            end
            _len = itr.context.size
        end

        @belong_to_module.instance_exec(self,_len, posedge || 1.b0 , negedge || 1.b0 ,file, loop_coe) do |_self,_len,next_at_posedge_of,next_at_negedge_of,file,loop_coe|
            Instance(:logic_sim_model, "#{_self.name}_sim_model_inst") do |h|
                h.param.LOOP                (loop_coe ? "TRUE" : "FALSE")
                h.param.DSIZE           _self.dsize
                h.param.RAM_DEPTH       _len
                h.input.next_at_negedge_of  next_at_negedge_of
                h.input.next_at_posedge_of  next_at_posedge_of
                h.input.load_trigger        1.b0
                h.input[32].total_length    _len
                h.input[512*8].mem_file     File.expand_path(file)
                h.output['DSIZE'].data      _self
            end

        end
    end
end