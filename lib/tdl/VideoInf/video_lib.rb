require_relative "./../global_scan"
curr = File.expand_path(__FILE__)
curr_path = File.dirname(curr)
file_list = path_scan(curr_path,/\.rb$/) - [curr]

file_list.each do |e|
    require_relative (''+e.sub(/\.rb/,'')+'')
end
