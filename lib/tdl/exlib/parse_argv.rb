require "optparse"

class Parser

    def self.parse(options)

        # args = Options.new("192.168.1.167",32896,"192.168.1.211",32896)

        hash = {next_cfg_addr:0x0400000,info:true}

        opt_parser = OptionParser.new do |opts|
            opts.banner = "Usage: <top_tdl_desgin>.rb [options]"

            opts.on("-s", "--sim", "design just for simulator") do |n|
                 hash[:sim] = true
            end

            opts.on("-g", "--gold_bitstream", "this is a gold bitstream for boot") do |n|
                hash[:gold] = true
            end

            opts.on("-n40000", "--gold_next_addr=0x0400000", "gold bitstream next configure address") do |n|
                hash[:next_cfg_addr] = n.to_i(16)
            end

            opts.on("-u", "--update_bitstream", "this is a update bitstream for boot") do |n|
                hash[:update] = true
            end

            opts.on("-c", "--no_info", "don't show run infomation of tdl") do |n|
                hash[:info] = false
            end

            opts.on("-h", "--help", "Prints this help") do
                puts opts
                exit
            end
        end
        opt_parser.parse(options)
        return hash
    end

end
