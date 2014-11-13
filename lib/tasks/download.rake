require 'net/http'
require 'zipruby'
 
task :pull do |t|
  uri = URI('http://www.atlantapd.org/pdf/crime-data-downloads/FEF7DA13-8F81-4714-B773-A1D5AE5131C4.zip')
  data = Net::HTTP.get(uri)
 
  Zip::Archive.open_buffer(data) do |z|
    z.fopen(z.get_name(0)) do |e|
      File.open('tmp/data.txt', 'w:ASCII-8BIT') do |f|
        f.write e.read
      end
    end
  end
end