class TdlError < ScriptError
    def initialize(arge)
        Tdl.PutsEnable = false
        head_str0 = String.new("\n+_____________________________________________+\n")
        head_str1 = "\n|----------------TDL ERROR--------------------|\n"
        end_str0  = "\n+================TDL ERROR====================+\n"
        super(head_str0.concat(head_str1).concat(arge.to_s[0,255]).concat(end_str0))
    end
end
