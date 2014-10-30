require 'net/http'
require 'zipruby'
 
task :pull, :remote_path, :output_file do |t, args|
  uri = URI(args[:remote_path])
  data = Net::HTTP.get(uri)
 
  Zip::Archive.open_buffer(data) do |z|
    z.fopen(z.get_name(0)) do |e|
      File.open(args[:output_file], 'w:ASCII-8BIT') do |f|
        f.write e.read
      end
    end
  end
end