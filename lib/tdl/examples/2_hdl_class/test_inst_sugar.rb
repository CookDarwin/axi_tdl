require_relative '../../tdl.rb'

TdlBuild.test_inst_sugar(File.join(__dir__,"tmp")) do 

    axi_stream_cache.axi_stream_cache_inst do |h|
        h.axis_in       'x' 
        h.axis_out      'xx'
    end

    axi_stream_cache.axi_stream_cache_inst1 do |h|
        h.port.slaver.axis_in       'x' 
        h.port.master.axis_out      'xx'
    end

    axi_stream_cache.axi_stream_cache_inst2 do |h|
        h.port.slaver("9090").axis_in       'x' 
        h.port.master[1].axis_out      'xx'
    end

    axis_append_A1.axis_append_A1_inst do |h|
        h.input.enable          1.b1
        h.input[5][9].head_value   0
        h.input[5].end_value    0
        h.port('axi_stream_inf').slaver.origin_in   "x"
        h.port('axi_stream_inf').master.append_out  "xx"
    end

end