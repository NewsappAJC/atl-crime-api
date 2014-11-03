require 'net/http'
require 'zipruby'


# aws s3 config
s3 = AWS::S3.new(
	:access_key_id => 'AKIAJ6YGSWZPMTCT45NQ',
	:secret_access_key => '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'
)

obj = s3.buckets['crime-api'].objects.create('crimedata', 'data')

task :pull, :remote_path do |t, args|
  uri = URI(args[:remote_path])
  data = Net::HTTP.get(uri)
 
obj.write(Pathname.new(path_to_file))

  Zip::Archive.open_buffer(data) do |z|
    z.fopen(z.get_name(0)) do |e|
      File.open('/data.txt', 'w:ASCII-8BIT') do |f|
        obj.write(f) e.read
      end
    end
  end
end