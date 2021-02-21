

add_to_tdl_paths __dir__

require_sdl 'a_test_module.rb'

class ABlock < ItegrationVerb

    link_itgt :clock_mg 
    clock_mg_has_attr :clock_100M, :rstn_100M

    link_explort :x_origin_inf

    top_module_eval do |itgt|
        a_test_md.a_test_md_inst do |h|
            h.input.clock       itgt.clock_mg.clock_100M
            h.input.rst         ~itgt.clock_mg.rstn_100M
            h.origin_inf        axi_stream_inf(clock: itgt.clock_mg.clock_100M, reset: itgt.clock_mg.rstn_100M, dsize: 16).x_origin_inf
        end

    end 

    active_x_origin_inf('x_origin_inf')

    silence_x_origin_inf do |itgt|
        Assign do 
            itgt.x_origin_inf.axis_tvalid   <= 1.b0
            itgt.x_origin_inf.axis_tdata    <= 0.A 
            itgt.x_origin_inf.axis_tlast    <= 1.b0
        end
    end


end