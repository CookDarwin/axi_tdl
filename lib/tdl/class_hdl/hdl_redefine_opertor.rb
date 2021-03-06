"""
Block{
    Block{
        OpertorChain
        OpertorChain
    }
    OpertorChain
    OpertorChain
}
"""

## 在/logic/redefine_operator.rb 里引用
module ClassHDL

    class GlobalVar
        @@curr_assign_block
        @@AssignDefOpertor_included_class = []

        def self.ass_defp_class
            @@AssignDefOpertor_included_class
        end
    end
end 
## 直接简单赋值 block语句
## ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new(["$error(\"#{argv_str}\")"]))

## 解析赋值 
## ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(ClassHDL::OpertorChain.new([x,x])
module ClassHDL
    OP_SYMBOLS = %w{+ - * / % > < >= <= == != << | & ^}

    def self.compact_op_ch(str)
        if str =~ /^(?<head>[\w\.\[\]\:]+\s*)(?<eq><?=\s*)\((?<body>.+)\)$/
            rel_str = $~[:head] + $~[:eq] + $~[:body]
        else 
            rel_str = str
        end
    end

    class OpertorChain
        attr_accessor :slaver,:tree,:instance_add_brackets
        attr_reader :belong_to_module
        def initialize(arg, belong_to_module)
            @tree = [] #[[inst0,symb0],[inst1,symb1],[other_chain,symb2],[other_chain,symb3]]
                       # self <symb0> inst0 <symb1> inst1 <symb2> ( other_chain ) <symb3> ( other_chain )
            if arg 
                @tree << arg 
            end  
            @belong_to_module = belong_to_module
            unless @belong_to_module
                raise TdlError.new("OpertorChain must have belong_to_module")
            end
        end

        def instance_inspect
            str = ["self belong_to_module:#{belong_to_module.module_name}"]
            index = 0
            @tree.each do |node|
                bl = "#{node[0].respond_to?(:belong_to_module) ? "belong_to_module:#{node[0].belong_to_module.module_name }" : '' }"
                str << "{{ tree[#{index}][1]node[1]SYMB{#{node[1].to_s}} tree[#{index}][0]node[0]#{node[0].to_s} #{node[0].class} #{bl}}}"
                index += 1
            end
            str.join(" ")
        end

        ClassHDL::OP_SYMBOLS.each do |os|
            
            define_method(os) do |b|
                # puts "OpertorChain #{os} #{b} #{b.class}"
                if b.is_a? OpertorChain
                    b.slaver = true
                end   
                # 计算生成新的OpertorChain 是 self 也需要抛弃
                self.slaver = true
                # return self
                new_op = nil
                AssignDefOpertor.with_rollback_opertors(:old) do 
                    if tree.size == 2 && tree.last[1].to_s == "<="
                        new_op =  OpertorChain.new(nil,belong_to_module) 
                        new_op.tree = new_op.tree + self.tree
                        new_op.tree.push [b,os] 
                    elsif  tree.size >= 2 && (!['*',"/","~"].include?(tree.last[1].to_s))
                        new_op =  brackets 
                        new_op.tree.push [b,os] 
                    else
                        new_op =  OpertorChain.new(nil,belong_to_module)  
                        new_op.tree = new_op.tree + self.tree
                        new_op.tree.push [b,os] 
                    end 
                end

                if ClassHDL::AssignDefOpertor.curr_assign_block
                    ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
                end

                new_op
            end

        end

        def simple_op?
            ## 判断是不是简单的运算 如 X > 0 ,x & y
            ##[[tmp0[0]], ["FALSE", "&"], [#<ClassHDL::OpertorChain:0x00005557046de088 @tree=[[a_inf.valid], ["1'b0", "|"]], @slaver=true>, "&"]]
            ##[[a_inf.valid], ["1'b0", "|"]
            rel = false
            AssignDefOpertor.with_rollback_opertors(:old) do 
                if tree.size==2 && tree[0].size==1 && !(tree[0][0].is_a?(ClassHDL::OpertorChain)) && !(tree[1][0].is_a?(ClassHDL::OpertorChain))
                    rel = true 
                else
                    rel = false 
                end
            end
            return rel
        end

        define_method("~") do 
            # self.nege = true
            # return self
            self.slaver = true
            bel = belong_to_module || ( @tree[0][0].respond_to?(:belong_to_module) && @tree[0][0].belong_to_module )
            new_op = OpertorChain.new(["~(#{self.instance(:assign, bel)})".to_nq])
        end

        def brackets
            self.slaver = true
            bel = ( @tree[0][0].respond_to?(:belong_to_module) && @tree[0][0].belong_to_module )
            new_op = OpertorChain.new(["(#{self.instance(:assign, belong_to_module || bel)})".to_nq], belong_to_module)
        end

        def clog2
            self.slaver = true
            bel = belong_to_module || ( @tree[0][0].respond_to?(:belong_to_module) && @tree[0][0].belong_to_module )
            new_op = OpertorChain.new(["$clog2(#{self.instance(:aasign, bel)})".to_nq],belong_to_module)
        end

        def self.define_op_flag(ruby_op,hdl_op)
            define_method(ruby_op) do |b|
                if b.is_a? OpertorChain
                    b.slaver = true
                    unless b.simple_op?
                        b.instance_add_brackets = true 
                    end
                end   
                # 计算生成新的OpertorChain 是 self 也需要抛弃
                self.slaver = true
                # return self
                new_op =  OpertorChain.new(nil, belong_to_module) 
                new_op.tree = new_op.tree + self.tree
                new_op.tree.push [b,hdl_op] 
    
                if ClassHDL::AssignDefOpertor.curr_assign_block
                    ClassHDL::AssignDefOpertor.curr_assign_block.opertor_chains.push(new_op)
                end
                new_op
            end
        end

        define_op_flag("or","||")
        define_op_flag("and","&&")


        def to_s 
            instance(type=:cond,belong_to_module || ( @tree[0][0].respond_to?(:belong_to_module) && @tree[0][0].belong_to_module ) )
        end

        def instance(type=:assign,block_belong_to_module=nil,show=nil)
            unless block_belong_to_module
                raise TdlError.new("OpertorChain must has block_belong_to_module")
            end
            AssignDefOpertor.with_rollback_opertors(:old) do 
                str = ''
                # both_symb_used = false
                cnt = 0
                @tree.each do |node|
                    if cnt==1
                        if node[1].to_s=="<="
                            if type==:always_ff || type==:cond
                                sb = " <= "
                            else 
                                sb = " = "
                            end 
                        else 

                            sb = "#{node[1].to_s}"
                        end
                    else
                        sb = "#{node[1].to_s}"
                    end

                    if cnt==1 && show 
                        puts "tree[1][1]<#{node[1]}> 使用 #{sb}"
                    end
                    
                    unless node[0].is_a? OpertorChain
                        ## 判断是不是属于 Var <= "String" 形式
                        if (@tree.length == 2) && node[0].instance_of?(String) && !@slaver
                            str += (sb + '"' + node[0].to_s + '"')
                            if show 
                                puts "tree 长度等于2; tree[#{cnt}][0] is string; op is not slaver"
                            end
                        elsif node[0].instance_of?(String)
                            # "如果是字符串 则原始输出"
                            str += (sb + '"' + node[0].to_s + '"')
                            if show 
                                puts "tree[#{cnt}][0] is string"
                            end
                        else 
                            # str += (sb + node[0].to_s)
                            if block_belong_to_module
                                if (node[0].respond_to?(:root_ref) && node[0].respond_to?(:belong_to_module) && node[0].belong_to_module && (node[0].belong_to_module != block_belong_to_module) && node[0].belong_to_module.top_tb_ref? )
                                    
                                    str += (sb + node[0].root_ref)

                                    if show 
                                        puts "tree[#{cnt}][0].belong_to_module<#{node[0].belong_to_module.module_name}> != block_belong_to_module<#{block_belong_to_module.module_name}>"
                                    end
                                    ## 反向添加到 TestUnitModule
                                    if block_belong_to_module.is_a?(TestUnitModule)
                                        block_belong_to_module.add_root_ref_ele(node[0])
                                        if show 
                                            puts "block_belong_to_module<#{block_belong_to_module.module_name}> is TestUnitModule"
                                        end
                                    end
                                else  
                                    str += (sb + node[0].to_s)
                                    if show
                                        mmm =  node[0].respond_to?(:belong_to_module) && node[0].belong_to_module.module_name
                                        puts "tree[#{cnt}][0]<#{node[0].class}>: ref_root<#{node[0].respond_to?(:root_ref).to_s}> belong_to_module<#{mmm}> block_belong_to_module<#{block_belong_to_module.module_name}> ...."
                                    end
                                end
                            elsif(node[0].respond_to?(:root_ref) && node[0].respond_to?(:belong_to_module) && node[0].belong_to_module && (node[0].belong_to_module != belong_to_module) && node[0].belong_to_module.top_tb_ref? )
                                # sb = "#{node[1].root_ref.to_s}"
                                str += (sb + node[0].root_ref)

                                if show 
                                    puts "tree[#{cnt}][0].belong_to_module<#{node[0].belong_to_module.module_name}> != op.belong_to_module<#{belong_to_module.module_name}>"
                                end

                                ## 反向添加到 TestUnitModule
                                if belong_to_module.is_a?(TestUnitModule)
                                    belong_to_module.add_root_ref_ele(node[0])
                                    if show 
                                        puts "tree[#{cnt}][0]: op.belong_to_module<#{belong_to_module.module_name}> is TestUnitModule"
                                    end
                                end
                            else
                                # sb = "#{node[1].to_s}"
                                str += (sb + node[0].to_s)
                                if show 
                                    puts "tree[#{cnt}][0]: op.belong_to_module<#{belong_to_module.module_name}> ..."
                                end
                            end
                        end
                    else 
                        node[0].slaver = true
                        # puts "--------"
                        # p node[0].tree
                        # puts "========"
                        # if node[0].tree.length>2 && ["&","|","<",">"].include?(node[0].tree[1][1])

                        # else
                    
                        if sb =~/(\||&){2,2}/
                            str += " #{sb}#{node[0].instance(:slaver,block_belong_to_module || belong_to_module).to_s}"
                        else
                            str += "#{sb}(#{node[0].instance(:slaver,block_belong_to_module || belong_to_module).to_s})"
                        end
                        
                        if show 
                            puts "tree[#{cnt}][0] is op, block_belong_to_module<#{block_belong_to_module.to_s}> op.belong_to_module<#{belong_to_module.to_s}>"
                        end

                    end
                    cnt += 1
                end

                ## 修饰

                # if nege 
                #     str = "~(#{str})"
                # else
                #     str
                # end
                if instance_add_brackets 
                    "(#{str})"
                else 
                    str
                end
            end
        end
    end
