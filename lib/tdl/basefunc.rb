# require_relative "./tdlerror"

$__tdl_name_large_len ||= 0
$__tdl_name_large_len_freeze_en = false
def tdl_name_large_len
    $__tdl_name_large_len
end

def update_tdl_name_large_len(a)
    raise TdlError.new("\n Cant assign $__tdl_name_large_len_freeze\n") if $__tdl_name_large_len_freeze_en
    $__tdl_name_large_len = a
end

def freeze_tdl_name_large_len
    $__tdl_name_large_len_freeze_en = true
end

def unfreeze_tdl_name_large_len
    $__tdl_name_large_len_freeze_en = false
end

def axis_gen_big_field(mode:"MASTER",value:"32'h00000",enable:"1'b1",dsize:8,clock:nil,reset:nil,copy_axis:nil)
    if copy_axis.is_a? AxiStream
        new_axis = AxiStream.new(name:"orign_axis",clock:copy_axis.clock,reset:copy_axis.reset,dsize:copy_axis.dsize)
    else
        new_axis = AxiStream.new(name:"orign_axis",clock:clock,reset:reset,dsize:dsize)
    end
    new_axis.gen_big_field(mode:mode,value:value,enable:enable)
end

# def String.align_signal()
def large_name_len(*c)
    update_tdl_name_large_len(0)
    c.each do |e|
        begin
            if e.to_s.length > tdl_name_large_len
                update_tdl_name_large_len(e.to_s.length)
            end
        # rescue Exception => er
        #     p e
        #     raise er
        end
    end
    return tdl_name_large_len
end

def with_new_align(num=0,&block)
    tmp = tdl_name_large_len
    update_tdl_name_large_len(num)
    rel = block.call
    update_tdl_name_large_len(tmp)
    rel
end


def page(tag:"TAG EXP",body:"")
    return "" if body.empty?
    end_str =
    "\n//====>>>> #{tag} <<<<#{"="*(60-tag.length)}\n"
    head_str =
    "//----<<<< #{tag} >>>>#{"-"*(60-tag.length)}\n"
    return head_str + body.strip + end_str
end

def pagination(tag="")
    return "" if tag.empty?
    head_str = "\n//==============#{"="*(60-0)}"
    end_str  = "\n//-------- #{tag} ----#{"-"*(60-tag.length)}\n"
    head_str.concat end_str
end

class NqString < String
    # OP_SYMBOLS = %w{> < >= <= == !=}

    # OP_SYMBOLS.each do |s|
    #     define_method(s) do |a|
    #         operation_tow(s,a)
    #     end
    # end

    # private
    #     def operation_tow(symb,a)
    #         # return NqString.new(align_signal(signal,q_mark=false).concat("#{symb}").concat(align_signal(a,q_mark=false)))
    #         return NqString.new("#{self} #{symb} #{a.to_s}")
    #     end

    public

    def clog2
        return "$clog2(#{self})"
    end

    # define_method("+") do |a|
    #     return "#{self}+#{a.to_s}".to_nq
    # end

    define_method("~") do 
        return "~#{self}".to_nq
    end

end


class String
    def to_nq
        NqString.new(self)
    end
end

class Integer
    def to_hf(hf="32'd")
        case hf 
        when /d/i
            rel = self.to_s 
        when /h/i
            rel = self.to_s 16
        when /b/i
            rel = self.to_s 2
        else 
            raise TdlError.new("Iteger TO HDL FORMAT ERROR [#{hf}]")
        end

        "#{hf}#{rel}".to_nq
    end
end

def align_signal(obj,q_mark=true)
    raise TdlError.new("align_signal OBJECT CANT BE ARRAY LEN[#{obj.size}] [#{obj}]") if obj.is_a? Array
    if obj.is_a? NqString
        new_obj = obj
    elsif obj.is_a? Proc
        new_obj = obj.call
    elsif obj.instance_of? String
        if obj.match(/\d*'(d|h|b|sd|sh|sb)(\d|z|x)+/i) || obj.match(/'(0|1|z|x)/ || obj.match(/^\d+$/))
            new_obj = obj
        else
            if q_mark
                new_obj = '"'+obj+'"'
            else
                new_obj = obj
            end
        end
    # elsif obj.is_a? BaseElm
    #     new_obj = obj.signal
    else
        new_obj = obj
    end
    sl = new_obj.to_s.length

    if block_given?
        yield(tdl_name_large_len,sl)
    end

    if tdl_name_large_len>=sl
        ll = tdl_name_large_len-sl
    else
        ll=0
    end

    rel = new_obj.to_s + " "*ll
    # if rel =~ /\(.+\)/
    #     puts rel
    #     puts new_obj.class
    #     puts new_obj.to_s
    #     raise TdlError.new("====STOP======")
    # end
    rel
