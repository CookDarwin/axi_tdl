
module TdlSpace 

    module VarElemenAttr

        ## 定义 变量例化形式 
        ## 比如 hdl axi_stream_inf #(.DSIZE(8),.FreqM(1.11))  cm_tb_m (.aclk(from_ethernet.aclk),.aresetn(from_ethernetm.aresetn),.aclken(1'b1));
        ##      tdl axi_stream_inf(name:cm_tb_m, dsize: 0,freqM: 1.11, clock: from_ethernet.aclk,reset: from_ethernetm.aresetn,aclken: 1.b1)

        ## hdl_name :axi_stream_inf
        ## modports :master,:slaver,:mirror,:mirror_out
        ## param_map :dsize,'DSIZE',8 ## <tdl_key><hdl_key><default_value>
        ## clock_io_map :aclk,:aclk,100 ## <tdl_key><hdl_key><default_freqM>
        ## reset_io_map :aresetn,:aresetn
        ## sdata_maps :axis_tvalid,:axis_tready,:axis_tuser
        #  pdata_map   :axis_tdata,[:dsize]
        #  pdata_map   :axis_tkeep,[]
        #  pdata_map   :axis_tcnt

        def get_class_var(name,default=nil)
            # begin
            #     instance_variable_get("@_#{name}_")
            # rescue 
            #     instance_variable_set("@_#{name}_",nil)
            # end

            unless instance_variable_get("@_#{name}_")
                instance_variable_set("@_#{name}_",default)
                container = instance_variable_get("@_#{name}_")
            else
                container = instance_variable_get("@_#{name}_")
            end
    
            return container
        end
    
        def set_class_var(name,value)
            # rel = get_class_var(name)
            instance_variable_set("@_#{name}_",value)
            container = instance_variable_get("@_#{name}_")
        end

        def hdl_name(name,*nicknames)
            # @@__hdl_name__ = name.to_s 
            set_class_var('hdl_name',name.to_s)

            ## 给 sdlmodule 定义例化方法
            ## 例化名
            ## 比如 sv  接口 axi4,可以在tdl里面这样用 axi4() ; `name`=axi4
            self.class_exec(name) do |name|
                SdlModule.class_exec(name,self) do |name,ele_class|
                    define_method(name) do |args={}|
                        hash = args || {}
                        hash[:belong_to_module] = self
                        rel = TdlSpace::DefEleBaseArrayChain.new(hash)
                        rel.tclass = ele_class
                        return rel
                    end

                    nicknames.each do |nn|
                        alias_method nn,name
                    end
                end

                _self = self

                TdlSpace::DefPortArrayChain.class_exec(name,self) do |name,ele_class|
                    define_method(name) do 
                        rel = TdlSpace::DefPortEleBaseArrayChain.new(ele_class,belong_to_module)
                        return rel
                    end

                    nicknames.each do |nn|
                        alias_method nn,name
                    end

                end
            end

            ## 给例化模块时的 SdlInstPortSugar 添加 方法
            SdlInstPortSugar.class_exec(name,nicknames)  do |name,nicknames|
                define_method(name) do 
                    return self
                end

                nicknames.each do |ne|
                    define_method(ne) do 
                        return self 
                    end
                end
            end
        end

        def modports(*args)
            # @@__interface_modports__ ||= []
            # @@__interface_modports__ += args
            interface_modports = get_class_var('interface_modports',[])
            interface_modports += args 
            set_class_var('interface_modports',interface_modports)

            args.each do |e|
                # puts ("modport_#{e}_input")
                define_singleton_method("modport_#{e}_input") do |*xargs|
                    interface_modport_signals = get_class_var("#{e}_interface_modport_signals_input",[])
                    interface_modport_signals += xargs
                    interface_modport_signals.uniq!
                    set_class_var("#{e}_interface_modport_signals_input",interface_modport_signals)
                end

                define_singleton_method("modport_#{e}_output") do |*xargs|
                    interface_modport_signals = get_class_var("#{e}_interface_modport_signals_output",[])
                    interface_modport_signals += xargs
                    interface_modport_signals.uniq!
                    set_class_var("#{e}_interface_modport_signals_output",interface_modport_signals)
                end

            end

        end

        def param_map(tdl_key,hdl_key,default_value=nil)
            interface_params = get_class_var('origin_interface_params',{})
            interface_params[tdl_key.to_s] = [hdl_key.to_s,default_value]
            set_class_var('origin_interface_params',interface_params)

            ## 定义实例方法
            self.class_exec(tdl_key,hdl_key) do |tdl_key,hdl_key|
                define_method(tdl_key) do 
                    rel = self.instance_variable_get("@_#{tdl_key}_")
                    unless rel 
                        if !dimension || dimension.empty?
                            TdlSpace::ArrayChain.create(obj: "#{inst_name}.#{hdl_key}".to_nq, belong_to_module: belong_to_module)
                        else 
                            TdlSpace::ArrayChain.create(obj: "#{inst_name}[0].#{hdl_key}".to_nq, belong_to_module: belong_to_module)
                        end
                    else 
                        rel 
                    end
                end

                define_method("#{tdl_key}=") do |arg|
                    self.instance_variable_set("@_#{tdl_key}_",arg)
                end

                define_method(hdl_key) do 
                    self.send(tdl_key)
                end

            end
        end

        def clock_io_map(tdl_key,hdl_key,default_freqM=nil)
            _io_map(tdl_key,hdl_key,nil,"clock",default_freqM)
             ## 定义实例方法
             self.class_exec(tdl_key) do |tdl_key|
                define_method('clock') do 
                    rel = self.instance_variable_get("@_#{tdl_key}_")
                    if !dimension || dimension.empty?
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}.#{hdl_key}", belong_to_module: belong_to_module)
                    else  
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}[0].#{hdl_key}", belong_to_module: belong_to_module)
                    end
                end

                define_method("clock=") do |arg|
                    self.instance_variable_set("@_#{tdl_key}_",arg)
                end

            end
        end

        def reset_io_map(tdl_key,hdl_key,active='low')
            _io_map(tdl_key,hdl_key,nil,"reset",active.to_s.downcase)
             ## 定义实例方法
             self.class_exec(tdl_key) do |tdl_key|
                define_method('reset') do 
                    rel = self.instance_variable_get("@_#{tdl_key}_")
                    if !dimension || dimension.empty?
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}.#{hdl_key}", belong_to_module: belong_to_module)
                    else 
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}[0].#{hdl_key}", belong_to_module: belong_to_module)
                    end
                end

                define_method("reset=") do |arg|
                    self.instance_variable_set("@_#{tdl_key}_",arg)
                end

            end
        end

        def comm_io_map(tdl_key,hdl_key,default_value=nil)
            _io_map(tdl_key,hdl_key,default_value,nil)
        end

        def comm_io_maps_same(*tdl_keys)
            tdl_keys.each do |e|
                comm_io_map(e,e,nil)
            end
        end

        def _io_map(tdl_key,hdl_key,default_value,flag,other=nil)
            interface_io = get_class_var('origin_interface_io',{})
            interface_io[tdl_key.to_s] = [hdl_key.to_s,default_value,flag,other]
            set_class_var('origin_interface_io',interface_io)

            ## 定义实例方法
            self.class_exec(tdl_key) do |tdl_key|
                define_method(tdl_key) do 
                    rel = self.instance_variable_get("@_#{tdl_key}_") || default_value
                    if !dimension || dimension.empty?
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}.#{hdl_key}", belong_to_module: belong_to_module)
                    else 
                        rel || TdlSpace::ArrayChain.create(obj:"#{self.inst_name}[0].#{hdl_key}", belong_to_module: belong_to_module)
                    end
                end

                define_method("#{tdl_key}=") do |arg|
                    self.instance_variable_set("@_#{tdl_key}_",arg)
                end

            end
        end

        def sdata_maps(*args)
            args.each do |e|
                _io_map(e,e,nil,'sdata',nil)
                self.class_exec(e) do |e|
                    define_method(e) do 
                        TdlSpace::ArrayChain.create(obj:"#{self.inst_name}.#{e}", belong_to_module: belong_to_module)
                    end
                end
            end
        end

        def pdata_map(name,dimension=[])
            _io_map(name,name,nil,'pdata',dimension)
            self.class_exec(name) do |e|
                define_method(e) do 
                    TdlSpace::ArrayChain.create(obj:"#{self.inst_name}.#{e}", belong_to_module: belong_to_module)
                end
            end
        end

        ## 生成 SV 文件

        def gen_sv_interface(path)
            File.open(File.join(path,get_class_var('hdl_name')+".sv"),'w') do |f|

                inerface_params = get_class_var('origin_interface_params',{})

                par_str = []
                inerface_params.each do |k,v|
                    par_str << "    parameter #{v[0]} = #{v[1]}"
                end

                interface_io = get_class_var('origin_interface_io',{})

                clock_reset_str = []
                sdata_str = []
                pdata_str = []
                interface_io.each do |k,v|
                    ## 查找clock reset
                    if v[2]=="clock" || v[2]=="reset"
                        clock_reset_str << "    input #{v[0]}"
                    end 

                    ## 单信号
                    if v[2] == "sdata"
                        sdata_str << "logic #{v[0]};"
                    end

                    ## 多信号
                    if v[2] == "pdata"
                        dv = v[3]
                        
                        dv.map! do |e| 
                            if inerface_params.keys.include?(e.to_s )
                                inerface_params[e.to_s][0]
                            else 
                                e.to_s
                            end
                        end 

                        dv_str = dv.map do |e| 
                            "[#{e}-1:0]"
                        end.join() 

                        pdata_str << "logic #{dv_str} #{v[0]};"
                    end

                end

                if par_str.any?
                    par_str = "#(\n#{par_str.join(",\n")}\n)"
                else 
                    par_str = ''
                end

                if clock_reset_str.any? 
                    clock_reset_str = "\n"+clock_reset_str.join(",\n")+"\n"
                else  
                    clock_reset_str = ''
                end

                if sdata_str.any? 
                    sdata_str = "\n"+sdata_str.join("\n")+"\n"
                else 
                    sdata_str = ""
                end

                if pdata_str.any? 
                    pdata_str = "\n"+pdata_str.join("\n")+"\n"
                else  
                    pdata_str = ''
                end

                interface_modports = get_class_var('interface_modports',[])

                sub_modport = []
                interface_modports.each do |e|
                    interface_modport_signals_in  = get_class_var("#{e}_interface_modport_signals_input",[])
                    interface_modport_signals_out = get_class_var("#{e}_interface_modport_signals_output",[])
                    sub_modport << "modport #{e} (\n"

                    xsub_modport = []
                    xsub_modport += interface_modport_signals_in.map do |m| 
                        if inerface_params.keys.include?(m.to_s )
                            inerface_params[m.to_s][0]
                        else 
                            m.to_s
                        end 
                    end.map do |m| 
                        "input #{m}"
                    end
            
                    xsub_modport += interface_modport_signals_out.map do |m| 
                        if inerface_params.keys.include?(m.to_s )
                            inerface_params[m.to_s][0]
                        else 
                            m.to_s
                        end 
                    end.map do |m| 
                        "output #{m}"
                    end


                    sub_modport <<  xsub_modport.join(",\n")
                    sub_modport << "\n);\n"
                end

                if sub_modport.any? 
                    sub_modport = sub_modport.join('')
                else  
                    sub_modport = ''
                end 
                
               
                f.puts "interface #{get_class_var('hdl_name')} #{par_str} (#{clock_reset_str});#{sdata_str}#{pdata_str}"
                f.puts sub_modport
                f.puts "endinterface:#{get_class_var('hdl_name')}"
            end 
        end
    end 

    module VarElemenCore
        attr_accessor :logic_type,:dimension,:inst_name
        ## --------------------------------------

        def to_s 
            "#{inst_name}"
        end

        def name 
            "#{inst_name}"
        end

        def name=(n)
            inst_name = n 
            "#{inst_name}"
        end

        def [](*a)
            a.each do |e| 
                if e.is_a? ClassHDL::OpertorChain
                    e.slaver = true
                end 
            end
            TdlSpace::ArrayChain.create(obj: self,lchain: a, belong_to_module: belong_to_module)
        end

        def instance(exp_len: nil)
            if modport_type 
                _port_inst(exp_len)
            else
                _inner_inst
            end
        end

        def inst_port
            return [_port_inst_core_front,inst_name,_back_dimension_]
        end

        def modport_type
            @modport_type 
        end 

        def modport_type=(a)
            ## 清除内部例化
            define_singleton_method('_inner_inst') do 
                nil
            end

            ports = @belong_to_module.instance_variable_get("@ports")
            ports ||= Hash.new
            ports[inst_name] = self
            @belong_to_module.instance_variable_set("@ports",ports)
            @modport_type = a 
        end

        def _inner_inst 
            "#{get_class_var('hdl_name')}#{_inner_param_inst}#{inst_name}#{_back_dimension_}#{_inner_io_inst};"
        end

        private 

        def _port_inst(exp_len=nil)
            front_str = _port_inst_core_front
            len_front = front_str.size
            if exp_len && exp_len > front_str
                front_str   = front_str + " "*(exp_len - front_str)
            end
            "#{front_str}#{inst_name}#{_back_dimension_}"
        end

        def _inner_param_inst
            origin_interface_params = get_class_var('origin_interface_params')
            unless origin_interface_params
                return ' '
            end
            str = []
            origin_interface_params.each do |k,v|
                rel = self.instance_variable_get("@_#{k}_")
                vv = rel || v[1]
                # vv = self.send(k) || v[1]
                ## 不例化 FreqM，FreqM只是为了SDL兼容
                # if vv && k.to_s != 'freqM'
                if vv 
                    if vv.instance_of?(String)
                        str << ".#{v[0]}(\"#{vv}\")"
                    else
                        if k.to_s == 'freqM'
                            str << ".#{v[0]}(#{(respond_to?(:clock) && self.clock.is_a?(Clock) && self.clock.freqM ) || vv})"
                        else 
                            str << ".#{v[0]}(#{vv})"
                        end
                    end
                end
            end
            if str.any?
                " #(#{str.join(',')}) "
            else 
                ' '
            end
        end

        def _inner_io_inst 
            origin_interface_io = get_class_var('origin_interface_io')
            unless origin_interface_io
                return '()'
            end 

            str = []
            origin_interface_io.each do |k,v|
                vv = self.send(k) || v[1]
                ## 去除 sdata pdata 这些内部信号
                if vv && v[2] != 'sdata' && v[2] != 'pdata'
                    str << ".#{v[0]}(#{vv})"
                end
            end
            if str.any?
                " (#{str.join(',')}) "
            else 
                '()'
            end

        end

        def _port_inst_core_front
            # modport_type = :master
            "#{get_class_var('hdl_name')}#{@modport_type ? ".#{@modport_type}" : ""} #{@logic_type}#{_front_dimension_}"
            # modport_type
        end

        def _back_dimension_ 
            ##普通逻辑类型
            if @logic_type.to_s == "logic"  || @logic_type.to_s == "wire"
                if dimension && dimension.size > 1
                    str = dimension[0,dimension.size-2].map do |e|
                        if e.is_a? Integer
                                "[#{e-1}:0]"
                        elsif e.is_a? Array 
                            return "[#{e[0]}:#{e[1]}]"
                        else 
                            return "[#{e.to_s}-1:0]"
                        end 
                    end.join('')
                    return " #{str}"
                else
                    return ""
                end
            else 
                if dimension && dimension.size > 0
                    str = dimension.map do |e|
                        if e.is_a? Integer
                                "[#{e-1}:0]"
                        elsif e.is_a? Array 
                            return "[#{e[0]}:#{e[1]}]"
                        else 
                            return "[#{e.to_s}-1:0]"
                        end 
                    end.join('')
                    return " #{str}"
                else 
                    return ''
                end
            end
        end

        def _front_dimension_
            ##普通逻辑类型
            if @logic_type.to_s == "logic"  || @logic_type.to_s == "wire"
                if dimension && dimension.any? 
                    if dimension.last.is_a? Integer
                        return " [#{dimension.last-1}-1:0] "
                    elsif dimension.last.is_a? Array 
                        return " [#{dimension.last[0]}:#{dimension.last[1]}] "
                    else 
                        return " [#{dimension.last.to_s}-1:0] "
                    end 
                else
                    return " "
                end
            else 
                return " "
            end
        end

        ## 获取 类变量
        def get_class_var(name)
            self.class.get_class_var(name,nil)
        end
    end