end

module ClassHDL

    module AssignDefOpertor
        @@included_class = []
        @@curr_assign_block = HDLAssignBlock.new(true) ##HDLAssignBlock ##HDLAlwaysCombBlock
        # @@curr_assign_block = nil
        @@curr_assign_block_stack = [HDLAssignBlock.new(true) ]
        # @@curr_assign_block_stack = []
        @@curr_opertor_stack = [:old]

        def self.curr_opertor_stack
            @@curr_opertor_stack
        end

        def self.curr_assign_block
            @@curr_assign_block
        end

        def self.curr_assign_block=(b)
            unless b  
                raise TdlError.new('Assign Block cant be nil')
            end
            @@curr_assign_block = b
        end

        def self.curr_assign_block_stack
            @@curr_assign_block_stack
        end

        def self.with_new_assign_block(na,&block)
            unless na  
                raise TdlError.new('Assign Block cant be nil')
            end
            @@curr_assign_block = na 
            @@curr_assign_block_stack.push(na)
            rels = yield(na)
             
            @@curr_assign_block_stack.pop 
            @@curr_assign_block = @@curr_assign_block_stack.last
            rels
        end

        # OP_SYMBOLS = %w{+ - * / % > < >= <= == != << | &}
        OP_SYMBOLS = ClassHDL::OP_SYMBOLS

        def self.included(mod)
            @@included_class.push mod
            mod.extend self
            init_op_methods(mod)
        end

        def self.init_op_methods(aclass)

            # if aclass.methods.include? :inst
            #     class_inst = aclass.nc_create
            # else
            #     class_inst = aclass.new
            # end
    
            aclass.class_eval do

                def operation_tow(symb,b)
                    # puts "aclass #{symb} #{b.class}"
                    if b.is_a? OpertorChain
                        b.slaver = true 
                    end
                    ## 当 进行 X < Y 等运算时OpertorChain 需要获取 assign block的 belong_to_module
                    if @@curr_assign_block 
                        bblm = @@curr_assign_block.belong_to_module
                    elsif self.respond_to?(:belong_to_module)
                        bblm = self.belong_to_module
                    elsif b.respond_to?(:belong_to_module)
                        bblm = b.belong_to_module
                        
                    else
                        bblm = nil 
                    end

                    new_op = OpertorChain.new(nil, bblm) 
                    new_op.tree.push([self])
                    new_op.tree.push([b,symb])
                    if @@curr_assign_block
                        @@curr_assign_block.opertor_chains.push(new_op)
                    else 
                        raise TdlError.new("operation_tow[#{symb}] <#{b}> Error: curr_assign_block is nil ")
                    end
                    return new_op
                end

    
                ClassHDL::OP_SYMBOLS.each do |symb|
                    # if class_inst.respond_to?(symb)
                    if self.instance_methods.include?(symb.to_sym)
                        alias_method "_old_#{symb}__",symb
                    else
                        define_method("_old_#{symb}__") do |b|
                            operation_tow(symb,b)
                        end
                    end
    
                    ## define new
    
                    define_method("_new_#{symb}__") do |b|
                        operation_tow(symb,b)
                    end
                end

                ## 定义片选
                def new_slice_cc(*a)
                    if a.size == 1
                        if a[0].is_a? Range 
                            "#{self}[#{a[0].first}:#{a[1].last}]".to_nq
                        else 
                            "#{self}[#{a[0]}]".to_nq
                        end
                    else 
                        "#{self}[#{a[0]}:#{a[1]}]".to_nq
                    end
                end

                if self.instance_methods.include?("[]".to_sym)
                    alias_method "_old_slice_","[]"
                else 
                    alias_method "_old_slice_","new_slice_cc"
                end
            end
        end

        def self.use_new_yield_opertors
            # NqString.class_exec do
            #     define_method("+") do |a|
            #         "+++++"
            #     end 
            # end
            @@included_class.each do |oc|
                oc.class_eval do
                    ClassHDL::OP_SYMBOLS.each do |symb|
                        # if symb.eql? "<="
                        #     alias_method symb,:_assign_small_and_eq
                        #     # define_method(symb,instance_method(:_assign_small_and_eq))
                        # else
                        #     alias_method symb,"_new_#{symb}__"
                        #     # define_method(symb,instance_method("_new_#{symb}__"))
                        # end
                        alias_method symb,"_new_#{symb}__"
                        # define_method(symb,instance_method("_new_#{symb}__"))
                        ## 测试用
                        # define_method(symb) do |a|
                        #     "+++++++"
                        # end

                    end
                end
            end
        end

        def self.use_old_cond_opertors
            ClassHDL::OP_SYMBOLS.each do |symb|
                @@included_class.each do |oc|
                    oc.class_eval do
                        alias_method symb,"_old_#{symb}__"
                        # define_method(symb,instance_method("_old_#{symb}__"))
                    end
                end
            end
        end

        def self.with_rollback_opertors(use_op,&block)
           
            case(use_op)
            when :new
                rels = with_new_opertor(&block)
            when :old
                rels = with_normal_opertor(&block)
            else 

            end

            case(@@curr_opertor_stack.last)
            when :new
                use_new_yield_opertors
            when :old
                use_old_cond_opertors
            else
                use_old_cond_opertors
            end
            
            rels
        end

        def self.with_new_opertor(&block)
            use_new_yield_opertors
            @@curr_opertor_stack.push :new
            rels = yield
            @@curr_opertor_stack.pop
            rels 
        end

        def self.with_normal_opertor(&block)
            use_old_cond_opertors
            @@curr_opertor_stack.push :old
            rels = yield
            @@curr_opertor_stack.pop
            rels
        end

        ## 类方法

    end
