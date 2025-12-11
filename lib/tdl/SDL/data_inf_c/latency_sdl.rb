TdlBuild.latency do 
    parameter.LAT      2
    parameter.DSIZE    1
    input                    - 'clk'
    input                    - 'rst_n'
    input[param.DSIZE]       - 'd'
    output[param.DSIZE]      - 'q'
end