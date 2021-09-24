
## 添加 引入 sdl module
def require_sdl(sdl_path)
    basename = File.basename(sdl_path,".rb")
    unless SdlModule.exist_module? basename
        ## 检测是不是全路径, 或当前路径查得到
        if File.exist? sdl_path
            # AutoGenSdl.new(hdl_path,File.join(__dir__,"tmp")).auto_rb
            # puts File.expand_path sdl_path
            require_relative File.expand_path(sdl_path)
        else 
            if sdl_path !~ /[\/|\\]/
                rel = find_first_hdl_path(sdl_path)
                unless rel 
                    raise TdlError.new("Can find <#{sdl_path}> in tdl paths !!!")    
                end

                # AutoGenSdl.new(rel,File.join(__dir__,"tmp")).auto_rb
                require_relative rel
            else 
                raise TdlError.new("path<#{sdl_path}> error!!!")
            end
        end
        # require_relative File.join(__dir__,"tmp","#{basename}_sdl.rb")
    end
end

## 添加 模糊引入 
def require_shdl(*shdl_name)
    shdl_name.each do |s|
        unless s.is_a? Array
            __require_shdl__(s)
        else 
            __require_shdl__(s[0],s[1])
        end
    end    
end

def __require_shdl__(shdl_name,encoding='utf-8')
    
    unless SdlModule.exist_module? shdl_name
        sdl_path = "#{shdl_name}.rb"
        rel = find_first_hdl_path(sdl_path)
        ## 匹配 SDL
        if rel 
            require_relative rel
            return 
        end
        ## 匹配 SV 
        sv_path = "#{shdl_name}.sv"
        v_path = "#{shdl_name}.v"
        vv_path = "#{shdl_name}.V"

        rel = find_first_hdl_path(sv_path) || find_first_hdl_path(v_path) || find_first_hdl_path(vv_path)
        if rel 
            AutoGenSdl.new(rel,File.join(__dir__,"tmp"),encoding=encoding).auto_rb

            unless  $__contain_hdl__.include? rel
                $__contain_hdl__ << rel
            end

            require_relative File.join(__dir__,"tmp","#{shdl_name}_sdl.rb")
            return 
        end

        raise TdlError.new("Can find <#{shdl_name}> in tdl paths !!!")    
    end
end
