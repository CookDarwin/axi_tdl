
class ConstraintsVerb

    def initialize
        @package_pin_and_IOSTANDARD ||= []
        @clock_xds ||=[]
        @ex_constraints = ""
        @hash_const ||= Hash.new
        @hash_bitstream_const ||= Hash.new
        @pins_used ||=[]
    end

    def add_property(port_name,pin_name,iostandard,pulltype=nil,drive=nil)
        if pin_name.respond_to?("empty?") && pin_name.empty?
            pin_name = ""
        end

        if iostandard.respond_to?("empty?") && iostandard.empty?
            iostandard = ""
        end

        if pin_name.empty? && iostandard.empty?
            return
        end

        @clock_xds << port_name if (port_name.is_a? Clock)

        raise TdlError.new("\nConstraints port_name[#{port_name.to_s}] is'nt a SignalElm\n" ) unless port_name.is_a? SignalElm
        unless port_name.respond_to?(:dsize) && port_name.dsize != 1
            # raise TdlError.new("\nConstraints pin_name is a Array\n" ) if pin_name.is_a? Array
            # raise TdlError.new("\nConstraints iostandard is a Array\n" ) if iostandard.is_a? Array
            # @@clock_xds << port_name if (port_name.is_a? Clock) && (port_name.freqM.is_a? Numeric)
            pin_name = pin_name[0] if pin_name.is_a? Array
            @package_pin_and_IOSTANDARD << [port_name.signal,pin_name.to_s.upcase,iostandard.to_s.upcase,pulltype,drive.to_s]
            if @pins_used.include? pin_name.to_s.upcase
                raise TdlError.new("\nConstraints: PORT[#{port_name.signal}]@PIN[#{pin_name.to_s.upcase}] is fault,because #{pin_name.to_s.upcase} has be used\n")
            end
            @pins_used << pin_name.to_s.upcase
        else
            iostandard = ([iostandard] * pin_name.size ) unless iostandard.is_a? Array
            pulltype = ([pulltype] * pin_name.size ) unless pulltype.is_a? Array
            drive = ([drive] * pin_name.size ) unless drive.is_a? Array

            pin_name = ((pin_name.is_a?(Array) && pin_name) || [pin_name] )
            pin_name.each_index do |index|
                @package_pin_and_IOSTANDARD << [port_name[index],pin_name[index].to_s.upcase,iostandard[index].to_s.upcase,pulltype[index].to_s,drive[index].to_s]

                if @pins_used.include?  pin_name[index].to_s.upcase
                    raise TdlError.new("\nConstraints: PORT[#{port_name[index]}]@PIN[#{ pin_name[index].to_s.upcase}] is fault,because #{ pin_name[index].to_s.upcase} has be used\n")
                end
                @pins_used << pin_name[index].to_s.upcase
            end
        end
    end

    def pinProperties
        cstr = self.clockProperties
        head_str = "##-------------------------- PIN SET ---------------------------------- ##\n"
        end_str  = "##========================== PIN SET ================================== ##\n"
        pstr = @package_pin_and_IOSTANDARD.map do |ar|
            if ar[0] =~ /\[.*\]$/
                qstr = "{#{ar[0]}}"
            else
                qstr = ar[0]
            end
            unless ar[1].empty?
                str1 = "set_property PACKAGE_PIN #{ar[1]} [get_ports #{qstr}]\n"
            else
                str1 = "# #{ar[0]} dont have any PIN to be assigned\n"
            end

            if  ar[2].empty? || ar[2].to_s.empty?
                str2 = "# #{ar[0]} dont have any IOSTANDARD to be assigned\n"
            else
                str2 = "set_property IOSTANDARD #{ar[2]} [get_ports #{qstr}]\n"
            end

            if ar[3]  && !ar[3].empty?  # PULLUP PULLDOWN
                str_pullup = "set_property #{ar[3].upcase} true [get_ports #{qstr}]\n"
            else
                str_pullup = ""
            end

            if ar[4] && !ar[4].empty?
                str_drive = "set_property DRIVE #{ar[4]} [get_ports #{qstr}]\n"
            else
                str_drive = ""
            end

            str1 + str2 + str_pullup + str_drive

        end.join("")

        cstr + head_str + pstr + end_str
    end

    def xds
        pinProperties() + constProperties()
    end

    def clockProperties
        @@system_jitter ||= 0.1
        head_str = "##-------------------------- CLOCK SET ---------------------------------- ##\nset_system_jitter #{@@system_jitter} \n"
        end_str  = "##========================== CLOCK SET ================================== ##\n"
        str = @clock_xds.map do |c|
            prie = ((1000.0)/c.freqM).round(3)
            half_prie = ((500.0)/c.freqM).round(3)
            if c.dsize == 1
                "create_clock -period #{prie} -name #{c.signal} -waveform {0.000 #{half_prie}} [get_ports #{c.signal}]\n# set_input_jitter [get_clocks -of_objects [get_ports #{c.signal}]] #{c.jitter}\n"
            else
                sub_str = ''
                c.dsize.times do |xi|
                    sub_str += "create_clock -period #{prie} -name #{c.name}_#{xi} -waveform {0.000 #{half_prie}} [get_ports #{c.signal(xi)}]\n# set_input_jitter [get_clocks -of_objects [get_ports #{c.signal(xi)}]] #{c.jitter}\n"
                end
                sub_str
            end
        end.join("")
        head_str + str + end_str
    end

    def constProperties