end

class SdlModule 
    def rubyOP(&block)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old,&block )
    end
end

class String
    include ClassHDL::AssignDefOpertor

end

class NqString
    include ClassHDL::AssignDefOpertor

    def [](a,b=nil)
        if a.is_a? ClassHDL::OpertorChain
            a.slaver = true
            arel = a.instance(:slaver)
        else 
            arel = a 
        end

        if b.is_a? ClassHDL::OpertorChain
            b.slaver = true
            brel = b.instance(:slaver)
        else 
            brel = b
        end

        unless b 
            if a.is_a? Range
                af = a.first
                al = a.last
                return "#{self}[#{af}:#{al}]".to_nq
            end 

            
            return "#{self}[#{arel}]".to_nq
        else 
            return "#{self}[#{arel}:#{brel}]".to_nq
        end
    end
end


class BaseElm
    ## 重覆盖掉
    def signal(index=nil)
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            with_new_align(0) do
                unless index
                    NqString.new(@name.to_s)
                else
                    unless index.is_a? String
                        NqString.new("#{@name.to_s}[#{align_signal(index)}]")
                    else
                        NqString.new("#{@name.to_s}[#{index.strip}]")
                    end
                end
            end
        end
    end

    private 
        ## ArrayChain 相关
        def self.define_arraychain_tail_method(name,width=1,rv=false,&block)
            self.define_method(name) do 
                ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                    if @dimension.empty?
                        NqString.new(signal.concat ".#{name}") 
                    else 
                        @_array_chain_hash_ ||= {}
                        unless @_array_chain_hash_[name.to_s]
                            if width.is_a? Proc 
                                r_width = width.call(self)
                            else 
                                r_width = width
                            end
                            rel = generate_inf_to_signals(name.to_s,width=r_width,rv=rv)
                            
                            @_array_chain_hash_[name.to_s] = rel
                        end
                        TdlSpace::ArrayChain.create(obj: @_array_chain_hash_[name.to_s], lchain:[], belong_to_module: self.belong_to_module)
                    end
                end
            end
        end

