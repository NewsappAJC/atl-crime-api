require 'csv'

desc "Imports comma delimited text file into an ActiveRecord table"
task :import, [:filename] => :environment do    

    CSV.foreach("data/Cobra073114.txt", :headers => true) do |row|
    	if row[2] != nil
			row[2] = row[2].strip
		end
		if row[3] != nil
			row[3] = row[3].strip
		end
		if row[4] != nil
			row[4] = row[4].strip
		end
		if row[5] != nil
			row[5] = row[5].strip
		end
		if row[6] != nil
			row[6] = row[6].strip
		end
		row.delete(20)
		row.delete(17)
		row.delete(16)
		row.delete(13)
		row.delete(12)
		row.delete(11)
		row.delete(9)
		row.delete(8)
		row.delete(0)
      	Crime.create!(row.to_hash)
    end
end