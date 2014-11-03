require 'net/http'
require 'zipruby'
 
task :pull do |t|
  uri = URI('http://www.atlantapd.org/pdf/crime-data-downloads/F3F58CF3-4E41-4348-8757-FE9E8EB0318B.zip')
  data = Net::HTTP.get(uri)
 
  Zip::Archive.open_buffer(data) do |z|
    z.fopen(z.get_name(0)) do |e|
      File.open('tmp/data.txt', 'w:ASCII-8BIT') do |f|
        f.write e.read
      end
    end
  end
end