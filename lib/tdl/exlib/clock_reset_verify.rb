
class Clock 

    def to_sim_source
        
        @belong_to_module.instance_exec(self) do |_self|
            Initial do 
                _self   <= 1.b0 
                initial_exec("#(100ns)")
                initial_exec("forever begin #(#{1000.0/_self.freqM/2}ns);#{_self} = ~#{_self};end")
            end
        end
    end
end

class Reset
    def to_sim_source(ns=100)
        
        @belong_to_module.instance_exec(self,ns) do |_self,ns|
            _xxx = (_self.active == 'low') ? 1.b0 : 1.b1 

            Initial do 
                _self   <= _xxx
                initial_exec("#(#{ns}ns)")
                _self   <= ~_self
            end
        end
    end
end