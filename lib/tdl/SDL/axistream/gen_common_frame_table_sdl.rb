TdlBuild.gen_common_frame_table do 

    parameter.MASTER_MODE   "OFF"
    parameter.FIELD_TOTLE   11      #// MAX 16 :: default IP Frame
    parameter.DSIZE         8

    parameter.F0_LEN    1        #//MAX 8
    parameter.F0_NAME   "version+head length"

    parameter.F1_LEN   1
    parameter.F1_NAME  "TOS"
    parameter.F2_LEN   2
    parameter.F2_NAME  "totle length"
    parameter.F3_LEN   2
    parameter.F3_NAME  "identify"
    parameter.F4_LEN   1
    parameter.F4_NAME  "flag + offset MSB"
    parameter.F5_LEN   1
    parameter.F5_NAME  "offset LSB"
    parameter.F6_LEN   1
    parameter.F6_NAME  "TTL"
    parameter.F7_LEN   1
    parameter.F7_NAME  "sub protocol"
    parameter.F8_LEN   2
    parameter.F8_NAME  "head CRC"
    parameter.F9_LEN   4
    parameter.F9_NAME  "source ip addr"
    parameter.F10_LEN   4
    parameter.F10_NAME  "destination ip addr"
    parameter.F11_LEN   1
    parameter.F11_NAME  "Filed 11"
    parameter.F12_LEN   1
    parameter.F12_NAME  "Filed 12"
    parameter.F13_LEN   1
    parameter.F13_NAME  "Field 13"
    parameter.F14_LEN   1
    parameter.F14_NAME  "Field 14"
    parameter.F15_LEN   1
    parameter.F15_NAME  "Field 15"
    input                             -  'enable'
    input['F0_LEN *DSIZE'.to_nq]    -  'f0_value'
    input['F1_LEN *DSIZE'.to_nq]    -  'f1_value'
    input['F2_LEN *DSIZE'.to_nq]    -  'f2_value'
    input['F3_LEN *DSIZE'.to_nq]    -  'f3_value'
    input['F4_LEN *DSIZE'.to_nq]    -  'f4_value'
    input['F5_LEN *DSIZE'.to_nq]    -  'f5_value'
    input['F6_LEN *DSIZE'.to_nq]    -  'f6_value'
    input['F7_LEN *DSIZE'.to_nq]    -  'f7_value'
    input['F8_LEN *DSIZE'.to_nq]    -  'f8_value'
    input['F9_LEN *DSIZE'.to_nq]    -  'f9_value'
    input['F10_LEN*DSIZE'.to_nq]    -  'f10_value'
    input['F11_LEN*DSIZE'.to_nq]    -  'f11_value'
    input['F12_LEN*DSIZE'.to_nq]    -  'f12_value'
    input['F13_LEN*DSIZE'.to_nq]    -  'f13_value'
    input['F14_LEN*DSIZE'.to_nq]    -  'f14_value'
    input['F15_LEN*DSIZE'.to_nq]    -  'f15_value'
    port.axi_stream_inf.master        -  'cm_tb'


end