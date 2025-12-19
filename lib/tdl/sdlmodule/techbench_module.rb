class TechBenchModule < SdlModule
    @@all_sub_tb = []
    def initialize(name:"tdlmodule",out_sv_path:nil,&block)
        @@all_sub_tb << self
        super(name:name,out_sv_path:out_sv_path,&block)
    end

    def self.gen_sv_module
        @@all_sub_tb.each do |e|
            e.gen_sv_module
        end
    end

end
