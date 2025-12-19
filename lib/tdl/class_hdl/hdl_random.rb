module ClassHDL

    module RandomNum
        def precent_true
            return "($urandom_range(0,99) <= #{self.to_s})".to_nq
        end

        def precent_false
            return "($urandom_range(1,100) > #{self.to_s})".to_nq
        end
    end

end

class SdlModule 
    def urandom_range(a,b)
        return "$urandom_range(#{a},#{b})".to_nq
    end
end

class Numeric 
    include ClassHDL::RandomNum
end

class Parameter 
    include ClassHDL::RandomNum
end

class Logic
    include ClassHDL::RandomNum
end
