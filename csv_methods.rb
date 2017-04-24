module CsvMethods

	class DateConverter
	  def self.convert(value)
	    Date.parse value # parses custom date format into Date instance
	  end
	end

	class NilCleaner
		def self.convert(value)
		  return 0 if value.nil? # parses custom date format into Date instance
		  value
		end
	end

	Nums = [:withdrawal_amt, :deposit_amt]
	Options = {:value_converters => {:date => DateConverter, value_dt: DateConverter, withdrawal_amt: NilCleaner, deposit_amt: NilCleaner}, kep_mapping:{narration: :name}}

	def get_file
		SmarterCSV.process('file.csv', Options) 
	end

	def post_process(file)
		file.map do |row|
			Nums.each do |key|
				row[key] = 0 if row[key].nil?
			end
			row
		end
	end

	def get_array
		file = get_file
		array = post_process file
		array
	end

	csv_array = CsvMethods::get_array
	Cols = CsvMethods::Nums << :name


	nums_hash = Hash.new
	Cols.map do |e|
		aggregate = array.map do |row|
			row[e]
		end
		nums_hash[e] = aggregate
	end
	

end