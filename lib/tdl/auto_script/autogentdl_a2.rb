# require_relative "./global_scan"

class AutoGenTdl

    attr_reader :params,:normal_ports,:axis_ports,:video_ports,:axi4_ports,:inf_ports,:data_ports,:data_c_ports,:lite_ports
    def initialize(filename="",out_file_path="",info=true)
        @expand_path = File.expand_path(filename)
        sf = File.open(filename,"r")
        fstr = sf.read.force_encoding("utf-8")
        sf.close

        fstr.gsub!(/\/\/\s*\(\*\s*show\s*=\s*"false"\s*\*\)/,"(* show = \"false\" *)")
        fstr.gsub!(/\/\*.*?\*\//m,"")
        fstr.gsub!(/\/\/.*/,"")

        if fstr =~ AxiStream::Synth_REP  # axi_stream class
            @targer_class = "AxiStream"
        elsif fstr =~ Axi4::Synth_REP # axi4 class
            @targer_class = "Axi4"
        elsif fstr =~ VideoInf::Synth_REP  # videoinf class
            @targer_class = "VideoInf"
        elsif fstr =~ DataInf::Synth_REP # datainf class
            @targer_class = "DataInf"
        elsif fstr =~ DataInf_C::Synth_REP# datainf_c class
            @targer_class = "DataInf_C"
        elsif fstr =~ AxiLite::Synth_REP# datainf_c class
            @targer_class = "AxiLite"
        elsif fstr =~ Logic::Synth_REP # only logic
            @targer_class = "Logic"
        else
            puts ">>>#{filename} <<< File's head must mark (* ??? = \"true\" *)\n" if info
            return nil
        end

        @autof_name = File.join(out_file_path,File::basename(filename,".*")+"_auto.rb")
        @autof = File.open(@autof_name,"w")

        regexp_module = /module\s+(?<name>\w+)\s*(#\((?<parameter>.*?)\))?\s*\((?<port>.*?)\)\s*;/m

        mth =  regexp_module.match(fstr)
        @module_name = mth["name"].downcase
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
        @tmp_actial_args_twins = []
        @alone_args = []
        @ex_params = []
        @ex_ports = []
        @test_obj = []
        @tdl_param_design_hash = []
        @tdl_inst_design_hash = []

        @type_port_args = []

        @inf_port_left_len = 0
        @inf_port_right_len = 0
        @para_port_len = 0


        Parameter.parse_params(@parameter_str) do |h|
            @format_args_twins  << "#{h[:name]}:#{h[:value]}"
            @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            @tmp_actial_args_twins  << "#{h[:name]}: tmp_#{h[:name]}"
            @alone_args << h[:name]
            @ex_params << h[:inst_ex_port]
            @para_port_len = h[:port_len] if h[:port_len] > @para_port_len
            @test_obj << "#{h[:name]} = Parameter.new(name:\"#{h[:name]}\",value:#{h[:value]})"
            @tdl_param_design_hash << h
        end

        @port_str = SignalElm.parse_ports(@port_str) do |h|
            @format_args_twins  << "#{h[:name]}:\"#{h[:name]}\""
            @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            @tmp_actial_args_twins  << "#{h[:name]}: tmp_#{h[:name]}"
            @alone_args << h[:name]

            @ex_ports << h[:inst_ex_port]
            @inf_port_left_len =  h[:port_left_len]   if h[:port_left_len]  > @inf_port_left_len
            @inf_port_right_len = h[:port_right_len]  if h[:port_right_len] > @inf_port_right_len
            @test_obj << "#{h[:name]} = Logic.new(name:\"#{h[:name]}\")"
            @tdl_inst_design_hash << h

            @type_port_args << h[:name] if(@targer_class.eql?(h[:type].to_s) && h[:vector].nil? )
        end

        inf_proc = Proc.new { |h|
            @format_args_twins  << "#{h[:name]}:\"#{h[:name]}\""
            @actial_args_twins  << "#{h[:name]}:#{h[:name]}"
            @tmp_actial_args_twins  << "#{h[:name]}: tmp_#{h[:name]}"
            @inf_array  << h[:name] if h[:vector]
            @collect_array << {name:h[:name],type:h[:type],way:h[:way]}
            @alone_args << h[:name]
            if h[:up_down] == "up_stream"
                @up_stream = h[:name]
            elsif h[:up_down] == "down_stream"
                @down_stream = h[:name]
            end
            @ex_ports << h[:inst_ex_port]
            @inf_port_left_len =  h[:port_left_len]   if h[:port_left_len]  > @inf_port_left_len
            @inf_port_right_len = h[:port_right_len]  if h[:port_right_len] > @inf_port_right_len

            @test_obj   << "#{h[:name]} = #{h[:type].to_s}.new(name:\"#{h[:origin_name]}\",clock:c0,reset:r0)"
            @tdl_inst_design_hash << h

            @type_port_args << h[:name] if @targer_class.eql?(h[:type].to_s)
        }

        @port_str = DataInf.parse_ports(@port_str,&inf_proc)
        @port_str = DataInf_C.parse_ports(@port_str,&inf_proc)
        @port_str = VideoInf.parse_ports(@port_str,&inf_proc)
        @port_str = AxiLite.parse_ports(@port_str,&inf_proc)
        @port_str = AxiStream.parse_ports(@port_str,&inf_proc)
        @port_str = Axi4.parse_ports(@port_str,&inf_proc)

        @@inf_parse_methods.each do |m|
            @port_str = m.call(@port_str,&inf_proc)
        end

    end


    def self.add_inf_parse(parse_method)
        @@inf_parse_methods ||= []
        @@inf_parse_methods << parse_method
    end

    def parameter_str
        if @parameter_str
            "#(\n"+@tdl_param_design_hash.map { |e| e[:inst_ex_port].call(@para_port_len) }.join(",\n")+"\n)"
        else
            ""
        end
    end

    def port_str
        "(\n"+@tdl_inst_design_hash.map {|e| e[:inst_ex_port].call(@inf_port_left_len,@inf_port_right_len) }.join(",\n")+"\n);\n"
    end

    def module_str
        # @origin_module_name+parameter_str+" #{@origin_module_name}_\#{signal}_inst"+port_str
        @origin_module_name+parameter_str+" \#{instance_name}"+port_str
    end


    def ex_up_down_args
        if(@alone_args.include? "up_stream") && (@alone_args.include? "down_stream")
            ["up_stream:nil","down_stream:nil"]
        elsif @alone_args.include? "up_stream"
            ["up_stream:nil"]
        elsif @alone_args.include? "down_stream"
            ["down_stream:nil"]
        else
            []
        end
    end

    def ex_up_down_args_alone
        if(@alone_args.include? "up_stream") && (@alone_args.include? "down_stream")
            ["up_stream","down_stream"]
        elsif @alone_args.include? "up_stream"
            ["up_stream"]
        elsif @alone_args.include? "down_stream"
            ["down_stream"]
        else
            []
        end
    end

    def gen_auto_class(method_str)
"
##{Time.now}
#require_relative \".././tdl\"

class #{@targer_class}

#{method_str}

end\n\n"
    end

    def check_inf_type
        str = ""
        @collect_array.each do |e|
            str +=
"
if #{e[:name]}.is_a? Array
    #{e[:name]}.each do |d|
        raise TdlError.new(\"\#{d.to_s} must a #{e[:type]}\") unless #{e[:name]}.is_a? #{e[:type]}
    end
else
    raise TdlError.new(\"#{e[:name]} must a #{e[:type]}\") unless #{e[:name]}.is_a? #{e[:type]}
end
"       end
        return str
    end

    def proc_array_inf
        str_map = @collect_array.map do |e|
            if (@inf_array.include? e[:name]) && e[:way]
"        #{e[:name]} = #{e[:type]}.same_name_socket(:#{e[:way].to_s},mix=false,#{e[:name]},nil,belong_to_module) unless #{e[:name]}.is_a? String"
            else
"        #{e[:name]} = #{e[:type]}.same_name_socket(:#{e[:way].to_s},mix=true,#{e[:name]},nil,belong_to_module) unless #{e[:name]}.is_a? String"
            end
        end
        return "\n"+str_map.join("\n")
    end

    def gen_methods(ex_str:"")

        if @down_stream
            method_name = @module_name
        else
            method_name = "_"+@module_name
        end

        ex_up_down_args = []
        ex_up_down_args << "up_stream:nil" if @up_stream
        ex_up_down_args << "down_stream:nil" if @down_stream

        ex_up_down_same_args = []
        ex_up_down_same_args << "up_stream:up_stream" if @up_stream
        ex_up_down_same_args << "down_stream:down_stream" if @down_stream

        str =
"
    def #{method_name}(
        #{(@format_args_twins+ex_up_down_args).join(",\n        ")}
    )
#{ex_str}
        Tdl.add_to_all_file_paths('#{@module_name}','#{@expand_path}')
        # GlobalParam.CurrTdlModule.add_to_all_file_paths(['#{@module_name}','#{@expand_path}'])
        return_stream = self
        #{proc_array_inf}
        #{
            if @down_stream && @up_stream
"
        if up_stream.nil? && #{@up_stream}.eql?(\"#{@up_stream}\") && (!(#{@down_stream}.eql?(\"#{@down_stream}\")) || !down_stream.nil?)
            # up_stream = self.copy(name:\"#{@up_stream}\")
            # return_stream = up_stream
            #{
                if @down_stream
                    "#{@down_stream} = down_stream if down_stream"
                end
            }
            return down_stream.#{method_name}(#{@up_stream}:self)
        end
"           end
        }
        #{
            if @up_stream
                "#{@up_stream} = up_stream if up_stream"
            end
        }
        #{
            if @down_stream
                "#{@down_stream} = self unless self==belong_to_module.#{@targer_class}_NC"
        "unless self.eql? belong_to_module.#{@targer_class}_NC
            #{@down_stream} = self
        else
            if down_stream
                #{@down_stream} = down_stream
            end
        end"

            end
        }


        belong_to_module.#{@targer_class}_draw << #{method_name}_draw(
            #{(@actial_args_twins+ex_up_down_same_args).join(",\n            ")})
        return return_stream
    end

    private

    def #{method_name}_draw(
        #{(@format_args_twins+ex_up_down_args).join(",\n        ")}
    )

        large_name_len(
            #{@alone_args.join(",\n            ")}
        )
        instance_name = \"#{@origin_module_name}_\#{signal}_inst\"