end

class EXParam
    def initialize(str)
        @name = str
    end

    def to_s
        @name.to_s
    end
end

def compact_signal(obj,q_mark=false)
    if obj.is_a? String
        if obj.match(/\d*'(d|h|b|sd|sh|sb)(\d|z|x)+/i) || obj.match(/'(0|1|z|x)/ || obj.match(/^\d+$/))
            new_obj = obj
        else
            if q_mark
                new_obj = '"'+obj+'"'
            else
                new_obj = obj
            end
        end
    else
        new_obj = obj
    end

    new_obj.to_s
end


module BaseModule
    def to_s
        signal
    end

    def length
        signal.length
    end
end

module BaseFunc
    # def to_s
    #     signal
    # end
    #
    # def length
    #     signal.length
    # end

    def check_same_dsize(*a)
        return nil unless a

        dsize = a[0].dsize

        a.each do |e|
            if dsize != e.dsize
                raise TdlError.new("#{e.signal} DSIZE ERROR")
            end
        end
    end

    def check_same_clock(*c)
        return nil unless c

        clock = c[0].clock

        c.each do |e|
            if clock != e.clock
                raise TdlError.new("#{e.signal} clock ERROR")
            end
        end
    end

    def check_same(m,*a)
        return nil unless a

        tmp = a[0].send(m)

        a.each do |e|
            if tmp != e.send(m)
                raise TdlError.new("#{e.signal} m.to_s ERROR")
            end
        end
    end


    def check_same_class(cl,*c)
        raise TdlError.new("#{c[0].signal} Wrong Class") unless c[0].is_a?  cl
        check_same(:class,c)
    end

end

class Integer

    def clog2
        b = Math.log2(self)
        c = b.ceil
        return c
    end

end

$__main__ = self


def define_main_func(name,&block)
    raise TdlError.new("\n In define main Function: function name <<#{name}>> must Symbol\n") unless name.is_a? Symbol
    raise TdlError.new("\n Function <<#{name}>>has already be defined in MAIN  \n") if $__main__.methods.include?(name)
    $__main__.send(:define_method,name,&block)
end

def undefine_main_func(name)
    # $__main__.send(:undef_method,name)
    # $__main__.send(:remove_method,name)
    eval("undef #{name}")
    # $__main__.undef_method(name)
end

def with_main_funcs(func_hash,&block)
    func_hash.each do |key,value|
        define_main_func(key,&value)
    end
    yr = yield

    func_hash.each do |key,value|
        undefine_main_func(key)
    end

    return yr
end


## 
def replace_methods(class_obj,methods_hash)
    
    methods_hash.each do |key,proc|
        ## 判断是否class_obj是否有方法 
        if class_obj.instance_methods.include?(key.to_s.to_sym)
            # class_obj.defind_method("replace__m_old_#{key.to_s}")
            # class_obj.class_exec(key) do |key|
            #     alias_method "replace__m_old_#{key.to_s}",key
            # end
            class_obj.alias_method "replace__m_old_#{key.to_s}",key.to_s
        end

        class_obj.define_method(key,&proc)
    end
end

def rollback_methods(class_obj,*methods_nams)
    methods_nams.each do |key|
        if class_obj.instance_methods.include?("replace__m_old_#{key.to_s}".to_sym)
            class_obj.class_exec(key) do |key|
                alias_method key.to_s,"replace__m_old_#{key.to_s}"
            end
        else 
            class_obj.undef_method(key.to_s)
        end
    end
end

### 用于生成随机数
$__name_random_index__ = (0...2000).to_a.shuffle(random: Random.new(1) ).map{|e| e.to_s }
$__name_random_index_ii__ = 0

def globle_random_name_flag(flag='R')
    rel = $__name_random_index__[$__name_random_index_ii__]
    $__name_random_index_ii__ += 1
    "#{flag}#{rel}"
end