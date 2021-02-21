
require_relative "./../global_scan"
curr = File.expand_path(__FILE__)
curr_path = File.dirname(curr)

require_path(curr_path)
# require_path_and_ignore(curr_path,'mail_box.rb')
