require 'rubygems'
require 'net/http'
require 'zipruby'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'date'
require 'smarter_csv'
 
task :csv => :environment do


	base = 'http://www.atlantapd.org/'

	page = Nokogiri::HTML(open(base+'crimedatadownloads.aspx'))
  	downloads = page.css('tr')


  	for d in downloads
   		td = d.css('td')
   		if td.text.include? "Raw Data"
   			newZip = td.css('a')[0]['href']
   		end
  	end

  	uri = URI(base+newZip)
  	data = Net::HTTP.get(uri)
 
  	Zip::Archive.open_buffer(data) do |z|
    	z.fopen(z.get_name(0)) do |e|
      		File.open('tmp/data.csv', 'w:ASCII-8BIT') do |f|
       			f.write e.read
      		end
    	end
  	end



	filename = "tmp/data.csv"
	outdata = File.read(filename).gsub(/^.*?\([^\d]*(\d+)[^\d]*\).*$/,'').gsub(/^[\s]*$\n/,'').strip

	File.open(filename, 'w') do |out|
	  	out << outdata.chomp
	end

	
	options = {:quote_char => "\x00", :verbose => true, :chunk_size => 1, :convert_values_to_numeric => false, :downcase_header => false, :header_converters => lambda { |h| h.gsub(' ', '_') }, :key_mapping => { :unwanted_row => nil, :old_row_name => :new_name }}

	max = Crime.maximum(:crime_id).to_f
	
	n = SmarterCSV.process(filename, options) do |array|


	    obj = array.first
	    
	    newObj = {}


    	newObj[:crime_id] = obj.values[0]
    	newObj[:offense_id] = obj[:offense_id]
    	newObj[:rpt_date] = obj[:rpt_date]

	    occured = obj[:occur_date]
		zone = ''
		if !obj[:beat].blank?
			zone = obj[:beat]
		end
		if occured != nil
			newObj[:occur_date] = Date.strptime(occured, '%m/%d/%Y')
		end

		newObj[:occur_time] = obj[:occur_time]
		newObj[:beat] = obj[:beat]
		newObj[:zone] = zone[0]
		newObj[:location] = obj[:location]
		newObj[:MaxOfnum_victims] = obj[:MaxOfnum_victims]
		newObj[:Shift] = obj[:Shift]
		newObj[:crime] = obj[:UC2_Literal]
		newObj[:neighborhood] = obj[:neighborhood]
		newObj[:x] = obj[:x]
		newObj[:y] = obj[:y]

		violent = ['HOMICIDE','RAPE','AGG ASSAULT','ROBBERY']

		if violent.include?(newObj[:crime])
			newObj[:violent] = 'violent'
		else
			newObj[:violent] = 'nonviolent'
		end


		if newObj[:crime_id].to_f > max

			puts newObj[:occur_date]

	    	newCrime = Crime.new(newObj)
		    if newCrime.valid?
		    	newCrime.save	
		    end
	    end


	end

end