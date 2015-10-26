require 'rubygems'
require 'csv'
require 'date'
require 'smarter_csv'
 
task :npu => :environment do
	options = {:quote_char => "\x00", :verbose => true, :chunk_size => 1, :convert_values_to_numeric => false, :downcase_header => false, :header_converters => lambda { |h| h.gsub(' ', '_') }, :key_mapping => { :unwanted_row => nil, :old_row_name => :new_name }}

  
	n = SmarterCSV.process("tmp/data.csv", options) do |array|

		obj = array.first
		this_crime = Crime.where(:offense_id => obj[:offense_id]).update_all(:npu => obj[:npu])


	end



end