end

class InfElm
    ## 重覆盖掉
    def signal(index=nil)       #array interface
        # large_name_len("")
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
            with_new_align(0) do
                if @dimension.any? && index
                    if index.is_a? String
                        sq = "[#{index}]"
                        NqString.new("#{@name}#{sq}")
                        # NqString.new("#{@name}")
                    else
                        NqString.new("#{@name}[#{align_signal(index)}]")
                    end
                else
                    NqString.new("#{@name}")
                end
            end
        end
    end
end

class SignalElm
    define_method("!") do # 定义取反
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            NqString.new("!#{signal}")
        end
    end

    define_method("~") do # 定义取反
        ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
            NqString.new("~#{signal}")
        end
    end
end

module TdlSpace
    class ArrayChain
        def [](a,b=false)
            if a.is_a? Range
                b = a.last 
                a = a.first
            end 

            if a.is_a? ClassHDL::OpertorChain
                a.slaver = true
            end
    
            if b.is_a? ClassHDL::OpertorChain
                b.slaver = true
            end

            if @end_slice
                raise TdlError.new("数组下标已经被用片选[#{@end_slice[0]},#{@end_slice[1]}]终结")
            end
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                unless b 
                    ArrayChain.create(obj: obj,lchain: chain+[a],belong_to_module: belong_to_module)
                else 
                    @end_slice = [a,b]
                    self
                end
            end
        end

        def to_s
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
                str = ""
                xstr = false
                chain.each do |e|
                    unless e.is_a? ArrayChainSignalMethod
                        str += "[#{e.to_s}]"
                    else 
                        if (e.name.to_s == "vld_rdy" || e.name.to_s == "vld_rdy_last") && ( obj.is_a?(AxiStream) || obj.is_a?(DataInf_C) )
                            xstr = obj.public_send("array_chain_#{e.name.to_s}_inst",obj.to_s + chain[0, chain.size-1].map{|x| "[#{x}]"}.join(''))                            
                        else 
                            str += ".#{e.name.to_s}"
                        end
                    end
                end
                if @end_slice
                    str += "[#{@end_slice[0]}:#{@end_slice[1]}]"
                end

                xstr || "#{obj.to_s}#{str}"

            end
        end

        def ~
            ArrayChain.create(obj: "~#{self.to_s}", belong_to_module: belong_to_module)
        end
    end 
