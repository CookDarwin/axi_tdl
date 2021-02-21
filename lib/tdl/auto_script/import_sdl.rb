
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