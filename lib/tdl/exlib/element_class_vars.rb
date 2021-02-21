

class ElementClassVars
    attr_reader :name,:class_name
    attr_accessor :inst_stack,:draw_stack,:draw_nc,:ports,:pre_inst,:pre_inst_stack

    attr_accessor :expression,:expression_def,:expression_record,:condition_expression

    def initialize(class_name)
        @name = class_name.to_s
        @class_name = class_name
        @id = 1
        @pre_inst = []
        @pre_inst_stack = []
        @inst_stack = []
        @draw_stack = []
        @draw_nc = []
        @ports = []
        @nc = nil
        @nc_id = 0

        @expression = []
        @expression_def = []
        @expression_record = []
        @condition_expression = []

        @expression_record.define_singleton_method("[]") do |key|
            if @expression_record.include? key
                @expression_record << key
                true
            else
                false
            end
        end
    end


    def nc
        unless @nc
            @nc = @class_name.nc_create

            # @nc.define_singleton_method(:signal) do
            #     nid = @nc_id
            #     @nc_id += 1
            #     nid
            # end
            @nc.instance_variable_set("@_id",0)

            class << @nc

                def signal
                    @_id ||= 0
                    nid = @_id
                    @_id += 1
                    nid.to_s
                end

                def peak_signal
                    @_id ||= 0
                    nid = @_id
                    nid.to_s
                end

            end
            @nc
        else
            @nc
        end
    end

    def id
        tmp = @id
        @id = @id + 1
        tmp
    end

end

class PackClassVars

    attr_accessor :module_stack,:before_dynamict_inst,:after_dynamict_inst,:special_stack,:tdl_msgs_stack

    def self.require_element
        @@nams_list = [Parameter] | SignalElm.subclass | InfElm.subclass

        attr_accessor(*@@nams_list.map { |e| e.to_s })
    end

    def initialize
        @@nams_list.each do |n|
            self.method("#{n}=").call(ElementClassVars.new(n))
        end

        @module_stack ||= []
        @before_dynamict_inst ||= []
        @after_dynamict_inst ||= []
        @special_stack ||= Hash.new
        @tdl_msgs_stack ||=[]

    end

    # def Logic
    #
    # end

end
