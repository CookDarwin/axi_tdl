

module ClassHDL
    ## 一个文件只对应一个interface
    class Verify 
        attr_accessor :belong_to_module
        @@def_mem_index = 0
        def initialize(sdlm)
            @belong_to_module = sdlm 
        end

        def display(*infos)
            pstr = []
            vstr = []
            infos.each do |p_v|
                if p_v.is_a? Array 
                    pstr << p_v[0]
                    if p_v[1]
                        vstr << p_v[1]
                    end
                else
                    pstr << p_v.to_s
                end
            end
            if TopModule.sim 
                if vstr.empty?
                    ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$display(\"%t:  #{pstr.join(' ')} \",$realtime)".to_nq]))
                else 
                    ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$display(\"%t:  #{pstr.join(' ')} \",$realtime,#{vstr.join(',')})".to_nq]))
                end
            end
        end

        def track_data_c(intf,txt_file_path)
            if txt_file_path.is_a? Array
                fsize = txt_file_path[2] || 1000
            else
                rls = File.open(txt_file_path,'r').readlines
                fsize = rls.size
            end
            return unless fsize > 1
            return unless TopModule.sim 

            @belong_to_module.instance_exec(fsize,txt_file_path,intf) do |fsize,txt_file_path,intf| 
                ## 定义 MEM
         
                ## 判断 intf是否是真正的 interface 
                if intf.is_a? TdlSpace::TdlBaseInterface
                    logic[fsize][intf.DSIZE] - "track_#{intf.inst_name}_mem"
                    track_ci = logic.integer - "track_#{intf.inst_name}_ci"
                    mem_args = "track_#{intf.inst_name}_mem"
                    mem_format = "%d"
                    block_name = intf.inst_name
                elsif intf.is_a? TdlSpace::ArrayChain
                    logic[fsize][intf.DSIZE] - "track_#{@@def_mem_index}_mem"
                    track_ci = logic.integer - "track_#{@@def_mem_index}_ci"
                    mem_args = "track_#{@@def_mem_index}_mem"
                    mem_format = "%d"
                    block_name = @@def_mem_index.to_s
                    @@def_mem_index += 1
                else
                    raise TdlError.new("Track INTERAFCE ARG Error!!!")
                end

                if txt_file_path.is_a? Array 
                    str = ClassHDL::Verify.track_model_x(txt_file_path,mem_format,"#{mem_args}[mem_index]")
                else
                    str = ClassHDL::Verify.track_model(txt_file_path,mem_format,"#{mem_args}[mem_index]")
                end
                ## 初始化 MEM
                Initial("TRACK_INTF_#{block_name}") do 
                    initial_exec(str)
                end

                always_ff(posedge: intf.clock,negedge: intf.rst_n) do
                    IF ~intf.rst_n do  
                        track_ci <= 0.A
                    end 
                    ELSIF intf.vld_rdy do  
                        assert(intf.data == "#{mem_args}[#{track_ci}]".to_nq,"TRACK <#{intf.to_s}> Error;","Real<%d>"," != Expect<%d>",intf.data,"#{mem_args}[#{track_ci}]".to_nq)
                        track_ci <= track_ci + 1.b1
                    end
                end

            end
            
        end

        def self.track_model(filepath,fformat,args)
        "
    integer mem_index = 0;
    integer fd;
    integer code =1;
    fd = $fopen(\"#{filepath}\",\"r\");
    if(fd==0) $finish();
    while(!$feof(fd))begin 
        code = $fscanf( fd, \"#{fformat}\", #{args} );
        mem_index = mem_index + 1;
        if(mem_index>10000)begin 
            break;
        end
    end
    $fclose(fd);
    $display(\"Read Track File #{filepath} Done!\")"
        end
     

        def self.track_model_x(filepath_arg,fformat,args)
        "
    integer mem_index = 0;
    integer fd;
    integer code =1;
    fd = $fopen($sformatf(\"#{filepath_arg[0]}\",#{filepath_arg[1]}),\"r\");
    if(fd==0) $finish();
    while(!$feof(fd))begin 
        code = $fscanf( fd, \"#{fformat}\", #{args} );
        mem_index = mem_index + 1;
        if(mem_index>10000)begin 
            break;
        end
    end
    $fclose(fd);
    $display(\"Read Track File %s Done!\",$sformatf(\"#{filepath_arg[0]}\",#{filepath_arg[1]}))"
        end


    end 
end


class SdlModule

    def verify
        vinst = ClassHDL::Verify.new(self)
    end
end