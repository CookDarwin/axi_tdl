## read sdlmodule head
class Tdl 
    @@__head_logo__ = nil 
    def self.head_logo 
        @@__head_logo__
    end

    def self.head_logo=(a) 
        $__sdlmodule_head_logo__ = a
        @@__head_logo__ = a
    end
end

$__sdlmodule_head_logo__ = File.open(File.join(__dir__,"sdlmodule_head_logo.txt")).read

class SdlModule
    attr_accessor :origin_sv

    def self.gen_sv_module
        @@allmodule.each do |e|
            e.gen_sv_module
        end
    end

    private

    def pre_inst_stack_call
        @@ele_array.each do |e|
            head_str = "#{e.to_s}"
            method("#{head_str}_pre_inst_stack").call.each do |proc|
                proc.call
            end
        end
    end

    def post_inst_stack_call
        str = ''
        @@ele_array.each do |e|
            head_str = "#{e.to_s}"
            method("#{head_str}_post_inst_stack").call.each do |proc|
                str += proc.call
            end
        end
        str
    end

    public

    def gen_sv_module
        # @out_sv_path ||= File.dirname(File.expand_path(__FILE__))
        return if (@origin_sv || @dont_gen_sv)
        pre_inst_stack_call
        @out_sv_path ||= '..\..\tdl\test_sdlmodule'
        if File.exist?(File.join(@out_sv_path,"#{module_name}.sv")) 
            old_str = File.open(File.join(@out_sv_path,"#{module_name}.sv")).read.sub(/\/\*.*?\*\//m,"").gsub(/\/\/.*/,"").sub(/^`timescale .*/,"").strip
        

            head_str,body_str = build_module_verb(ex_param:ex_param,ex_port:ex_port,ex_up_code:ex_up_code,ex_down_code:ex_down_code)
            new_str = head_str+body_str
            if body_str.gsub(/\/\/.*/,"").strip != old_str
                File.open(File.join(@out_sv_path,"#{module_name}.sv"),"w") do |f|
                    f.print new_str
                end
            end 
        else
            File.open(File.join(@out_sv_path,"#{module_name}.sv"),"w") do |f|
                f.print build_module_verb(ex_param:ex_param,ex_port:ex_port,ex_up_code:ex_up_code,ex_down_code:ex_down_code).join("")
            end
        end 
    end

    # def gen_sv_module_text
    #     # @out_sv_path ||= File.dirname(File.expand_path(__FILE__))
    #     return if (@origin_sv || @dont_gen_sv)
    #     pre_inst_stack_call
    #     @out_sv_path ||= '..\..\tdl\test_sdlmodule'
    #     # unless GlobalParam.sim

    #     return build_module(ex_param:ex_param,ex_port:ex_port,ex_up_code:ex_up_code,ex_down_code:ex_down_code)

    # end

    def build_module(ex_param:"",ex_port:"",ex_up_code:"",ex_down_code:"")
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
        unless head_import_packages
            str = module_head+"module #{module_name_str}" + build_params(ex_param) + build_ports(ex_port) + ex_up_code + draw + ex_down_code + "\nendmodule\n" + add_sub_module_file_paths
        else
            head_import_pkgs_str = head_import_packages.map{|e| "import #{e}::*;" }.join('')
            str = module_head+"module #{module_name_str} #{head_import_pkgs_str}" + build_params(ex_param) + build_ports(ex_port) + ex_up_code + draw + ex_down_code + "\nendmodule\n" + add_sub_module_file_paths
        end

        create_vivado_tcl if @create_tcl
        create_constraints_file if @create_sdc

        return str
    end

    def build_module_verb(ex_param:"",ex_port:"",ex_up_code:"",ex_down_code:"") #return [ head, body]
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
        unless head_import_packages
            str = "module #{module_name_str}" + build_params(ex_param) + build_ports(ex_port) + ex_up_code + draw + ex_down_code + "\nendmodule\n" + add_sub_module_file_paths
        else
            head_import_pkgs_str = head_import_packages.map{|e| "import #{e}::*;" }.join('')
            str = "module #{module_name_str} #{head_import_pkgs_str}" + build_params(ex_param) + build_ports(ex_port) + ex_up_code + draw + ex_down_code + "\nendmodule\n" + add_sub_module_file_paths
        end

        create_vivado_tcl if @create_tcl
        create_constraints_file if @create_sdc

        # return str
        return [module_head_verb, str]
    end


    private

    def old_module_head
%Q{/**********************************************
_______________________________________ 
___________    Cook Darwin   __________    
_______________________________________
descript:
author : Cook.Darwin
Version: VERA.0.0
created: #{Time.now()}
madified:
***********************************************/
#{macro_def}
#{head_class}
}
    end

    def module_head
%Q{#{$__sdlmodule_head_logo__}
#{macro_def}
#{head_class}
}
    end

    def module_head_verb
%Q{#{$__sdlmodule_head_logo__.sub(/created:.*/, "created: #{Time.now()}")}
#{macro_def}
#{head_class}
}
            end

    def head_class
        case(@target_class.to_s)
        when "AxiStream"
            '(* axi_stream = "true" *)'
        when "Axi4"
            '(* axi4 = "true" *)'
        when "AxiLite"
            '(* axi_lite = "true" *)'
        when "VideoInf"
            '(* videoinf = "true" *)'
        when "DataInf"
            '(* data_inf = "true" *)'
        when "DataInf_C"
            '(* data_inf_c = "true" *)'
        else
            @target_class.to_s
        end
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
            str << "    " + v.inst_port(max_len-v.port_length)
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
                return "#(\n" + head_tap + ex_str + end_tap + "\n)"
            end
        else
            # if (ex_str !~  /,\s*$/m)
            #     ex_str = ex_str + ",\n" unless ex_str.empty?
            # end
            "#(\n" + head_tap + ex_str + end_tap + str.join(",\n")+"\n)"
        end

    end

    def align_tt(max_len,tt,tap=1)
        tt+" "*(max_len+tap-tt.length)
    end

    def build_ports(ex_str="")
        "Draw Ports of sv module"
        "<T0>   type.[.]... <T1>name <T2> Array"
        str = []
        # ports = (@port_clocks + @port_resets + @port_logics + @port_datainfs + @port_datainf_c_s + @port_videoinfs + @port_axisinfs + @port_axi4infs + @port_axilinfs)

        t0 = []
        t1 = []
        t2 = []
        @ports ||= Hash.new
        @ports.each do |k,v|
            tmp = v.inst_port
            t0 << tmp[0]
            t1 << tmp[1]
            t2 << tmp[2]
        end

        max_len_t0 = t0.map { |e| e.length }.max
        max_len_t1 = t1.map { |e| e.length }.max
        max_len_t2 = t2.map { |e| e.length }.max

        t0.each_index do |index|
            str << "    "+align_tt(max_len_t0,t0[index])+align_tt(max_len_t1,t1[index])+align_tt(max_len_t2,t2[index])
        end

        str = str.map { |e| e.rstrip }.join(",\n")

        unless ex_str.empty?
            head_tap = '//------>> EX PORT <<-------------------'+"\n"
            end_tap = "\n//------<< EX PORT >>-------------------"+"\n"
        else
            head_tap = ""
            end_tap = ""
        end

        if str.empty?
            if ex_str.empty?
                return "();"
            else
                # ex_str.gsub!(/,\s*$/m,"")
                return "(\n" + head_tap + ex_str + end_tap + "\n);\n"
            end
        else
            ex_str = ex_str.rstrip
            if ex_str[ex_str.length] != "," && !ex_str.empty?
                ex_str = ex_str + ",\n"
            end
            "(\n" + head_tap + ex_str + end_tap + str+"\n);\n"
        end

    end

    def add_sub_module_file_paths
        ""
    end

end


class SdlModule

    def macro_def
        @_head_macro_ ||=[]
        @_head_macro_ << "`timescale 1ns/1ps"
        @_head_macro_.reverse.join("\n")
    end

    def macro_add_vcs
        @_head_macro_ ||=[]

        @_head_macro_ << "`include \"define_macro.sv\" "
    end
end
