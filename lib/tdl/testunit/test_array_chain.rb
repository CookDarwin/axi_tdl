require 'test/unit'
require_relative '../tdl.rb'


class TestArrayChain < Test::Unit::TestCase
    include Test::Unit::Assertions

    def setup 
        Tdl.PutsEnable = false
    end

    def test_0
        sm = SdlModule.new(name: "test_new_sdl",out_sv_path: File.join(__dir__,"tmp"))

        sm.instance_exec(self) do |ts|
            DataInf_C().slaver   :ainf,dimension:[8,6,5]
            puts align_signal(ainf)
            ts.assert_instance_of(TdlSpace::ArrayChain,ainf[0],"Array Chain Class Error")
            ts.assert_equal(ainf[0][4][4,0].to_s,"ainf[0][4][4:0]".to_nq,"Array[0][4][4:0] Error")
            ts.assert_equal(ainf[3].to_s,"ainf[3]".to_nq,"Array[3] Error")
            ts.assert_instance_of(NqString,ainf[3].to_s,"返回ArrayChain类型不对")
            ts.assert_raises(TdlError,"Chain Error slice raise Failse") do 
                ainf[0][4,3][4,0]
            end
        end

        sm.gen_sv_module
    end

    def test_1
        sm = SdlModule.new(name: "test_new_sdl_2",out_sv_path: File.join(__dir__,"tmp"))

        sm.instance_exec(self) do |ts|
            DataInf_C().slaver   :ainf,dimension:[8,6,5]
            Def().logic(name:"tmp",dsize:1,dimension:[ 2,3,4])
            # ainf.valid
            # puts tmp[0][1][1]
            ts.assert_equal(tmp[0][1][2],'tmp[0][1][2]'.to_nq,"Array Chain of Logic 选择出错")
            ts.assert_equal(ainf.valid[0][2][1],'ainf.valid[0][2][1]'.to_nq,"ArrayChain of interface 选择出错")
        
            ts.assert_equal(ainf[0][1][2].valid,"ainf[0][1][2].valid".to_nq,"ArrayChain of interface method 选择出错")
            ts.assert_equal(ainf.valid[0][1][2],"ainf.valid[0][1][2]".to_nq,"ArrayChain of interface method 选择出错")


            # Assign do 
            #     tmp[1][1][1] <= ainf.valid[0][2][1]
            #     # "op".to_nq.<=() 
            # end
            ts.assert_raises(TdlError,"错误选择"){  tmp[2,0][2] }
            ts.assert_raises(TdlError,"错误选择"){  ainf[2,0][2] }
            ts.assert_raises(TdlError,"错误选择"){  tmp[2,0][2] }
            ts.assert_raises(NoMethodError,"错误选择"){  tmp[2][2].valid }
            ts.assert_raises(TdlError,"错误选择"){  ainf[0][1,0].valid }
            ts.assert_raises(TdlError,"错误选择"){  ainf.valid[2,0][2] }
            # ts.assert_raises(TdlError,"错误选择"){  ainf.valid[0][1,0] }

            ts.assert_nothing_raised("正确的选择") do 
                Assign do 
                    tmp[1][1][1] <= ainf.valid[1][2][3]
                    ainf[0][0][1].valid <= tmp[2][2][0]
                end
            end
        end

        sm.gen_sv_module
    end

    def test_2 
        sm = SdlModule.new(name: "test_new_sdl_3",out_sv_path: File.join(__dir__,"tmp"))
        sm.instance_exec(self) do |ts|
            DataInf_C().slaver   :ainf,dimension:[8,6,5]
            Def().logic(name:"tmp",dsize:1,dimension:[ 2,3,4])

            ts.assert_nothing_raised("Correct Select") do 
                Assign do 
                    tmp[1][1][1] <= ainf.valid[1][2][3]
                    ainf[0][0][1].valid <= tmp[2][2][0]
                    ainf[0][0][1].data  <= 90
                    ainf.data[0][1][2]  <= tmp[1][2][1,0]
                    ainf[0][0][3].ready <= 1
                    ainf.ready[2][2][1] <= 1
                end
            end
        end
        sm.gen_sv_module

    end

end