"
## -------------------------- FALSE PATH SET ---------------------------------- ##
# set_false_path -from [get_pins -hier -regexp .*cross_clk.*ltc.*] -to [all_registers]
set_max_delay -from [get_pins -hier -regexp .*cross_clk.*ltc.*] -to [all_registers] 20.00
## set_false_path -from [get_pins -hierarchical \"*cross_clk*\"] -to [all_registers]
# set_false_path -from [all_registers] -to [get_pins -hier -regexp .*cross_clk.*ltc.*]
set_max_delay -from [all_registers] -to [get_pins -hier -regexp .*cross_clk.*ltc.*] 20.00
## set_false_path -from [all_registers] -to [get_pins -hierarchical \"*cross_clk*\"]

# set_false_path -from [get_pins -hier -regexp .*xilinx_reset_sync.*reset_sync.*] -to [all_registers]
set_max_delay -from [get_pins -hier -regexp .*xilinx_reset_sync.*reset_sync.*] -to [all_registers] 40.000
## set_false_path -from [get_pins -hierarchical \"*xilinx_reset_sync*reset_sync*\"] -to [all_registers]
#{@hash_const.map{|key,value| value}.join("")}
## ========================== FALSE PATH SET =================================== ##
## -------------------------- EX SET ---------------------------------- ##
#{@ex_constraints}
## ========================== EX SET =================================== ##
## -------------------------- BITSTREAM SET ---------------------------------- ##
#{@hash_bitstream_const.map{|key,value| value}.join("")}
## ========================== BITSTREAM SET =================================== ##
"
    end

    def add_const(*strs)
        strs.each do |str|
            @ex_constraints  += (str+"\n")
        end
    end

    def add(*names)
        names.each do |e|
            sadd(e)
        end
    end


    private

    def sadd(name)
        case(name.to_s.downcase)
        when "lite_cfg"
            self.add_lite_cfg
        when "video"
            self.add_video_const
        when "fifo"
            self.add_fifo_const
        when "xilinx_fifo"
            self.add_xilinx_fifo_const
        when "vdma"
            self.add_axi4_convert_const
            self.add_fifo_const
        when "hdmi_in"
            self.add_hdmi_in
        end
    end

    def self.define_const(name,&block)
        # self.define_singleton_method(name) do
        #     return if @@hash_const[name]
        #     @@hash_const[name] = block.call
        # end

        self.class_exec do
            define_method(name) do
                hash = instance_variable_get("@hash_const")
                return if hash[name]
                hash[name] = block.call
            end

        end
    end

    def self.set_system_jitter(value=0.1)
        @@system_jitter = value
    end


    define_const(:add_lite_cfg) do
"
set_false_path -from [get_pins -hier -regexp .*axi_lite_configure.*cfg_inf.*wdata.*] -to [all_registers]
"
    end

    define_const(:add_video_const) do
"
set_false_path -from [get_pins -hier -regexp .*hactive_reg.*] -to [all_registers]
set_false_path -from [get_pins -hier -regexp .*vactive_reg.*] -to [all_registers]
"
    end

    define_const(:add_fifo_const) do
"
set_max_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/data_array.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/rdata.*] 20.000
set_max_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/rd_flag.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/full.*] 20.000
set_max_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/wr_flag.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/data_array_empty.*] 20.000

set_min_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/data_array.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/rdata.*] -3.000
set_min_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/rd_flag.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/full.*] -3.000
set_min_delay -from [get_pins -hier -regexp .*independent_clock_fifo.*/wr_flag.*] -to [get_pins -hier -regexp .*independent_clock_fifo.*/data_array_empty.*] -3.000
"
    end

    define_const(:add_xilinx_fifo_const) do
