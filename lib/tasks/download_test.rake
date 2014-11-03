# require 'net/http'
# require 'zipruby'
# require 'csv'
# require 'date'



# # aws s3 config
# s3 = AWS::S3.new(
# 	:access_key_id => 'AKIAJ6YGSWZPMTCT45NQ',
# 	:secret_access_key => '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'
# )

# obj = s3.buckets['crime-api'].objects['data.txt']

# task :pull do |t|
#   uri = URI('http://www.atlantapd.org/pdf/crime-data-downloads/F3F58CF3-4E41-4348-8757-FE9E8EB0318B.zip')
#   data = Net::HTTP.get(uri)


#   Zip::Archive.open_buffer(data) do |z|
#     z.fopen(z.get_name(0)) do |e|
# 		obj.write(e.read)
#     end
#   end


#   s3data = obj.read(quote_char: "\x00", :headers => true, :header_converters => lambda { |h| h.gsub(' ', '_') }, :skip_blanks => true) do |row|


#   csvurl = 'https://s3.amazonaws.com/crime-api/data.txt'
#   # crime_data = CSV.read(s3data, quote_char: "\x00", :headers => true, :header_converters => lambda { |h| h.gsub(' ', '_') }, :skip_blanks => true)

#   #   crime_data.each do |row|

#     	if row[2] != nil
# 			row[2] = row[2].strip
# 		end
# 		if row[3] != nil
# 			row[3] = row[3].strip
# 		end
# 		if row[4] != nil
# 			row[4] = row[4].strip
# 		end
# 		if row[5] != nil
# 			row[5] = row[5].strip
# 		end
# 		if row[6] != nil
# 			row[6] = row[6].strip
# 		end

# 		# row.delete(20)
# 		# row.delete(17)
# 		# row.delete(16)
# 		# row.delete(13)
# 		# row.delete(12)
# 		# row.delete(11)
# 		# row.delete(9)
# 		# row.delete(8)
# 		# row.delete(0)
# 		puts row
# 		object = row.to_hash
# 		occured = object['occur_date']
# 		zone = object['beat']
# 		object['occur_date'] = Date.strptime(occured, '%m/%d/%Y')
# 		object['zone'] = zone[0]
# 		object['crime'] = object['UC2_Literal']

# 	    Crime.create!(object)
#   end


# end