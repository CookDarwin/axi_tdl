# class TdlTestPoint
#     # @@name_collect = []
#     # @@inst_collect = []

#     # attr_reader :name,:descript,:target,:file,:line
#     # attr_accessor :filter_block
#     # def initialize(target: nil, name: 'test_point',descript: '',file: nil, line: nil)
#     #     @name = name.to_s 
#     #     if @@name_collect.include? @name 
#     #         raise TdlError.new "Cant redefine test point with name <#{@name}>"
#     #     end
#     #     @target = target
#     #     @descript = descript
#     #     @file = File.expand_path(file) if file 
#     #     @line = line

#     #     unless @target.respond_to? :belong_to_module
#     #         raise TdlError.new "Test point<#{@name}> is not respond to belong_to_module"
#     #     end

#     #     ## when test unit in topmodule or topmodule techbench
#     #     if  target.belong_to_module.is_a?(TopModule) || (TopModule.current && (target.belong_to_module == TopModule.current.techbench))
#     #         TdlTestPoint.define_singleton_method(name) { target }
#     #     end
     
#     #     TdlTestPoint.define_singleton_method(target.belong_to_module.module_name ) { target.belong_to_module }
#     #     target.belong_to_module.define_singleton_method(name) { target }
#     #     _self = self
#     #     target.define_singleton_method('tp_instance') { _self }

#     #     @@inst_collect << self
#     # end

#     def self.echo_list
#         # ml = ['  MODULE']
#         # nl = ['NAME']
#         # dl = ['DESCRIPT']
#         # fl = ['FILE']

#         # mll = 8
#         # nll = 4
#         # dll = 8
#         # @@inst_collect.each do |e|
#         #     unless e.target.belong_to_module.top_tb_ref?
#         #         next 
#         #     end
#         #     inst_cnt = e.target.belong_to_module.instance_variable_get("@instance_cnt")
#         #     if !inst_cnt || inst_cnt == 0
#         #         next
#         #     end
#         #     ml << e.target.belong_to_module.module_name
#         #     nl << e.name 
#         #     dl << e.descript
#         #     if e.file
#         #         fl << "#{e.file}:#{e.line}"
#         #     else
#         #         fl << 'Null'
#         #     end

#         #     mll = e.target.belong_to_module.module_name.size if e.target.belong_to_module.module_name.size > mll
#         #     nll = e.name.size if e.name.size > nll
#         #     dll = e.descript.size if e.descript.size > dll 
#         # end

#         # ccl = []
#         # ml.each_index do |index|
#         #     # if index != 0
#         #         ccl << "[#{sprintf("%3d",index)}]#{ml[index]} #{' '*(mll-ml[index].size)}| #{nl[index]} #{' '*(nll-nl[index].size)}| #{dl[index]} #{' '*(dll-dl[index].size)}| #{fl[index]}"
#         #     # else 
#         #     #     ccl << "#{ml[index]} #{' '*(mll-ml[index].size)}| #{nl[index]} #{' '*(nll-nl[index].size)}| #{dl[index]} #{' '*(dll-dl[index].size)}| #{fl[index]}"
#         #     # end
#         # end
#         # ccl.join("\n")

#         "TODO SOME"
#     end

#     # def self.inst_collect
#     #     @@inst_collect
#     # end

# end