"
# set_false_path -from [all_registers] -to [get_pins -hier -regexp .*FIFO_DUALCLOCK_MACRO.*RST.*]
# set_false_path -from [get_pins -hier -regexp .*fifo.*FIFO_DUALCLOCK_MACRO.*RDCLK] -to [get_pins -hier -regexp .*fifo.*wcount_reg.*]
# set_false_path -from [get_pins -hier -regexp .*fifo.*FIFO_DUALCLOCK_MACRO.*WRCLK] -to [get_pins -hier -regexp .*fifo.*rcount_reg.*]
# set_false_path -from [all_registers] -to [get_pins -hier -regexp .*xilinx_fifo.*xilinx_reset_sync_.inst/reset_sync./PRE]
# set_false_path -from [get_pins -hier -regexp .*fifo_wr_rd_mark_inst.*en_.*_en.*] -to [get_pins -hier -regexp .*FIFO_DUALCLOCK_MACRO.*EN]
set_max_delay -from [all_registers] -to [get_pins -hier -regexp .*FIFO_DUALCLOCK_MACRO.*RST.*] 25.00
set_max_delay -from [get_pins -hier -regexp .*fifo.*FIFO_DUALCLOCK_MACRO.*RDCLK] -to [get_pins -hier -regexp .*fifo.*wcount_reg.*] 25.00
set_max_delay -from [get_pins -hier -regexp .*fifo.*FIFO_DUALCLOCK_MACRO.*WRCLK] -to [get_pins -hier -regexp .*fifo.*rcount_reg.*] 25.00
set_max_delay -from [all_registers] -to [get_pins -hier -regexp .*xilinx_fifo.*xilinx_reset_sync_.inst/reset_sync./PRE] 25.00
set_max_delay -from [get_pins -hier -regexp .*fifo_wr_rd_mark_inst.*en_.*_en.*] -to [get_pins -hier -regexp .*FIFO_DUALCLOCK_MACRO.*EN] 25.00
"
    end

    define_const(:add_axi4_convert_const) do
"
# set_false_path -from [get_pins -hier -regexp .*axi4_data_convert.*axi4_data_combin_aflag_pipe.*MULT_MACRO.*DSP48.*] -to [get_pins -hier -regexp .*axi4_partition.*len_overflow.*]
set_max_delay -from [get_pins -hier -regexp .*axi4_data_convert.*axi4_data_combin_aflag_pipe.*MULT_MACRO.*DSP48.*] -to [get_pins -hier -regexp .*axi4_partition.*len_overflow.*] 20.00
"
    end

    define_const(:add_hdmi_in) do
'
create_clock -period 6.734 -name hdmi_in_pix_clk -waveform {0.000 3.367} [get_nets -hier -regexp hdmi_in.*/dvi2rgb_inst/PixelClk]
set_false_path -from [get_pins -hier -regexp .*dvi2rgb.*U0/TMDS_ClockingX/aLocked_reg/C] -to [all_registers]
set_false_path -from [get_pins -hier -regexp .*dvi2rgb_inst/U.+DataDecoders.*] -to [get_pins -hier -regexp .*dvi2rgb_inst/.*ResyncToBUFG_X.*D]
'   end

    # about multiboot

    define_const(:gold_image) do
"
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0x0400000 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]
"
    end

    def image(type: :gold,next_addr:0x0400000,bitpath:nil)
        # return if @@hash_bitstream_const[:image]
        next_addr = 0x0400000 unless next_addr
        gold_str =
"
## ----------- SET GOLD BITSTREAM ---------------------
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0x#{next_addr.to_s(16)} [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
# set_property BITSTREAM.GENERAL.COMPRESS FALSE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]

set_property BITSTREAM.CONFIG.NEXT_CONFIG_REBOOT ENABLE [current_design]
# set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR NO [current_design]
## =========== SET GOLD BITSTREAM =====================
"
        update_str =
"
## ----------- SET UPDATE BITSTREAM ---------------------
set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
# set_property BITSTREAM.GENERAL.COMPRESS FALSE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]
## =========== SET UPDATE BITSTREAM =====================
"
        write_bitstream_str =
"
# write_bitstream -force -verbose #{File.join(bitpath,"gold.bit")}
# write_bitstream -force -verbose #{File.join(bitpath,"update.bit")}
# write_cfgmem -force -format mcs -interface SPIx1 -size 16 -loadbit \"up 0 #{File.join(bitpath,"gold.bit")} up 0x#{next_addr.to_s(16)} #{File.join(bitpath,"update.bit")}\" #{File.join(bitpath,"multiboot.mcs")}
"
        case(type)
        when :gold
            @hash_bitstream_const[:image] = gold_str + write_bitstream_str
        when :update
            @hash_bitstream_const[:image] = update_str + write_bitstream_str
        end

    end


end