\"
// FilePath:::#{@expand_path}
#{module_str}\"
    end
    " + gen_class_method(method_name,ex_up_down_args,ex_up_down_same_args)
    end

    def add_LastModuleInstName()
        "GlobalParam.LastModuleInstName = instance_name "
    end

    def gen_class_method(method_name,ex_up_down_args,ex_up_down_same_args)


        "
    public

    def self.#{@module_name}(
        #{(@format_args_twins+ex_up_down_args+['belong_to_module:nil']).join(",\n        ")}
        )
        return_stream = nil
        #{
            if @type_port_args.any?
                "belong_to_module = [#{(@type_port_args+ex_up_down_args_alone).join(',')}].first.belong_to_module unless belong_to_module"
            end
        }
        #{
            if @down_stream && @up_stream
"
        if down_stream.nil? && #{@down_stream}.eql?(\"#{@down_stream}\")
            if up_stream.is_a? #{@targer_class}
                down_stream = up_stream.copy
            else
                down_stream = #{@up_stream}.copy
            end
            return_stream = down_stream
        end
"           end
        }
        #{
            if @down_stream && @up_stream
"
        if up_stream.nil? && #{@up_stream}.eql?(\"#{@up_stream}\")
            if down_stream.is_a? #{@targer_class}
                up_stream = down_stream.copy
            else
                up_stream = #{@down_stream}.copy
            end
            return_stream = up_stream
        end
