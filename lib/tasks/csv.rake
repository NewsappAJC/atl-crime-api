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
      puts base+newZip
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
  
  lastId = Crime.count

  outdata = File.read(filename).gsub(/^.*?\([^\d]*(\d+)[^\d]*\).*$/,'').gsub(/("+)/,'').gsub(/^[\s]*$\n/,'').gsub(/([\s]{2,}[,])/,',').strip #cleans up downloaded file so that it's CSV parsable ... mostly removes extra spaces, any illegal characters ( PICK "N" PAY is one sneaky one ), etc

  File.open(filename, 'w') do |out|
      out << outdata.chomp #rewrites new CSV ready file
  end

  crimes = CSV.read(filename)[lastId..-1] #only read crimes that aren't in database into memory


#### creates new CSV file - newdata.csv - that only includes crimes that aren't already in the database
  CSV.open('tmp/newdata.csv','w') do |newRow|
    headers = CSV.read(filename)[0]
    newRow << headers
    crimes.each do |row|
      if row.length<=23
        newRow << row
      end
    end
  end



  options = {:quote_char => "\x00", :verbose => true, :chunk_size => 1, :convert_values_to_numeric => false, :downcase_header => false, :header_converters => lambda { |h| h.gsub(' ', '_') }, :key_mapping => { :unwanted_row => nil, :old_row_name => :new_name }}

  
  n = SmarterCSV.process("tmp/newdata.csv", options) do |array|

    obj = array.first

    if !Crime.exists?(:offense_id => obj[:offense_id])

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
      newObj[:beat_id] = obj[:beat]
      newObj[:zone_id] = zone[0]
      newObj[:location] = obj[:location]
      newObj[:MaxOfnum_victims] = obj[:MaxOfnum_victims]
      newObj[:Shift] = obj[:Shift]
      newObj[:neighborhood] = obj[:neighborhood]
      newObj[:x] = obj[:x]
      newObj[:y] = obj[:y]
      newObj[:npu] = obj[:npu]

      crime_type = obj[:UC2_Literal].split('-')
      newObj[:crime] = crime_type[0]

      if crime_type.length>1
        newObj[:crime_detail] = crime_type[-1]
      else
        newObj[:crime_detail] = nil
      end

      violent = ['HOMICIDE','RAPE','AGG ASSAULT','ROBBERY']

      if violent.include?(newObj[:crime])
        newObj[:violent] = 'violent'
      else
        newObj[:violent] = 'nonviolent'
      end

      newCrime = Crime.new(newObj)
      newCrime.save
    
      puts newObj[:occur_date]
    else
      puts obj[:offense_id]
    end


    


  end

end