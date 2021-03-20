
module AxiTdl
    class EthernetStreamDefAtom

        def initialize(belong_to_module: nil, stream: nil, start: 0, length: 32)
            @belong_to_module = belong_to_module
            @stream = stream
            @start = start
            @length = length
        end

        def -(str)
            @stream.x_all_bits_slice(name: str.to_s ,start: @start, length: @length)
        end
    end
end

class AxiStream

    ## 转到 网络流
    def to_eth(esize=8) # SIZE:8 ,64, 32
        @__ethernet_type__ = esize
    end

    ## 截取流数据段
    def all_bits_slice(start: 8*4,length:32)
        return AxiTdl::EthernetStreamDefAtom.new(belong_to_module: @belong_to_module, stream: self, start: start, length: length)
    end

    def x_all_bits_slice(name: "slice_#{globle_random_name_flag()}", start: 8*4,length:32)
        raise TdlError.new("#{name} is not ethernet stream, before used it must be call to_eth") unless @__ethernet_type__
        # @belong_to_module.logic[length]     - name
        @belong_to_module.instance_exec(self,name,start,length,@__ethernet_type__) do |_targget_axis, _name, _start, _length, _ethernet_type|
            logic[_length]     - _name
            _end = _start + _length -1

            ## 如果选的区域在一个Clock里面
            if _start / _ethernet_type == (_end) / _ethernet_type
                _target_cnt = _start/_ethernet_type

                always_ff(posedge: _targget_axis.aclk, negedge: _targget_axis.aresetn) do 
                    IF ~_targget_axis.aresetn do 
                        signal(_name)   <= 0.A 
                    end
                    ELSE do 
                        IF _targget_axis.vld_rdy do 
                            IF (_targget_axis.axis_tcnt[15,0] == "16'd#{_target_cnt}".to_nq) do
                                signal(_name) <= _targget_axis.axis_tdata[rubyOP{_ethernet_type - _start%_ethernet_type - 1}, rubyOP{_ethernet_type - _end%_ethernet_type - 1}, ]
                            end 
                            ELSE do 
                                signal(_name) <= signal(_name)
                            end
                        end
                        ELSE do 
                            signal(_name)   <= signal(_name)
                        end
                    end
                end
            end

            ## 如果夸Clock
            if _start / _ethernet_type != (_end) / _ethernet_type
                _slice_range = ( (_start / _ethernet_type)..(_end) / _ethernet_type ).to_a

                always_ff(posedge: _targget_axis.aclk, negedge: _targget_axis.aresetn) do 
                    IF ~_targget_axis.aresetn do 
                        signal(_name)   <= 0.A 
                    end
                    ELSE do 
                        IF _targget_axis.vld_rdy do 
                            _slice_range.each do |e|
                                IF (_targget_axis.axis_tcnt[15,0] == "16'd#{e}".to_nq) do
                                    ##第一个
                                    if ClassHDL::AssignDefOpertor.with_rollback_opertors(:old,&(proc { e == _slice_range.first}) )  
                                        signal(_name)[rubyOP{_length-1}, rubyOP{_length - (_ethernet_type - _start%_ethernet_type)}] <= _targget_axis.axis_tdata[rubyOP{_ethernet_type - _start%_ethernet_type-1}, 0]
                                    ## 最后一个
                                    elsif ClassHDL::AssignDefOpertor.with_rollback_opertors(:old,&(proc { e == _slice_range.last}) )  
                                        signal(_name)[rubyOP{_end%_ethernet_type},0] <= _targget_axis.axis_tdata[rubyOP{_ethernet_type-1}, rubyOP{_ethernet_type-_end%_ethernet_type-1}]
                                    else 
                                        signal(_name)[rubyOP{(_end - e*_ethernet_type)}, rubyOP{(_end - e*_ethernet_type - _ethernet_type+1)}] <= _targget_axis.axis_tdata
                                    end
                                end
                            end
                        end
                        ELSE do 
                            signal(_name)   <= signal(_name)
                        end
                    end
                end

            end
        end
        @belong_to_module.signal(name)
    end
end