"           end
        }
        #{
            if @down_stream
                "
        if down_stream.is_a? #{@targer_class}
            down_stream.#{method_name}(
                #{(@actial_args_twins+ex_up_down_same_args).join(",\n                ")})
        elsif #{@down_stream}.is_a? #{@targer_class}
            #{@down_stream}.#{method_name}(
                #{(@actial_args_twins+ex_up_down_same_args).join(",\n                ")})
        else
            belong_to_module.#{@targer_class}_NC.#{method_name}(
                #{(@actial_args_twins+ex_up_down_same_args).join(",\n                ")})
        end"
            else
        "belong_to_module.#{@targer_class}_NC.#{method_name}(
            #{(@actial_args_twins+ex_up_down_same_args).join(",\n            ")})"
            end
        }
        return return_stream
    end
        "
    end

    def gen_tdl_inst_module

"
class Tdl

    def Tdl.inst_#{@module_name}(
        #{@format_args_twins.join(",\n        ")})
        hash = TdlHash.new
        #{
            (@tdl_param_design_hash+@tdl_inst_design_hash).map { |e|
                "
        unless #{e[:name]}.is_a? Hash
            hash.case_record(:#{e[:name]},#{e[:name]})
        else
            # hash.new_index(:#{e[:name]})= lambda { a = #{e[:type]}.new(#{e[:name]});a.name = \"#{e[:name]}\";return a }
            # hash[:#{e[:name]}] = lambda { a = #{e[:type]}.new(#{e[:name]});a.name = \"#{e[:name]}\";return a }
            raise TdlError.new('#{@module_name} #{e[:type]} #{e[:name]} TdlHash cant include Proc') if #{e[:name]}.select{ |k,v| v.is_a? Proc }.any?
            lam = lambda {
                a = #{e[:type]}.new(#{e[:name]})
                unless #{e[:name]}[:name]
                    a.name = \"#{e[:name]}\"
                end
                return a }
            hash.[]=(:#{e[:name]},lam,false)
        end
                "
            }.join("\n")
        }

        if block_given?
            yield hash
        end

        hash.push_to_module_stack(#{@targer_class},:#{@module_name})
        hash.open_error = true
        return hash
    end
end
"
    end


    def auto_rb(ex_methods_str:"")
        if @module_name
            # @autof.puts gen_auto_class(gen_methods(ex_str:ex_methods_str))+gen_tdl_inst_module
            @autof.puts gen_auto_class(gen_methods(ex_str:ex_methods_str))
            @autof.close
            require_relative @autof_name
        end
    end

end

class AutoGenTdl # add auto_path
    @@auto_path="./"

    def self.auto_path
        @@auto_path
    end

    def self.auto_path=(path)
        @@auto_path=path
    end

end

# a = AutoGenTdl.new('..\..\axi\AXI_stream\data_interface\data_inf_ticktock.sv','..\..\tdl\data_inf')

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