end

module TdlSpace
    class TdlBaseInterface < AxiTdl::SdlModuleActiveBaseElm
        extend VarElemenAttr
        include VarElemenCore

        attr_accessor :belong_to_module

        def initialize(belong_to_module=nil)
            element_to_module(belong_to_module)
        end
        
        def element_to_module(belong2m)
            @belong_to_module = belong2m
            ec = @belong_to_module.instance_variable_get("@__element_collect__") || []
            unless ec.include? self
                ec << self 
                @belong_to_module.instance_variable_set("@__element_collect__",ec)
            end
        end

        @@child = []

        def self.inherited(subclass)
            unless @@child.include? subclass
                @@child << subclass
            end
        end

        def self.subclass
            @@child
        end

        def self.parse_ports(port_array,rep,inf_name,up_stream_rep,type)
            ports = []
            del_ports = []
            if port_array
                ports = port_array.map do |e|
                    me = e.match(rep)
                    if me
                        del_ports << e
                        h = Hash.new
                        h[:type] = type
                        h[:modport] = me["modport"].downcase
    
                        if h[:modport]=="master"
                            h[:way] = :to_down
                        elsif  h[:modport]=="slaver"
                            h[:way] = :from_up
                        else
                            h[:way] = :mirror
                        end
    
                        h[:name]    = me["name"].downcase
                        h[:origin_name] = me["name"]
                        h[:vector]  = me["vector"] if me["vector"]
                        if me["ud_name"]
                            h[:up_down] = me["ud_name"] =~ up_stream_rep ? "up_stream" : "down_stream"
                        else
                            h[:up_down] = "nil"
                        end
    
                        ##
                        port_left_len  = 4+"#{inf_name}.#{h[:modport]}".length+6
                        port_right_len = 4+h[:origin_name].length
    
                        h[:port_left_len] = port_left_len
                        h[:port_right_len] = port_right_len
    
                        h[:inst_ex_port] = lambda {|left,right|
                            if left >= port_left_len
                                ll  = left - port_left_len
                            else
                                ll = 1
                            end
    
                            if right >= port_right_len
                                rl  = right - port_right_len
                            else
                                rl = 1
                            end
    
                            "/*  #{inf_name}.#{h[:modport]}" + " "*ll+ "*/ " + ".#{h[:origin_name]}"+" "*rl + " (\#{align_signal(#{h[:name]},q_mark=false)})"
                        }
                        if block_given?
                            yield h
                        end
                        ##
                        h
                    else
                        nil
                    end
                end
            end
            # puts port_array,"=====",del_ports
            return_ports = port_array - del_ports
            return  return_ports
        end

        ## Monkey 布丁, 引入一个 StringBandItegration 集成变量
        def name_copy(nstr)
            nstr = nstr || inst_name
            if nstr.is_a?(StringBandItegration) && true
                return nstr
            else
                if nstr.to_s.eql?(inst_name.to_s)
                    @copy_id ||= 0
                    str = "#{nstr.to_s}_copy_#{@copy_id}"
                    @copy_id += 1
                    str
                else
                    nstr.to_s
                end
            end
        end

        ## Monkey 布丁, 
        def force_name_copy(nstr)
            
            if nstr.to_s.eql?(inst_name.to_s)
                @copy_id ||= 0
                str = "#{nstr.to_s}_copy_#{@copy_id}"
                @copy_id += 1
                str
            else
                nstr.to_s
            end
            
        end

        def use_which_freq_when_copy(argv_clock,argv_origin)
            if argv_clock == @clock && @clock
                if @clock.respond_to? :freqM
                    @clock.freqM
                else  
                    "#{inst_name}.FreqM".to_nq
                end
            elsif argv_clock != @clock && argv_clock.is_a?(Clock)
                argv_clock.freqM
            elsif !(argv_clock.is_a?(Clock)) && argv_origin
                argv_origin
            else
                nil
            end
        end

        def clock_reset_taps(def_clock_name,def_reset_name,self_clock,self_reset)

            new_clk = belong_to_module.logic.clock(self.FreqM) - def_clock_name
            new_reset = belong_to_module.logic.reset('low') - def_reset_name
    
            belong_to_module.Assign do 
                new_clk <= self_clock 
                new_reset <= self_reset
            end 
            [new_clk,new_reset]
        end

    end