module TdlSpace

    # class ExCreateTPSurge

    #     def initialize(target: nil, descript: '', file: nil, line: nil)
    #         @target = target
    #         @descript = descript
    #         @file = file 
    #         @line = line
    #     end

    #     def -(name)
    #         TdlTestPoint.new(target: @target, name: name, descript: @descript, file: @file, line: @line)
    #     end

    #     def method_missing(method,*args,&block)
    #         if method.to_s !~ /[a-z]\w+/
    #             raise TdlError.new "Test point name<#{method}> is illegal"
    #         end
    #         self - method
    #     end
    # end

    module ExCreateTP 

        # def create_tp(desc='',file=nil,line=nil)
        #     # TdlTestPoint.new(target: self, name: name, descript: desc, file: file, line: line)
        #     ExCreateTPSurge.new(target: self, descript: desc, file: file, line: line)
        # end

        ## 定义获取 信号的绝对路径
        def root_ref(&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                rels = path_refs(&block)
                if block_given?
                    sst = "block given"
                else
                    sst = "no block"
                end

                if rels.size == 1
                    rels[0]
                elsif rels.size == 0
                    raise TdlError.new "#{self} Cant find root ref {#{sst}}"
                else
                    raise TdlError.new "#{self} Find multi root refs {#{sst}} \n#{rels.join("\n")}\n"
                end
            end
        end
    end

end

class BaseElm
    include TdlSpace::ExCreateTP

    ## 获取信号的绝对路径
    def path_refs(&block)
        collects = []
        if @belong_to_module != TopModule.current.techbench
            @belong_to_module.parents_inst_tree do |tree|
                ll = ["$root"]
                rt = tree.reverse
                rt.each_index do |index|
                    if rt[index].respond_to? :module_name
                        ll << rt[index].module_name 
                    else 
                        ll << rt[index].inst_name
                    end
                end
                ll << @name
                new_name = ll.join('.').to_nq
                if block_given?
                    if yield(new_name)
                        collects << new_name
                    end 
                else
                    collects << new_name
                end
            end
        else
            collects = ["$root.#{@belong_to_module.module_name}.#{@name}".to_nq]
        end
        collects
    end
    
end

module TdlSpace
    class TdlBaseInterface
        include ExCreateTP

        ## 获取信号的绝对路径
        def path_refs(&block)
            collects = []
            if @belong_to_module != TopModule.current.techbench
                @belong_to_module.parents_inst_tree do |tree|
                    ll = ["$root"]
                    rt = tree.reverse
                    rt.each_index do |index|
                        if rt[index].respond_to? :module_name
                            ll << rt[index].module_name 
                        else 
                            ll << rt[index].inst_name
                        end
                    end
                    ll << inst_name
                    new_name = ll.join('.').to_nq
                    if block_given?
                        if yield(new_name)
                            collects << new_name
                        end 
                    else
                        collects << new_name
                    end
                end
            else
                collects = ["$root.#{@belong_to_module.module_name}.#{inst_name}".to_nq]
            end
            collects
        end
    end
end

module ClassHDL
    class EnumStruct
        include TdlSpace::ExCreateTP

        def root_ref(nstateq=true,&block)
            ClassHDL::AssignDefOpertor.with_rollback_opertors(:old) do 
                rels = path_refs(nstateq,&block)
                if rels.size == 1
                    rels[0]
                elsif rels.size == 0
                    raise TdlError.new "#{self} Cant find root ref"
                else
                    raise TdlError.new "#{self} Find multi root refs \n#{rels.join("\n")}\n"
                end
            end
        end

        ## 获取信号的绝对路径
        def path_refs(nstateq=true,&block)
            collects = []
            @belong_to_module.parents_inst_tree do |tree|
                ll = ["$root"]
                rt = tree.reverse
                rt.each_index do |index|
                    if rt[index].respond_to? :module_name
                        ll << rt[index].module_name 
                    else 
                        ll << rt[index].inst_name
                    end
                end
                if nstateq
                    ll << nstate
                else
                    ll << cstate
                end
                new_name = ll.join('.').to_nq
                if block_given?
                    if yield(new_name)
                        collects << new_name
                    end 
                else
                    collects << new_name
                end
            end
            collects
        end
    end
end

# class TdlTestPoint < TdlSpace::TdlTestPoint

# end

module ClassHDL 
    class StructVar
        include TdlSpace::ExCreateTP

        ## 获取信号的绝对路径
        def path_refs(&block)
            collects = []
            if @belong_to_module != TopModule.current.techbench
                @belong_to_module.parents_inst_tree do |tree|
                    ll = ["$root"]
                    rt = tree.reverse
                    rt.each_index do |index|
                        if rt[index].respond_to? :module_name
                            ll << rt[index].module_name 
                        else 
                            ll << rt[index].inst_name
                        end
                    end
                    ll << self.to_s.to_nq
                    new_name = ll.join('.').to_nq
                    if block_given?
                        if yield(new_name)
                            collects << new_name
                        end 
                    else
                        collects << new_name
                    end
                end
            else
                collects = ["$root.#{@belong_to_module.module_name}.#{self.to_s.to_nq}".to_nq]
            end
            collects
        end
    end
end