end

class Logic
    include ClassHDL::AssignDefOpertor
end

class Clock
    include ClassHDL::AssignDefOpertor
end

class Reset
    include ClassHDL::AssignDefOpertor
end

class Numeric
    include ClassHDL::AssignDefOpertor
end

class Integer
    include ClassHDL::AssignDefOpertor
end

module TdlSpace
    module DefOpertor

        OP_SYMBOLS = %w{+ - * / % > < >= <= == != << | &}


        OP_SYMBOLS.each do |e|
            define_method(e) do |b|
                if b.is_a? Proc
                    ll = lambda { ("(".concat(self.to_s).concat(" #{e} #{b.call})")).to_nq }
                    ll
                else
                    ("(".concat(self.to_s).concat(" #{e} #{b.to_s})").to_nq)
                end
            end
        end

    end
end

module TdlSpace
    class ArrayChain
        include TdlSpace::DefOpertor
        include ClassHDL::AssignDefOpertor
    end 
end

module ClassHDL
    class StructVar < AxiTdl::SdlModuleActiveBaseElm
        include ClassHDL::AssignDefOpertor
    end 
end

# ele_array = ([Parameter] | SignalElm.subclass | InfElm.subclass | CLKInfElm.subclass | [MailBox,BfmStream])

# ele_array.each do |e|
#     if e.instance_methods.include? :to_s
#         e.class_eval do 
#             alias_method "_old_to_s",:to_s
#             define_method(:new_to_s) do |*args|
#                 ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do
#                     send("_old_to_s",*args)
#                 end
#             end
#             alias_method :to_s,:new_to_s
#         end
#     end 
# end

