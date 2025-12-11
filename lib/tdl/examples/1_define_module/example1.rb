require_relative '../../tdl.rb'

TdlBuild.exmple_md(__dir__) do 
    ## parameter
    parameter.DSIZE     8
    parameter.real.MK   1.1
    ## HDL PORT
    input                           - 'insdata'
    output                          - 'outsdata'
    input[8]                        - 'inpdata'
    output[16]                      - 'outpdata'
    output.logic[param.DSIZE]       - 'ldata'

    ## define Clock and Reset
    input.clock(110)    - 'clock'   ## clock signal 100Mhz
    input.reset('low')  - 'rst_n'   ## reset active low

    ## define signals
    logic[9,7,6]        - 'tmp_data'

    ## assign 
    Assign do 
        outsdata    <= insdata
    end

    ## Always Comb 
    always_comb do 
        outpdata[8,0]   <= inpdata
    end

    always_ff(posedge: clock, negedge: rst_n) do 
        IF ~rst_n do 
            ldata   <= 0.A 
        end
        ELSE do 
            ldata[param.DSIZE-1,0]   <= outpdata[7,0] + insdata
        end 
    end
end