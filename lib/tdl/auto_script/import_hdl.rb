
def require_hdl(hdl_path)
    basename = File.basename(hdl_path,".sv")
    unless SdlModule.exist_module? basename
        ## 检测是不是全路径, 或当前路径查得到
        if File.exist? hdl_path
            AutoGenSdl.new(hdl_path,File.join(__dir__,"tmp")).auto_rb
        else 
            if hdl_path !~ /[\/|\\]/
                rel = find_first_hdl_path(hdl_path)
                unless rel 
                    raise TdlError.new("Cant find <#{hdl_path}> in tdl paths !!!")    
                end

                AutoGenSdl.new(rel,File.join(__dir__,"tmp")).auto_rb
            else 
                raise TdlError.new("path<#{hdl_path}> error!!!")
            end
        end
        require_relative File.join(__dir__,"tmp","#{basename}_sdl.rb")
    end
end

unless File.exist? File.join(__dir__,'tmp')  
    Dir.mkdir File.join(__dir__,'tmp')
end

def find_first_hdl_path(basename)
    $__tdl_paths__.each do |e|
        if File.exist? File.join(e,basename)
            return File.join(e,basename)
        end
    end
    return nil
end
