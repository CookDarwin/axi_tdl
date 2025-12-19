
#2018-05-04 14:40:10 +0800
#require_relative ".././tdl"
#require_relative '..\..\tdl\tdl'

class AxiStream


    def axis_mirror_to_master(
        depth:4,
        mirror:"mirror",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        Tdl.add_to_all_file_paths('axis_mirror_to_master','../../axi/AXI_stream/axis_mirror_to_master.sv')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['axis_mirror_to_master','../../axi/AXI_stream/axis_mirror_to_master.sv'])
        return_stream = self
        
        mirror = AxiStream.same_name_socket(:mirror,mix=true,mirror,nil,belong_to_module) unless mirror.is_a? String
        master = AxiStream.same_name_socket(:to_down,mix=true,master,nil,belong_to_module) unless master.is_a? String
        
        if up_stream.nil? && mirror.eql?("mirror") && (!(master.eql?("master")) || !down_stream.nil?)
            # up_stream = self.copy(name:"mirror")
            # return_stream = up_stream
            master = down_stream if down_stream
            return down_stream.axis_mirror_to_master(mirror:self)
        end

        mirror = up_stream if up_stream
        unless self.eql? belong_to_module.AxiStream_NC
            master = self
        else
            if down_stream
                master = down_stream
            end
        end


        belong_to_module.AxiStream_draw << axis_mirror_to_master_draw(
            depth:depth,
            mirror:mirror,
            master:master,
            up_stream:up_stream,
            down_stream:down_stream)
        return return_stream
    end

    private

    def axis_mirror_to_master_draw(
        depth:4,
        mirror:"mirror",
        master:"master",
        up_stream:nil,
        down_stream:nil
    )

        large_name_len(
            depth,
            mirror,
            master
        )
        instance_name = "axis_mirror_to_master_#{signal}_inst"
"
// FilePath:::../../axi/AXI_stream/axis_mirror_to_master.sv
axis_mirror_to_master#(
    .DEPTH    (#{align_signal(depth)})
) #{instance_name}(
/*  axi_stream_inf.mirror*/ .mirror (#{align_signal(mirror,q_mark=false)}),
/*  axi_stream_inf.master*/ .master (#{align_signal(master,q_mark=false)})
);
"
    end
    
    public

    def self.axis_mirror_to_master(
        depth:4,
        mirror:"mirror",
        master:"master",
        up_stream:nil,
        down_stream:nil,
        belong_to_module:nil
        )
        return_stream = nil
        belong_to_module = [mirror,master].first.belong_to_module unless belong_to_module
        
        if down_stream.nil? && master.eql?("master")
            if up_stream.is_a? AxiStream
                down_stream = up_stream.copy
            else
                down_stream = mirror.copy
            end
            return_stream = down_stream
        end

        
        if up_stream.nil? && mirror.eql?("mirror")
            if down_stream.is_a? AxiStream
                up_stream = down_stream.copy
            else
                up_stream = master.copy
            end
            return_stream = up_stream
        end

        
        if down_stream.is_a? AxiStream
            down_stream.axis_mirror_to_master(
                depth:depth,
                mirror:mirror,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        elsif master.is_a? AxiStream
            master.axis_mirror_to_master(
                depth:depth,
                mirror:mirror,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        else
            belong_to_module.AxiStream_NC.axis_mirror_to_master(
                depth:depth,
                mirror:mirror,
                master:master,
                up_stream:up_stream,
                down_stream:down_stream)
        end
        return return_stream
    end
        

end

