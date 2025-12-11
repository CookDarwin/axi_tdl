
require_relative "./../global_scan"
curr = File.expand_path(__FILE__)
curr_path = File.dirname(curr)
# file_list = path_scan(curr_path,/\.rb$/) - [curr]
#
# mark_list = file_list.map { |e|  e.sub(/\.rb$/,"_auto.rb") }
#
# mark_list = mark_list.select { |e|  e !~ /_auto_auto/}
#
# file_list = file_list - mark_list
#
# file_list.each do |e|
#     # puts e
#     require_relative (''+e.sub(/\.rb/,'')+'')
# end

require_path(curr_path)
