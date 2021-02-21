# require_relative "./autogenaxis"
# require_relative "./autogentdl"

def path_scan(path,rep=/.sv/i)
    root_path = path
    dir_list = Dir::entries(path) - %w{. ..}
    dir_list.select! {|d| d !~ /^\./}
    dir_list.map! {|d| File::join(root_path,d)}

    file_list = dir_list.select do |d|
            (File::file? d) && (d =~ rep)
        end

    dir_list = dir_list - file_list

    dir_list.select! {|d| File.directory? d}

    dir_cel = dir_list.map do |e|
        path_scan(e,rep)
    end

    return file_list + dir_cel.flatten
end

def mark_files(file_list)
    file_hash = Hash.new
    file_list.each do |e|
        f_str = File.open(e,'r').read.force_encoding('utf-8')
        mth = f_str.match(/\(\*\s+(?<inf>axi_stream|axi4|data_inf|axi_lite)\s*=\s*"true"\s+\*\)/)
        next unless (mth)
        sub_hash = Hash.new
        hash_name = File::basename(e,".*")
        sub_hash[:name] = File::basename(e,".*")
        sub_hash[:path] = e
        sub_hash[:mtime]= File::mtime(e)
        sub_hash[:inf]  = mth[:inf]

        file_hash[hash_name] = sub_hash
    end
    return file_hash
end

# def gen_auto_files(file_hash)
#     axi_stream_path = "./axi_stream"
#
#     file_hash.each do |key,value|
#         auto_axi_stream(filename=value[:path],out_file_path=axi_stream_path)
#     end
# end

def require_path(path)
    curr_path = File.expand_path(path)

    file_list = path_scan(curr_path,/\.rb$/)
    ## ------------
    mark_list = file_list.map { |e|  e.sub(/\.rb$/,"_auto.rb") }

    mark_list = mark_list.select { |e|  e !~ /_auto_auto/}
    ## -----------
    mark_sdl  = file_list.map { |e|  e.sub(/\.rb$/,"_sdl.rb") }

    mark_sdl  = mark_sdl.select { |e|  e !~ /_sdl_sdl/}
    ## -----------
    mark_bak  = file_list.select { |e| e =~ /\Wbak\W/i}

    file_list = file_list - mark_list - mark_bak - mark_sdl

    file_list = file_list - mark_list.select { |e| e.sub(/^_+/,"") }

    file_list = file_list.select { |e|  e !~ /^test/i}

    file_list.each do |e|
        # puts e
        require_relative (''+e.sub(/\.rb/,'')+'')
    end

    return file_list
end

def require_path_and_ignore(path,*ignores)
    curr_path = File.expand_path(path)

    file_list = path_scan(curr_path,/\.rb$/)

    mark_list = file_list.map { |e|  e.sub(/\.rb$/,"_auto.rb") }

    mark_list = mark_list.select { |e|  e !~ /_auto_auto/}

    file_list = file_list - mark_list

    file_list = file_list - mark_list.select { |e| e.sub(/^_+/,"") }

    file_list = file_list.select { |e|  e !~ /^test/i}

    file_list = file_list.select do |e|
        get_l = true
        ignores.each do |ig|
            if e.include? ig
                get_l   = false
            end
        end
        get_l
    end

    file_list.each do |e|
        # puts e
        require_relative (''+e.sub(/\.rb/,'')+'')
    end
end


# mark_files(path_scan('E:\work\AXI\AXI_stream')).each {|e| puts e}
# unless ARGV.empty?
#     gen_auto_files(mark_files(path_scan('E:\work\AXI\AXI_stream')))
# end

def require_relative_path(relative=File.expand_path(__dir__),path)
    require_path(File.expand_path(File.join(relative,path)))
end

## 添加库路径
$__tdl_paths__ ||=[]

def add_to_tdl_paths(full_path)
    if File.exist? full_path
        unless File.directory? full_path
            raise "<#{full_path}> is not a directory!!!"
        else 
            $__tdl_paths__ << full_path unless $__tdl_paths__.include?(full_path)
        end
    else 
        raise "Dont exist #{full_path}"
    end
end
