# require_relative "./../global_scan"

class AutoGenSdl
    attr_accessor :bad
    def initialize(filename="",out_file_path=@@auto_path,info=true)
        @expand_path = File.expand_path(filename)
        sf = File.open(filename,"r")
        fstr = sf.read.force_encoding("utf-8")
        sf.close
        @bad = true

        # return if exist_origin_sdl(filename,@expand_path)
        # fstr.gsub!(/\/\/\s*\(\*\s*show\s*=\s*"false"\s*\*\)/,"(* show = \"false\" *)")
        # SDL ignore `show`
        fstr.gsub!(/\/\/\s*\(\*\s*show\s*=\s*"false"\s*\*\)/,"")
        fstr.gsub!(/\/\*.*?\*\//m,"")
        fstr.gsub!(/\/\/.*/,"")
        #
        # if fstr =~ AxiStream::Synth_REP  # axi_stream class
        #     @targer_class = "AxiStream"
        # elsif fstr =~ Axi4::Synth_REP # axi4 class
        #     @targer_class = "Axi4"
        # elsif fstr =~ VideoInf::Synth_REP  # videoinf class
        #     @targer_class = "VideoInf"
        # elsif fstr =~ DataInf::Synth_REP # datainf class
        #     @targer_class = "DataInf"
        # elsif fstr =~ DataInf_C::Synth_REP# datainf_c class
        #     @targer_class = "DataInf_C"
        # elsif fstr =~ AxiLite::Synth_REP# datainf_c class
        #     @targer_class = "AxiLite"
        # elsif fstr =~ Logic::Synth_REP # only logic
        #     @targer_class = "Logic"
        # else
        #     puts ">>>#{filename} <<< File's head must mark (* ??? = \"true\" *)\n" if info
        #     return nil
        # end

        @autof_name = File.join(File.expand_path(out_file_path),File::basename(filename,".*")+"_sdl.rb")
        # @autof = File.open(@autof_name,"w")

        regexp_module = /module\s+(?<name>\w+)\s*(#\((?<parameter>.*?)\))?\s*\((?<port>.*?)\)\s*;/m

        mth =  regexp_module.match(fstr)

        return nil unless mth
        if mth["parameter"].nil? && mth["port"].nil?
            return
        end

        @module_name = mth["name"]
        @origin_module_name = mth["name"]
        @parameter_str = mth["parameter"]
        @port_str = mth["port"]
        if @port_str
            @port_str = @port_str.split(",")
        else
            @port_str = []
        end

        @up_stream = nil
        @down_stream = nil

        @inf_array = []
        @collect_array = []
        @format_args_twins = []
        @actial_args_twins = []
        @alone_args = []
        @ex_params = []
        @ex_ports = []
        @test_obj = []
        @tdl_param_design_hash = []
        @tdl_inst_design_hash = []

        @inf_port_left_len = 0
        @inf_port_right_len = 0
        @para_port_len = 0

        @param_port_inst = []
        @signals_ports_inst = []
        @inf_ports_inst = []

        Parameter.parse_params(@parameter_str) do |h|
            # @format_args_twins  << "#{h[:name]}:#{h[:value]}"
            # @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            # @alone_args << h[:name]
            # @ex_params << h[:inst_ex_port]
            # @para_port_len = h[:port_len] if h[:port_len] > @para_port_len
            # @test_obj << "#{h[:name]} = Parameter.new(name:\"#{h[:name]}\",value:#{h[:value]})"
            # @tdl_param_design_hash << h
            if h
                @param_port_inst << "parameter.#{h[:origin_name]}   #{h[:value]}"
            end
        end

        @port_str = SignalElm.parse_ports(@port_str) do |h|
            # @format_args_twins  << "#{h[:name]}:\"#{h[:name]}\""
            # @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            # @alone_args << h[:name]
            #
            # @ex_ports << h[:inst_ex_port]
            # @inf_port_left_len =  h[:port_left_len]   if h[:port_left_len]  > @inf_port_left_len
            # @inf_port_right_len = h[:port_right_len]  if h[:port_right_len] > @inf_port_right_len
            # @test_obj << "#{h[:name]} = Logic.new(name:\"#{h[:name]}\")"
            # @tdl_inst_design_hash << h

            head = h[:in_out]
            # head[0] = head[0].upcase

            if h[:vector]
                v_str = ",dsize:#{vector_to_size(h[:vector])}"
            else
                v_str = ""
            end

            if h[:array]
                a_str = ",dimension:[#{vector_to_size(h[:array])}]"
            else
                a_str = ""
            end

            # @signals_ports_inst << "sm.#{head}(\"#{h[:origin_name]}\"#{v_str}#{a_str})"
            if h[:vector]
                if h[:array]
                    @signals_ports_inst << "#{head}[#{vector_to_size(h[:array])}][#{vector_to_size(h[:vector])}] - '#{h[:origin_name]}' "
                else  
                    @signals_ports_inst << "#{head}[#{vector_to_size(h[:vector])}] - '#{h[:origin_name]}' "
                end
            else 
                @signals_ports_inst << "#{head} - '#{h[:origin_name]}' "
            end
        end

        inf_proc = Proc.new { |h|
            # @format_args_twins  << "#{h[:name]}:\"#{h[:name]}\""
            # @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            # @inf_array  << h[:name] if h[:vector]
            # @collect_array << {name:h[:name],type:h[:type],way:h[:way]}
            # @alone_args << h[:name]
            # if h[:up_down] == "up_stream"
            #     @up_stream = h[:name]
            # elsif h[:up_down] == "down_stream"
            #     @down_stream = h[:name]
            # end
            # @ex_ports << h[:inst_ex_port]
            # @inf_port_left_len =  h[:port_left_len]   if h[:port_left_len]  > @inf_port_left_len
            # @inf_port_right_len = h[:port_right_len]  if h[:port_right_len] > @inf_port_right_len
            #
            # @test_obj   << "#{h[:name]} = #{h[:type].to_s}.new(name:\"#{h[:origin_name]}\",clock:c0,reset:r0)"
            # @tdl_inst_design_hash << h
            # if h[:vector]
            #     a_str = ",dimension:[#{vector_to_size(h[:vector])}]"
            # else
            #     a_str = ""
            # end

            if h[:vector]
                @inf_ports_inst << "port.#{h[:type]}.#{h[:modport]}[#{vector_to_size(h[:vector])}] - '#{h[:origin_name]}' "
            else 
                @inf_ports_inst << "port.#{h[:type]}.#{h[:modport]} - '#{h[:origin_name]}' "
            end
        }

        TdlSpace::TdlBaseInterface.subclass.each do |sc|
            # super(port_array,rep,"axi_stream_inf",up_stream_rep)
            if sc.const_defined?(:PORT_REP) && sc.const_defined?(:UP_STREAM_REP)
                # puts sc.get_class_var('hdl_name'),sc::UP_STREAM_REP,sc
                
                @port_str = TdlSpace::TdlBaseInterface.parse_ports(@port_str,sc::PORT_REP,sc.get_class_var('hdl_name'),sc::UP_STREAM_REP,sc.get_class_var('hdl_name'),&inf_proc)
            end
        end

        # @port_str = DataInf.parse_ports(@port_str,&inf_proc)
        # @port_str = DataInf_C.parse_ports(@port_str,&inf_proc)
        # # @port_str = VideoInf.parse_ports(@port_str,&inf_proc)
        # # @port_str = AxiLite.parse_ports(@port_str,&inf_proc)
        # @port_str = AxiStream.parse_ports(@port_str,&inf_proc)
        # @port_str = Axi4.parse_ports(@port_str,&inf_proc)

        # @@inf_parse_methods ||= []
        # @@inf_parse_methods.each do |m|
        #     @port_str = m.call(@port_str,&inf_proc)
        # end

        @bad = false

    end

    def self.add_inf_parse(parse_method)
        @@inf_parse_methods ||= []
        @@inf_parse_methods << parse_method
    end

    # private

    def exist_origin_sdl(filename,path)
        basename = File.basename(filename,".sv")
        File.exist?(File.join(path,"#{basename}.rb"))
    end

    def vector_to_size(v)
        rep = /\[\s*(?<h>.+)\s*:\s*(?<l>.+)\s*\]/
        mv = v.match(rep)
        if mv
            if (mv["h"] =~ /^\d+$/) && (mv["l"] =~ /^\d+$/)
                mv["h"].to_i + 1 - mv["l"].to_i
            else
                if (mv["l"].to_i.eql? 0) && (mv["h"] =~ /^(?<name>\S+)\s*-\s*1\s*$/)
                    str = $~["name"]
                else
                    str = "(#{mv["h"]}+1-#{mv["l"]})"
                end
                
                if mv["h"] =~ /(?<name>\$clog2\(\S+\))/ ## 匹配$clog2
                    str = "'" + v[1,v.size-2] + "'"
                else 
                    str = str.gsub(/\w+/) do |pt|
                        if pt =~ /^\d+$/
                            pt
                        else
                            " param.#{pt}"
                        end
                    end
                end
            end
        else
            if v =~ /:/
                v.gsub(":",",")
            else
                v
            end
        end
    end

    def gen_file
        unless File.exist?(@autof_name) 
            @autof = File.open(@autof_name,"w") do |f|
                f.print gen_head
                f.print gen_content
                # f.puts "sm.origin_sv = true"
            end
        else 
            _old_str  = File.open(@autof_name).read
            _new_str = gen_head+gen_content
            if _old_str != _new_str
                @autof = File.open(@autof_name,"w") do |f|
                    f.print _new_str
                    # f.puts "sm.origin_sv = true"
                end
            end
        end
    end

    def auto_rb
        return if @bad
        gen_file
    end

    def gen_head
"
# add_to_all_file_paths('#{@module_name}','#{@expand_path}')
# real_sv_path = '#{@expand_path}'
TdlBuild.#{@module_name} do 
self.real_sv_path = '#{@expand_path}'
self.path = File.expand_path(__FILE__)
"
    end

    def gen_content
        (@param_port_inst+@signals_ports_inst+@inf_ports_inst + ["end\n\n"]).join("\n")
    end


end

class AutoGenSdl # add auto_path
    @@auto_path="./"

    def self.auto_path
        @@auto_path
    end

    def self.auto_path=(path)
        @@auto_path=path
    end

end

# puts a.parse_params
# puts a.parse_normal_ports
# puts a.axi4_ports
# puts a.inf_ports

# puts a.draw_normal_ports.join(",\n")
# puts a.draw_axis_port.join(",\n")
# puts a.draw_videoinf.join(",\n")
# puts a.draw_axi4_port.join(",\n")
# puts a.draw_datainf_port.join(",\n")
# puts a.data_ports
# puts a.draw_datainf_c_port.join(",\n")
# a.auto_rb if a
