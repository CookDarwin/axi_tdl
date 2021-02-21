module ItegrationAttr

    def get_itgt_var(name,default=[])
        unless instance_variable_get("@_#{name}_")
            instance_variable_set("@_#{name}_",default)
            container = instance_variable_get("@_#{name}_")
        else
            container = instance_variable_get("@_#{name}_")
        end

        return container
    end

    def set_itgt_var(name,value)
        # rel = get_itgt_var(name)
        instance_variable_set("@_#{name}_",value)
        container = instance_variable_get("@_#{name}_")
    end

    def itegration_hash
        instance_variable_get("@_itegration_link_hash_")
    end

    def itegration_link
        instance_variable_get("@_itegration_link_collect_")
    end

    def itegration_explort
        instance_variable_get("@_itegration_explort_collect_")
    end

    def link_explort(*names)
        ## explort_active_hash
        explort_active_hash = get_itgt_var('explort_active_hash',{})
        ## explort_silence_hash
        explort_silence_hash = get_itgt_var('explort_silence_hash',{})
        ## 存入 list
        # unless instance_variable_get("@_itegration_explort_collect_")
        #     instance_variable_set("@_itegration_explort_collect_",[])
        #     container = instance_variable_get("@_itegration_explort_collect_")
        # else
        #     container = instance_variable_get("@_itegration_explort_collect_")
        # end
        container = get_itgt_var('itegration_explort_collect',[])

        container = container | names.map{ |e| e.to_s }
        instance_variable_set("@_itegration_explort_collect_",container)

        ## 定义引用输出是发生的情况
        names.each do |name|
            define_singleton_method("active_#{name}") do |names_pool_signal=nil,&block|
                unless names_pool_signal
                    explort_active_hash[name.to_s] = block
                else
                    explort_active_hash[name.to_s] = names_pool_signal.to_s
                end
            end

            define_singleton_method("silence_#{name}") do |&block|
                explort_silence_hash[name.to_s] = block
            end
        end

        ## 生成实例方法
        self.class_exec do
            names.each do |name|
                define_method("active_#{name}_proc_run") do
                    itgt_inst = self
                    inst_explort_active_hash = get_itgt_var('explort_active_hash'){ explort_active_hash.clone }
                    inst_explort_run_hash    = get_itgt_var('explort_active_run_record',{})
                    inst_explort_silence_hash = get_itgt_var('explort_silence_hash'){ explort_silence_hash.clone }

                    inst_explort_silence_hash.delete(name.to_s)
                    ## 如果运行过则，从记录中加载
                    if inst_explort_run_hash[name.to_s]
                        return inst_explort_run_hash[name.to_s]
                    end

                    ## 没有要激活的proc 则直接调用
                    unless inst_explort_active_hash[name.to_s]
                        return itgt_inst.send(name.to_s)
                    end

                    itgt_inst.set_itgt_var('explort_silence_hash',inst_explort_silence_hash)

                    if inst_explort_active_hash[name.to_s].is_a? String
                        brel = inst_explort_active_hash[name.to_s].snoop(itgt_inst,itgt_inst.top_module)
                    elsif inst_explort_active_hash[name.to_s]
                        # $_implicit_curr_itgt_ = itgt_inst
                        ItegrationVerb.curr_itgt_push itgt_inst
                        brel = itgt_inst.top_module.instance_exec(itgt_inst,&inst_explort_active_hash[name.to_s])
                        ItegrationVerb.curr_itgt_pop
                    end

                    ## 运行一次后删掉
                    inst_explort_active_hash.delete(name.to_s)
                    # 记录
                    inst_explort_run_hash[name.to_s] = brel

                    itgt_inst.set_itgt_var('explort_active_run_record',inst_explort_run_hash)

                    itgt_inst.set_itgt_var('explort_active_hash',inst_explort_active_hash)

                    brel

                end

            end


            define_method('silence_procs_run') do
                inst_explort_silence_hash = get_itgt_var('explort_silence_hash',explort_silence_hash.clone)
                # $_implicit_curr_itgt_ = self
                ItegrationVerb.curr_itgt_push self
                inst_explort_silence_hash.each_value do |v|
                    self.top_module.instance_exec(self,&v) if v
                end
                ItegrationVerb.curr_itgt_pop
            end
        end
    end

    def has_attr(*names)
        link_explort(*names)
    end

    def has_flag(*names)
        ## 标识控制
        container = get_itgt_var('itegration_flag_collect',[])
        container = container | names.map{ |e| e.to_s }
        set_itgt_var("itegration_flag_collect",container)
    end

    def link_itgt(*names)
        container_hash = get_itgt_var('itegration_link_hash',{})
        ## 为每个link生成一个保存attr的list
        names.each do |name|
            unless container_hash[name.to_s]
                container_hash[name.to_s] = []
            end
        end
        set_itgt_var('itegration_link_hash',container_hash)
        ## 存入 list
        container = get_itgt_var('itegration_link_collect',[])
        container = container | names.map { |e| e.to_s }
        set_itgt_var('itegration_link_collect',container)
        ## 生成实例方法
        # self.class_exec do
        #     names.each do |name|
        #         define_method(name) do
        #             ItegrationVerb[name]
        #         end
        #     end
        # end

        ## 生成2级类方法
        names.each do |name|

            define_singleton_method("#{name}_has_attr") do |*argvs|
                # puts argvs
                # return 90
                # ItegrationVerb[name]
                ## 把 attr 保存到 list
                container_hash = get_itgt_var('itegration_link_hash',{})
                container_hash[name.to_s] = container_hash[name.to_s] | argvs.map { |e| e.to_s }
                set_itgt_var('itegration_link_hash',container_hash)
            end

            define_singleton_method("#{name}_has_flag") do |*argvs|
                "itgt 标识"
                container_hash = get_itgt_var('itegration_flag_hash',{})
                container_hash[name.to_s] ||= []
                container_hash[name.to_s] = container_hash[name.to_s] | argvs.map { |e| e.to_s }
                set_itgt_var('itegration_flag_hash',container_hash)
            end

        end
    end

    def compact_link_itgt(*names)
        link_itgt(*names)
        # container_hash = get_itgt_var('itegration_compact_link_hash',{})
        # ## 为每个link生成一个保存attr的list
        # names.each do |name|
        #     unless container_hash[name.to_s]
        #         container_hash[name.to_s] = []
        #     end
        # end
        # set_itgt_var('itegration_compact_link_hash',container_hash)
        ## 存入 list
        container = get_itgt_var('itegration_compact_link_collect',[])
        container = container | names.map { |e| e.to_s }
        set_itgt_var('itegration_compact_link_collect',container)
        #
        # ## 生成2级类方法
        # names.each do |name|
        #
        #     define_singleton_method("#{name}_has_attr") do |*argvs|
        #         # puts argvs
        #         # return 90
        #         # ItegrationVerb[name]
        #         ## 把 attr 保存到 list
        #         container_hash = get_itgt_var('itegration_compact_link_hash',{})
        #         container_hash[name.to_s] = container_hash[name.to_s] | argvs.map { |e| e.to_s }
        #         set_itgt_var('itegration_compact_link_hash',container_hash)
        #     end
        #
        #     define_singleton_method("#{name}_has_flag") do |*argvs|
        #         "itgt 标识"
        #         container_hash = get_itgt_var('itegration_compact_flag_hash',{})
        #         container_hash[name.to_s] ||= []
        #         container_hash[name.to_s] = container_hash[name.to_s] | argvs.map { |e| e.to_s }
        #         set_itgt_var('itegration_compact_flag_hash',container_hash)
        #     end
        #
        # end
    end

    def param(name,default)
        ## param_hash
        # itgt_param_hash = get_itgt_var('itgt_param_hash',{})
        # itgt_param_hash[name.to_s] = default
        # set_itgt_var('itgt_param_hash',itgt_param_hash)
        ## 生成实例方法
        self.class_exec do
            define_method(name) do
                # ItegrationVerb[name]
                itgt_param_hash = get_itgt_var('itgt_param_hash',{})
                if itgt_param_hash[name.to_s]
                    return itgt_param_hash[name.to_s]
                else
                    itgt_param_hash[name.to_s] = default
                    set_itgt_var('itgt_param_hash',itgt_param_hash)
                    return default
                end
            end

            define_method("#{name}=") do |value|
                # ItegrationVerb[name]
                itgt_param_hash = get_itgt_var('itgt_param_hash',{})
                itgt_param_hash[name.to_s] = value
                set_itgt_var('itgt_param_hash',itgt_param_hash)
                value
            end
        end
    end


