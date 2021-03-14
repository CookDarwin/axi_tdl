module ClassHDL

    class ClassEdge
        attr_accessor :origin
        def initialize(sdlm)
            @sdlm = sdlm
        end

        def to_s 
            @origin.to_s 
        end

        def method_missing(method,*args,&block)
            # unless @sdlm.respond_to? method
            #     raise TdlError.new("edge si")

            if @sdlm.respond_to? method
                @origin = @sdlm.public_send(method)
            else 
                @origin ||= method
            end

            return self
        end
    end

    class ClassPosedge < ClassEdge
    end

    class ClassNegedge < ClassEdge
    end


    class HDLAlwaysFFBlock 
        attr_accessor :opertor_chains,:posedges,:negedges

        def initialize
            @opertor_chains = []
            @posedges = []
            @negedges = []
        end

        def edge_instance(flag='posedge',edges=[])
            unless edges.is_a? Array
                es = [edges]
            else 
                es = edges 
            end
            es.compact!
            return es.map{|e| "#{flag} #{e.to_s}"}
        end

        def instance
            str = []

            pose_str = edge_instance('posedge',@posedges)
            nege_str = edge_instance('negedge',@negedges)
            pose_str.concat nege_str

            str.push "always_ff@(#{pose_str.join(",")}) begin "
            opertor_chains.each do |op|
                unless op.is_a? OpertorChain
                    str.push op.instance(:always_ff).gsub(/^./){ |m| "    #{m}"}
                else 
                    unless op.slaver
                        rel_str = ClassHDL.compact_op_ch(op.instance(:always_ff))
                        str.push "    #{rel_str};"
                    end
                end
                
            end
            str.push "end\n"
            str.join("\n")
        end
    end

    def self.AlwaysFF(sdl_m: nil,posedge: [],negedge: [],&block)
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAlwaysFFBlock.new) do |ab|
            ab.posedges = posedge
            ab.negedges = negedge

            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do
                sdl_m.Logic_draw.push ab.instance
            end
        end
    end

    ## 添加测试用always 

    class HDLAlwaysSIMBlock < HDLAlwaysFFBlock

        def instance
            str = []

            pose_str = edge_instance('posedge',@posedges)
            nege_str = edge_instance('negedge',@negedges)
            pose_str.concat nege_str

            str.push "always@(#{pose_str.join(",")}) begin "
            opertor_chains.each do |op|
                unless op.is_a? OpertorChain
                    str.push op.instance(:assign).gsub(/^./){ |m| "    #{m}"}
                else 
                    unless op.slaver
                        rel_str = ClassHDL.compact_op_ch(op.instance(:assign))
                        str.push "    #{rel_str};"
                    end
                end
                
            end
            str.push "end\n"
            str.join("\n")
        end
    end

    def self.AlwaysSIM(sdl_m: nil,posedge: [],negedge: [],&block)
        ClassHDL::AssignDefOpertor.with_new_assign_block(ClassHDL::HDLAlwaysSIMBlock.new) do |ab|
            ab.posedges = posedge
            ab.negedges = negedge

            AssignDefOpertor.with_rollback_opertors(:new,&block)
            # return ClassHDL::AssignDefOpertor.curr_assign_block
            AssignDefOpertor.with_rollback_opertors(:old) do
                sdl_m.Logic_draw.push ab.instance
            end
        end
    end
end

class SdlModule

    def posedge(origin=nil)
        rel = ClassHDL::ClassPosedge.new(self)
        rel.origin = origin
        return rel
    end

    def negedge(origin=nil)
        rel = ClassHDL::ClassNegedge.new(self)
        rel.origin = origin
        return rel
    end

    def Always(posedge: nil,negedge: nil,&block)
        ClassHDL::AlwaysFF(sdl_m: self,posedge: posedge,negedge: negedge,&block)
    end

    def Always_ff(posedge: nil,negedge: nil,&block)
        ClassHDL::AlwaysFF(sdl_m: self,posedge: posedge,negedge: negedge,&block)
    end

    def always_ff(*args,&block)
        if args[0].is_a? Hash 
            return Always(**args[0],&block)
        end 
        posedge_list = []
        negedge_list = [] 

        args.each do |e|
            if e.is_a? ClassHDL::ClassPosedge
                posedge_list << e 
            elsif e.is_a? ClassHDL::ClassNegedge
                negedge_list << e 
            end
        end

        ClassHDL::AlwaysFF(sdl_m: self,posedge: posedge_list,negedge: negedge_list,&block)
    end

    def always_sim(posedge: nil,negedge: nil,&block)
        ClassHDL::AlwaysSIM(sdl_m: self,posedge: posedge,negedge: negedge,&block)
    end
end