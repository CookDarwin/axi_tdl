$__contain_hdl__ = []
def __require_hdl__(hdl_path,current_sdlm=nil,encoding='utf-8')
    basename = File.basename(hdl_path,".*")
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

                AutoGenSdl.new(rel,File.join(__dir__,"tmp"),encoding=encoding).auto_rb

                ## 如果是 在非 sdlmodule 内引用需要添加contain_hdl
                # if !(current_sdlm.is_a?(SdlModule))
                #     if TopModule.current
                #         TopModule.current.contain_hdl(rel)
                #     else
                #         unless  $__contain_hdl__.include? rel
                #             $__contain_hdl__ << rel
                #         end
                #     end
                # end
                if current_sdlm 
                    current_sdlm.contain_hdl(rel)
                else 
                    unless  $__contain_hdl__.include? rel
                        $__contain_hdl__ << rel
                    end
                end
                
            else 
                raise TdlError.new("path<#{hdl_path}> error!!!")
            end
        end
        require_relative File.join(__dir__,"tmp","#{basename}_sdl.rb")
    end
end

def TopModule.contain_hdl(*hdl_paths)
    hdl_paths.each do |hdl_path|
        rel = find_first_hdl_path(hdl_path)
        unless rel 
            return nil 
        end
        unless  $__contain_hdl__.include? rel
            $__contain_hdl__ << rel
        end
    end
end

unless File.exist? File.join(__dir__,'tmp')  
    Dir.mkdir File.join(__dir__,'tmp')
end

def find_first_hdl_path(basename)
    $__tdl_paths__.each do |e|
        if File.exist? File.join(e,basename)
            return File.expand_path(File.join(e,basename))
        end
    end
    return nil
end

def require_hdl(hdl_path,encoding='utf-8')
    __require_hdl__(hdl_path,nil,encoding)
end