end

## ItegrationVerb 代理
class ItegrationVerbAgent
    attr_reader :itgt
    def initialize(itgt)
        @itgt = itgt
    end

    def method_missing(method_id,*arguments,&block)
        # 是否也相应 active_#{name}_proc_run
        if @itgt.respond_to? "active_#{method_id}_proc_run"
            @itgt.send("active_#{method_id}_proc_run",*arguments,&block)
        else
            @itgt.send(method_id,*arguments,&block)
        end
    end
end

# $_implicit_curr_itgt_ = []

class ItegrationVerb
    extend ItegrationAttr
    attr_accessor :top_module
    attr_accessor :names_pool,:nickname,:pins_map
    attr_accessor :init_inst
    attr_accessor :inst_index


    def child_inst_itgt
        @child_inst_itgt ||=[]
    end


    def cal_inst_index(base=0)
        if @inst_index
            if base > @inst_index
                @inst_index = base
            end
        else
            @inst_index = base
        end

        child_inst_itgt.each do |e|
            e.cal_inst_index(@inst_index + 1)
        end

    end

    ## 关于 当前 itgt stack 操作
    def self.with_new_itgt(itgt,&block)
        $_implicit_curr_itgt_ << itgt
        rel = block.call
        $_implicit_curr_itgt_.pop
        return rel
    end

    def self.curr_itgt_push(itgt)
        $_implicit_curr_itgt_ << itgt
    end

    def self.curr_itgt_pop
        $_implicit_curr_itgt_.pop
    end

    ## 判断当前itgt class export flag 是否匹配参数

    def flag_match(attr)
        self.class.flag_match(attr)
    end

    def self.flag_match(attr)
        explort_flags = get_itgt_var('itegration_flag_collect')
        unless attr
            return true
        end

        if attr.empty?
            return true
        end

        unless explort_flags
            explort_flags = []
        end

        explort_flags = explort_flags.map{ |e| e.to_s }.sort
        attr = attr.map { |e| e.to_s }.sort

        if(explort_flags & attr) == attr
            return true
        else
            return false
        end
    end

    @@child = []

    def initialize(name_str=nil,pins_map={},top_module=nil)
        @top_module = top_module
        if name_str.to_s.strip.empty?
            @nickname = ""
        else
            @nickname =  "#{name_str.to_s.strip}_"
        end
        @pins_map = pins_map
        _names_pool_inst()
        # @itgt_links = ItgtLinks.new(self)
        ## 为child module 生成方法
        init_children_modules()
        # init_children_modules_post()
    end

    def init_children_modules
        blocks_hash = self.class.instance_variable_get("@_sdl_eval_blocks_hash_") || {}
        blocks_hash_post = self.class.instance_variable_get("@_sdl_eval_blocks_post_hash_") || {}
        dir_hash = self.class.instance_variable_get("@_sdl_eval_dir_hash_")

        blocks_hash = blocks_hash.merge blocks_hash_post

        blocks_hash.keys.each do |key|

            sdlm = SdlModule.new(name:self.class.to_s + "_#{@nickname}#{key}",out_sv_path:dir_hash[key])
            define_singleton_method(key) do
                sdlm
            end
        end
    end

    # def init_children_modules_post
    #     blocks_hash = self.class.instance_variable_get("@_sdl_eval_blocks_post_hash_")
    #     dir_hash = self.class.instance_variable_get("@_sdl_eval_dir_hash_")
    #     return unless blocks_hash
    #     blocks_hash.keys.each do |key|
    #
    #         sdlm = SdlModule.new(name:self.class.to_s + "_#{@nickname}#{key}",out_sv_path:dir_hash[key])
    #         define_singleton_method(key) do
    #             sdlm
    #         end
    #     end
    # end

    def gen_children_modules
        blocks_hash = self.class.instance_variable_get("@_sdl_eval_blocks_hash_") || {}
        blocks_hash_post = self.class.instance_variable_get("@_sdl_eval_blocks_post_hash_") || {}
        blocks_hash = blocks_hash.merge blocks_hash_post
        blocks_hash.keys.each do |key|
            self.send(key).gen_sv_module()
        end
    end

        # define_singleton_method(:inst) do
    def inst
        # 先生成子模块
        ## 执行 生成 sdl module
        inst_child_module()

        blocks = self.class.instance_variable_get("@_inst_blocks_")
        ItegrationVerb.curr_itgt_push(self)

        if blocks.length ==  1
            block = blocks[0]
            @top_module.instance_exec(self,&block.clone)
            ItegrationVerb.curr_itgt_pop
        elsif blocks.length >  1
            # block = Proc.new do
                blocks.each do |b|
                    @top_module.instance_exec(self,&b.clone)
                end
            # end
            ItegrationVerb.curr_itgt_pop
        else
            ItegrationVerb.curr_itgt_pop
            return
        end

        ## 执行 生成 sdl module
        inst_child_module_post()

        ## 执行top module techbench eval
        tb_inst()
        ## 执行测试向量
        techbench_vector()
        ## 执行 约束
        inst_constraints()
        ## 执行单元测试
        test_unit_inst()
    end

    def tb_inst
        # define_singleton_method(:tb_inst) do
        blocks = self.class.instance_variable_get("@_inst_tb_blocks_")
        return unless blocks
        ItegrationVerb.curr_itgt_push self

        if blocks.length ==  1
            block = blocks[0]
            @top_module.techbench.instance_exec(self,&block.clone)
        elsif blocks.length >  1
            # block = Proc.new do
                blocks.each do |b|
                    # b.call
                    @top_module.techbench.instance_exec(self,&b.clone)
                end
            # end
        else
            ;
        end
        ItegrationVerb.curr_itgt_pop
    end

    ## 测试用例 实例化
    def test_unit_inst

        blocks = self.class.instance_variable_get("@_inst_test_unit_blocks_")
        return unless blocks
        return if blocks.empty?
        ItegrationVerb.curr_itgt_push self

        return unless TopModule.sim
       
        blocks.each do |b|
            # @top_module.techbench.instance_exec(self,&b.clone)
            sdlm = TestUnitModule.new(name: b[0],out_sv_path: b[1])
            $_implicit_curr_itgt_.with_none_itgt do 
                sdlm.input - "from_up_pass"
                sdlm.output.logic - "to_down_pass"
            end
            sdlm.instance_exec(self,&b[2])

            if b[1] && File.exist?(b[1])
                sdlm.gen_sv_module
            else 
                sdlm.origin_sv = true 
            end
        end

        ItegrationVerb.curr_itgt_pop

    end

    def inst_child_module
        blocks_hash = self.class.instance_variable_get("@_sdl_eval_blocks_hash_")
        return unless blocks_hash
        ItegrationVerb.curr_itgt_push self
        $_implicit_curr_itgt_.with_none_itgt do 
            blocks_hash.keys.each do |key|
                sdlm = self.send(key)


                blocks = blocks_hash[key]
                if blocks.length ==  1
                    block = blocks[0]
                    sdlm.instance_exec(self,&block)
                elsif blocks.length >  1
                    # block = Proc.new do
                        blocks.each do |b|
                            # b.call
                            sdlm.instance_exec(self,&b)
                        end
                    # end
                else
                    ;
                end
            end
        end
        ItegrationVerb.curr_itgt_pop
    end

    def inst_child_module_post
        blocks_hash = self.class.instance_variable_get("@_sdl_eval_blocks_post_hash_")
        return unless blocks_hash
        ItegrationVerb.curr_itgt_push self
        $_implicit_curr_itgt_.with_none_itgt do
            blocks_hash.keys.each do |key|
                sdlm = self.send(key)
                # $_implicit_curr_itgt_ = self

                blocks = blocks_hash[key]
                if blocks.length ==  1
                    block = blocks[0]
                    sdlm.instance_exec(self,&block)
                elsif blocks.length >  1
                    # block = Proc.new do
                        blocks.each do |b|
                            # b.call
                            sdlm.instance_exec(self,&b)
                        end
                    # end
                else
                    next
                end
            end
        end
        ItegrationVerb.curr_itgt_pop
    end

    def self.inherited(subclass)
        unless @@child.include? subclass
            @@child << subclass
        end
    end

    # def self.[](key)
    #     @@_curr_all_itegration_ ||= {}
    #     @@_curr_all_itegration_[key.to_s]
    # end
    #
    # def self.[]=(key,value)
    #     @@_curr_all_itegration_ ||= {}
    #     @@_curr_all_itegration_[key.to_s] = value
    # end
    private
    def _names_pool_inst
        @names_pool = NameSPoolHash.new
        @names_pool.nickname = @nickname
        @names_pool.itgt = self
    end
    public
    def get_itgt_var(name,default=[],&block)
        unless instance_variable_get("@_#{name}_")
            if block_given?
                rel = block.call(default)
            else
                rel = default
            end
            instance_variable_set("@_#{name}_",rel)
            container = instance_variable_get("@_#{name}_")
        else
            container = instance_variable_get("@_#{name}_")
        end

        return container
    end

    def set_itgt_var(name,value)
        # rel = get_itgt_var(name)
        instance_variable_set("@_#{name}_",value)
        container = instance_variable_get("@_#{name}_")
    end

    public
    def check_same_method(name)
        if respond_to? name.to_s
            raise TdlError.new("Itegration can't Redefine method #{name}")
        end
    end

    public
    def link_eval
        @top_module.implicit_itgt_collect   ||= []
        #生成link 数组便是 当前 itgt引用
        container = self.class.get_itgt_var('itegration_link_collect')
        container.each do |e|
            container_attrs = self.class.get_itgt_var('itegration_link_hash')[e]
            flag_attrs = self.class.get_itgt_var('itegration_flag_hash',{})[e]
            mark = false
            ## 先从 top_module 显式加入的itgt搜索
            @top_module.itgt_collect.each do |i|
                explort_attrs = i.class.get_itgt_var('itegration_explort_collect')
                # explort_flags = i.class.get_itgt_var('itegration_flag_collect')
                if ((explort_attrs & container_attrs).sort == container_attrs.sort  &&  i.flag_match(flag_attrs))
                    mark = true
                    unless self.respond_to? e
                        define_singleton_method(e) do
                            ## 如果从其他模块调用则出发 dynac_active
                            ItegrationVerbAgent.new(i)
                        end
                        i.link_eval
                        i.child_inst_itgt << self
                    end
                    # cal_inst_index(i)
                    break
                end
            end
            if mark    ## 找到了 就处理下一个Link
                next
            else
                ## 处理 compact link
                compact_container = self.class.get_itgt_var('itegration_compact_link_collect',[])
                if compact_container.include? e
                    unless self.respond_to? e
                        define_singleton_method(e) do
                            nil
                        end
                    end
                    next
                end
            end
            ## 先从 已经加入的隐性itgt搜索
            @top_module.implicit_itgt_collect.each do |i|
                explort_attrs = i.class.get_itgt_var('itegration_explort_collect')
                if ((explort_attrs & container_attrs).sort == container_attrs.sort && i.flag_match(flag_attrs))
                    # puts "Itgt Good"
                    mark = true
                    unless self.respond_to? e
                        define_singleton_method(e) do
                            ## 如果从其他模块调用则出发 dynac_active
                            ItegrationVerbAgent.new(i)
                        end
                        i.link_eval
                        i.child_inst_itgt << self
                    end
                    break
                end
            end
            next if mark    ## 找到了 就处理下一个Link
            ## 如果没有找到 再从 ItegrationVerb children里面找到比加入
            @@child.each do |c|
                explort_attrs = c.get_itgt_var('itegration_explort_collect')
                # puts explort_attrs
                if ((explort_attrs & container_attrs).sort == container_attrs.sort && c.flag_match(flag_attrs))
                    # puts "Child Good"
                    isp = @top_module.add_itegration(c.to_s,nickname:'implicit',implicit:true)
                    @top_module.implicit_itgt_collect << isp
                    ## 如果是隐性添加，先不要加入pin_map
                    define_singleton_method(e) do
                        ItegrationVerbAgent.new(isp)
                    end
                    isp.link_eval
                    isp.child_inst_itgt << self
                    mark = true
                    break
                end
            end

            unless mark
                raise TdlError.new("<#{self}>没有找到符合Link 的上级 Itgt:\n    ATTR: #{container_attrs.inspect}\n    FLAG: #{flag_attrs.inspect}\n")
            end
        end
    end

    def implicit_link_eval
        @top_module.implicit_itgt_collect   ||= []
        #生成link 数组便是 当前 itgt引用
        container = self.class.get_itgt_var('itegration_link_collect')
        container.each do |e|
            container_attrs = self.class.get_itgt_var('itegration_link_hash')[e]
            mark = false
            ## 先从 已经加入的隐性itgt搜索
            @top_module.implicit_itgt_collect.each do |i|
                explort_attrs = i.class.get_itgt_var('itegration_explort_collect')
                if (explort_attrs & container_attrs).sort == container_attrs.sort
                    mark = true

                    define_singleton_method(e) do
                        ItegrationVerbAgent.new(i)
                    end
                    i.implicit_link_eval
                    break
                end
            end
            next if mark    ## 找到了 就处理下一个Link
            ##
            ## 如果没有找到 再从 ItegrationVerb children里面找到比加入
            @@child.each do |c|
                explort_attrs = c.get_itgt_var('itegration_explort_collect')
                if (explort_attrs & container_attrs).sort == container_attrs.sort
                    isp = @top_module.add_itegration(c.to_s,nickname:'implicit',implicit:true)
                    @top_module.implicit_itgt_collect << isp
                    ## 如果是隐性添加，先不要加入pin_map

                    define_singleton_method(e) do
                        ItegrationVerbAgent.new(isp)
                    end
                    mark = true
                    break
                end
            end

        end
    end

    ##
    def self.top_module_eval(&block)
        _inst_blocks_ = instance_variable_get("@_inst_blocks_")
        _inst_blocks_ ||= []
        _inst_blocks_ << block
        instance_variable_set("@_inst_blocks_",_inst_blocks_)
    end

    def self.top_module_techbench_eval(&block)
        _inst_tb_blocks_ = instance_variable_get("@_inst_tb_blocks_")
        _inst_tb_blocks_ ||= []
        _inst_tb_blocks_ << block
        instance_variable_set("@_inst_tb_blocks_",_inst_tb_blocks_)
    end

    ## 添加测试用例

    def self.def_test_unit(name,path,&block)
        _inst_test_unit_blocks_ = instance_variable_get("@_inst_test_unit_blocks_")
        _inst_test_unit_blocks_ ||= []
        _inst_test_unit_blocks_ << [name.to_s, path, block]
        instance_variable_set("@_inst_test_unit_blocks_",_inst_test_unit_blocks_)
    end

    ## 生成 itgt内的模块,
    def self.has_module(dir,*names)
        unless File.exist? dir
            Dir.mkdir dir
        end
        ## itgt 生成 sdl 模块
        names.each do |name|
            # unless container_hash[name.to_s]
            #     container_hash[name.to_s] = []
            # end
            self.define_singleton_method("#{name}_sdl_eval") do |&block|
                _sdl_eval_blocks_hash_ = instance_variable_get("@_sdl_eval_blocks_hash_")
                _sdl_eval_dir_hash_ = instance_variable_get("@_sdl_eval_dir_hash_")
                _sdl_eval_blocks_hash_ ||= {}
                _sdl_eval_dir_hash_ ||= {}

                if _sdl_eval_blocks_hash_[name]
                    _sdl_eval_blocks_hash_[name] << block
                    # _sdl_eval_blocks_hash_[name] << $_implicit_curr_itgt_.wrap_nont_itgt(&block)
                    # _sdl_eval_blocks_hash_[name] << lambda {|itgt| block.call }
                else
                    _sdl_eval_blocks_hash_[name] = [block]
                    # _sdl_eval_blocks_hash_[name] = [$_implicit_curr_itgt_.wrap_nont_itgt(&block)]
                    # _sdl_eval_blocks_hash_[name] == [ lambda {|itgt| block.call }]
                end

                _sdl_eval_dir_hash_[name] = dir if dir
                instance_variable_set("@_sdl_eval_dir_hash_",_sdl_eval_dir_hash_)
                instance_variable_set("@_sdl_eval_blocks_hash_",_sdl_eval_blocks_hash_)
            end
            ## 在 top_module 后再执行
            self.define_singleton_method("#{name}_sdl_post_eval") do |&block|
                $_implicit_curr_itgt_.with_none_itgt do 
                    _blocks_hash_ = instance_variable_get("@_sdl_eval_blocks_post_hash_")
                    _sdl_eval_dir_hash_ = instance_variable_get("@_sdl_eval_dir_hash_")
                    _blocks_hash_ ||= {}
                    _sdl_eval_dir_hash_ ||= {}

                    if _blocks_hash_[name]
                        _blocks_hash_[name] << block    #$_implicit_curr_itgt_.wrap_nont_itgt(&block)
                    else
                        _blocks_hash_[name] = [block]   #[$_implicit_curr_itgt_.wrap_nont_itgt(&block)]
                    end

                    _sdl_eval_dir_hash_[name] = dir if dir
                    instance_variable_set("@_sdl_eval_dir_hash_",_sdl_eval_dir_hash_)
                    instance_variable_set("@_sdl_eval_blocks_post_hash_",_blocks_hash_)
                end
            end
        end
    end

    def self.record_instance_var_block(name,default=[],&block)
        _inst_ccc_ = instance_variable_get("@_#{name}_")
        _inst_ccc_ ||= default
        if _inst_ccc_.is_a? Array
            _inst_ccc_ << block if block_given?
        elsif _inst_ccc_.is_a? Hash
            _inst_ccc_[name.to_s] = block if block_given?
        else
            _inst_ccc_ = block
        end
        instance_variable_set("@_#{name}_",_inst_ccc_)
    end

    def self.set_instance_var(name,value)
        _inst_ccc_ = instance_variable_get("@_#{name}_")
        # _inst_ccc_ ||= default
        _inst_ccc_ = value
        instance_variable_set("@_#{name}_",_inst_ccc_)
    end

    def self.get_instance_var(name)
        _inst_ccc_ = instance_variable_get("@_#{name}_")
    end

    ## 测试向量实现 作用于是 top_module
    def self.techbench_block(name,default_tb_argvs_hash={})
        hash = self.record_instance_var_block("techbench_name_hash",{})
        ## args hash
        argvs_hash = self.get_instance_var("techbench_argvs_hash") || {}
        # self.set_instance_var("techbench_argvs_hash",{}) unless argvs_hash
        argvs_hash[name.to_s] = default_tb_argvs_hash
        set_instance_var("techbench_argvs_hash",argvs_hash)
        ##需要激活的block
        self.define_singleton_method("#{name}_tb_eval") do |&block|
            ## 把 block 塞到数组中
            hash[name.to_s] = self.record_instance_var_block("techbench_#{name}_blocks",[],&block)
            self.set_instance_var("techbench_name_hash",hash)
            hash[name.to_s]
        end

        ## 生成实例方法
        self.class_exec do

            define_method(:active_techbench_vector) do |name,tb_argvs_hash={}|
                hash = get_itgt_var("active_techbench_vector",{})
                _default_tb_argvs_hash = self.class.get_instance_var("techbench_argvs_hash")[name.to_s] || {}
                hash[name.to_s] = _default_tb_argvs_hash.merge(tb_argvs_hash)
                set_itgt_var('active_techbench_vector',hash)
            end
        end

    end

    def techbench_vector
        ## 先获取需要激活的tb
        hash = get_itgt_var("active_techbench_vector",{})
        ## 从 class 获取 techbench_name_hash
        class_block_hash = self.class.get_instance_var('techbench_name_hash')
        ## 根据 需要激活的 tb name 激活 block
        ItegrationVerb.curr_itgt_push self
        hash.each do |key,value|
            blocks = class_block_hash[key.to_s]
            unless blocks
                raise TdlError.new("Itgt Class <#{self.class.to_s}> 没有定义 techbench <#{key}>")
            end

            tb_argvs_hash = value
            # $_implicit_curr_itgt_ = self

            if blocks.length ==  1
                block = blocks[0]
                ## 在top module 的上下文下激活blocks
                @top_module.instance_exec(self,tb_argvs_hash,&block.clone)
            elsif blocks.length >  1
                # block = Proc.new do
                    blocks.each do |b|
                        # b.call
                        ## 在top module 的上下文下激活blocks
                        @top_module.instance_exec(self,tb_argvs_hash,&b.clone)
                    end
                # end
            else
                next
            end

        end
        ItegrationVerb.curr_itgt_pop
    end

    ## 约束 block
    def self.constraints_block(&block)
        carray = self.record_instance_var_block("constraints_array",[])
        carray << block if block_given?
        self.set_instance_var("constraints_array",carray)
    end

    def inst_constraints()
        carray = self.class.get_instance_var("constraints_array")
        return unless carray
        # $_implicit_curr_itgt_ = self
        ItegrationVerb.curr_itgt_push self
        carray.each do |b|
            @top_module.constraint.instance_exec(self,&b.clone)
        end
        ItegrationVerb.curr_itgt_pop
    end

end


## 动态删除 silence_ block 
class ItegrationVerb

    def delete_silence(name)
        get_itgt_var('explort_silence_hash').delete(name.to_s)
    end 
end
