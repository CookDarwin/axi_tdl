class Integer

    def method_missing(method,arg=nil)
        if method.to_s =~ /^s?[h|d]\d+$/i || method.to_s =~ /^s?[b](0|1|_)+$/i || method.to_s =~ /^s?[h][\d]?[\d|a-f]+$/i
            if self.nonzero?
                return "#{self.to_s}'#{method}".to_nq
            else 
                return "'#{method}".to_nq
            end 
        end

        super

    end

    # define_method("")
    def A
        if self.zero?
            return "'0".to_nq
        else 
            return "~('0)".to_nq
        end
    end
end