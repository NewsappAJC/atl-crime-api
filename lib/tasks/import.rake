require 'rubygems'
require 'net/http'
require 'zipruby'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'date'
 
task :import => :environment do    

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


 #  	crime_data = CSV.read("tmp/data.txt", quote_char: "\x00", :headers => true, :header_converters => lambda { |h| h.gsub(' ', '_') }, :skip_blanks => true)

	# line = crime_data.length-1

	# crime_data.delete(line)

	# puts crime_data.length

 #    crime_data.each do |row|

 #    	mi_prinx = row[0]

 #    	if row[2] != nil
	# 		row[2] = row[2].strip
	# 	end
	# 	if row[3] != nil
	# 		row[3] = row[3].strip
	# 	end
	# 	if row[4] != nil
	# 		row[4] = row[4].strip
	# 	end
	# 	if row[5] != nil
	# 		row[5] = row[5].strip
	# 	end
	# 	if row[6] != nil
	# 		row[6] = row[6].strip
	# 	end

	# 	row.delete(20)
	# 	row.delete(17)
	# 	row.delete(16)
	# 	row.delete(13)
	# 	row.delete(12)
	# 	row.delete(11)
	# 	row.delete(9)
	# 	row.delete(8)
	# 	row.delete(0)

	# 	obj = row.to_hash
	# 	occured = obj['occur_date']
	# 	zone = obj['beat']
	# 	obj['MI_PRINX'] = mi_prinx
	# 	obj['occur_date'] = Date.strptime(occured, '%m/%d/%Y')
	# 	obj['zone'] = zone[0]
	# 	obj['crime'] = obj['UC2_Literal']

	# 	violent = ['HOMICIDE','RAPE','AGG ASSAULT','ROBBERY']

	# 	if violent.include?(obj['crime'])
	# 		obj['violent'] = 'violent'
	# 	else
	# 		obj['violent'] = 'nonviolent'
	# 	end

	#     # newCrime = Crime.new(obj)
	#     # if newCrime.valid?
	#     # 	newCrime.save	
	#     # end

    # end

end