end 

## 定义语法糖
module TdlSpace 
    ## 只能用于接口，dimension 和 DSIZE 并不共享空间
    class DefEleBaseArrayChain < DefArrayChain 
        # DefArrayChain in sdlmodule_arratchain
        # attr_accessor :dsize,:freqM,:clock,:reset
        attr_accessor :tclass,:modport_type
        def initialize(hash)
            super(hash[:belong_to_module])
            # @dsize = dsize 
            # @freqM = freqM
            # @clock = clock 
            # @reset = reset
            @origin_hash = hash
            if hash[:dsize] && hash[:dsize].instance_of?(String)
                raise TdlError.new("DSIZE<#{hash[:dsize]}> Cant be String")
            end
        end

        def [](*a)
            if a[0].is_a? Range
                a = a.to_a 
            end

            if a.empty?
                raise TdlError.new("参数不能为空")
            end
            new_dla = self.class.new(@origin_hash)
            new_dla.chain = @chain + a
            new_dla.tclass = self.tclass
            new_dla.modport_type = modport_type
            new_dla
        end
        
        def - (xname)
            unless xname.is_a? Symbol
                name = to_inp(xname)
            else 
                name = to_inp(xname.to_s)
            end
            # belong_to_module.Def.datainf_c(name: name ,clock: clock||@clock,reset: reset||@reset ,dsize: dsize||@dsize ,dimension: @chain,freqM:freqM||@freqM)
            if @chain.length > 0
                dimension = @chain[0,@chain.length]
                @origin_hash[:dimension] = dimension
            end
            
            int = tclass.new(@origin_hash[:belong_to_module])
            int.inst_name = name
            int.dimension = @chian 
            if modport_type
                int.modport_type = modport_type
            end
            @origin_hash.each do |k,v| 
                ## 
                if int.respond_to? k 
                    int.public_send("#{k}=",v)
                end
            end

            if @belong_to_module.respond_to?(name) 
                raise   TdlError.new("Cant redefine #{name} !!! ")
            end

            if name.to_s.strip.empty? 
                raise   TdlError.new("Name Cant empty !!! ")
            end

            ## 给sdlmodule添加直接调用 方法 
            @belong_to_module.define_singleton_method(name) { int }

            StringBandItegration.add_method_to_itgt(name,int)
            return int

        end
    end

    class DefPortEleBaseArrayChain 
        def initialize(ele_class,sdlmodule)
            @ele_class = ele_class
            @sdlmodule = sdlmodule
        end

        def method_missing(name,*args,&block)
            ## 检查有没有 modports
            modports = @ele_class.get_class_var('interface_modports') || []
            if !( modports.include?(name.to_sym) || modports.map{ |e| e.to_s }.include?(name.to_s) )
                raise TdlError.new("#{@ele_class.get_class_var('hdl_name')} dont have modport #{name}")
            end

            hash = args[0] || {}
            hash[:belong_to_module] = @sdlmodule
            rel = TdlSpace::DefEleBaseArrayChain.new(hash)
            rel.tclass = @ele_class
            rel.modport_type = name
            return rel

        end
    end
end

class TestAxiStream < TdlSpace::TdlBaseInterface

    hdl_name :text_axi_stream_inf
    modports :master,:slaver,:mirror,:mirror_out
    param_map :dsize,'DSIZE',18 ## <tdl_key><hdl_key><default_value>
    clock_io_map :aclk,:aclk,100 ## <tdl_key><hdl_key><default_freqM>
    reset_io_map :aresetn,:aresetn
    sdata_maps :axis_tvalid,:axis_tready,:axis_tuser,:axis_tlast
    pdata_map   :axis_tdata,[:dsize]
    pdata_map   :axis_tkeep,[]
    pdata_map   :axis_tcnt

    PORT_REP = nil

end

def test0
    as = TestAxiStream.new
    as.modport_type = 'master'
    as.dimension = [9,4]
    as.inst_name = "dt_inf"

    puts as.instance
end

def test_inner_inst
    as = TestAxiStream.new
    # as.modport_type = 'master'
    as.dsize = 12
    as.clock = 'clock_90M'
    as.reset = "rst_n"
    as.dimension = [9,4]
    as.inst_name = "dt_inf"

    puts as.instance
end

# test_inner_inst()