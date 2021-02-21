require_relative '../../tdl.rb'
# require_relative "./../../class_hdl/hdl_module_def.rb"

TdlBuild.test_module(File.join(__dir__,"tmp")) do 
    input.clock     - 'clock'
    input.clock     - 'clock1'
    input.reset('low')  - 'rst_n'
    input.reset('low')  - 'rst_n1'
    
    port.axi4.master_wr(addr_step: 1024*8)  - 'axi_wr_inf'

    logic[axi_wr_inf.ASIZE]     - 'addr'
    logic[axi_wr_inf.IDSIZE-4]  - 'id'
    

    axi4(
        idsize:axi_wr_inf.IDSIZE-4,
        asize:axi_wr_inf.ASIZE,
        lsize:24,
        dsize:axi_wr_inf.DSIZE,
        mode:Axi4::ONLY_WRITE,
        clock: axi_wr_inf.axi_aclk,
        reset: axi_wr_inf.axi_aresetn,
        addr_step:  1024*8) - 'pre_axi_wr_inf'

    # Def().logic(name:"length",dsize:24)
    logic[24]   - 'length'

    axi_stream_cache_35bit.cache_inst do |h|
        h.axis_in       (  "opop".to_nq )
        h.axis_out      (" 909090")
    end
end 
