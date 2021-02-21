module ClassHDL

    class SdlPackage < SdlModule 
        
        def macro_def
            ''
        end

        def build_params(ex_str="")
            "Draw Parameters of sv module"
            str = []
            max_len = 0
            @port_params.each do |k,v|
                if v.port_length > max_len
                    max_len = v.port_length;
                end
            end
    
            @port_params.each do |k,v|
                str << v.inst_port(max_len-v.port_length)+";"
            end
    
            unless ex_str.empty?
                head_tap = '//------>> EX PARAMETER <<-------------------'+"\n"
                end_tap = "\n//------<< EX PARAMETER >>-------------------"+"\n"
            else
                head_tap = ""
                end_tap = ""
            end
    
            if str.empty?
                if ex_str.empty?
                    return ""
                else
                    # ex_str.gsub!(/,\s*$/m,"")
                    return head_tap + ex_str + end_tap 
                end
            else
                # if (ex_str !~  /,\s*$/m)
                #     ex_str = ex_str + ",\n" unless ex_str.empty?
                # end
                head_tap + ex_str + end_tap + str.join("\n")
            end
    
        end

        def build_module(ex_param: "",ex_port: "",ex_up_code: "",ex_down_code: "")
            # Tdl.Puts pagination(module_name)
            Tdl.Build_SdlModule_Puts(module_name)
    
            ex_param        = ex_param.to_s     unless ex_param
            ex_port         = ex_port.to_s      unless ex_port
            ex_up_code      = ex_up_code.to_s   unless ex_up_code
            ex_down_code    = ex_down_code.to_s unless ex_down_code
    
            # gen_auto_method     # auto generate class method for interface
            # draw = Tdl.inst + Tdl.draw
    
            instance_draw_str = instance_draw       # It must run before vars_define_inst,because some signals define when inst
            vars_exec_inst_str = vars_exec_inst     # It must run before vars_define_inst,because some signals define when vars exec
    
            post_str = post_inst_stack_call()
    
            unless post_str.strip.empty?
                post_str = pagination("ROOT REF") + post_str
            end
    
            draw = pagination("define") + vars_define_inst + pagination("instance") + instance_draw_str + pagination("expression") + vars_exec_inst_str + post_str
    
            unless ex_up_code.empty?
                ex_up_code = "\n//------>> EX CODE <<-------------------\n" + ex_up_code + "//------<< EX CODE >>-------------------\n"
            end
    
            unless ex_down_code.empty?
                ex_down_code = "//------>> EX CODE <<-------------------\n" + ex_down_code + "//------<< EX CODE >>-------------------\n"
            end
    
            # str = module_head+"module #{@module_name}" + build_params(ex_param) + build_ports(ex_port) + ex_up_code + gen_lite_str() + draw + ex_down_code + "\nendmodule\n"
            # unless GlobalParam.sim
                module_name_str = @module_name
            # else
            #     module_name_str = @module_name+"_sim"
            # end
    
            str = module_head+"package #{module_name_str};\n"  + build_params(ex_param) + ex_up_code + draw + ex_down_code + "\nendpackage:#{module_name_str}\n" + add_sub_module_file_paths
    
            create_vivado_tcl if @create_tcl
            create_constraints_file if @create_sdc
    
            return str
        end

    end

    # class ReqPakcgeLine
    #     def initialize(sdlm)
    #         @sdlm 
    #     end

    #     def method_missing(method,*arg,&block)
    #         _var = @sdlm.instance_variable_get("@_import_packages_")
    #         @sdlm.instance_variable_set("@_import_packages_",[]) unless _var

    #     end
    # end

end

class TdlPackage
    # return ClassHDL::AnonyModule.new
    def self.method_missing(method,*args,&block)

        sdlm = ClassHDL::SdlPackage.new(name: method,out_sv_path: args[0])

        sdlm.instance_exec(&block)

        sdlm.gen_sv_module
    end
end

class SdlModule

    def require_package(tdl_package_str,ex_code=true)
        # puts tdl_package
        if SdlModule.exist_module?(tdl_package_str) && SdlModule.call_module(tdl_package_str).instance_of?(ClassHDL::SdlPackage)
            tdl_package = SdlModule.call_module(tdl_package_str)
            @_import_packages_ ||= []
            @_import_packages_ << tdl_package
            if ex_code
                self.ex_up_code ||= '' 
                self.ex_up_code += "import #{tdl_package.module_name}::*;\n"
            end
        else 
            raise TdlError.new("Dont have packge #{tdl_package_str}")
        end 

        define_singleton_method(tdl_package_str) do 
            SdlModule.call_module(tdl_package_str)
        end

        ## 替换掉 package 里面 DefStruct 指向的 sdlmodule 

        metac = tdl_package.instance_variable_get("@_struct_meta_collect_") || []

        metac.each do |e|
            e.sdlm = self
        end
    end

end