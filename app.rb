require 'sinatra'

require 'slim'

require 'smarter_csv'
require 'daru'
require 'text'
require 'gnuplotrb'
require 'distribution'

# require "./csv_methods.rb"
# include CsvMethods

ATM_STRING = 'NWD-416021XXXXXX6415'
POS_STRING_1 = 'POS 416021XXXXXX6415'
POS_STRING_2 = 'POS DEBIT'

raw_df = Daru::DataFrame.from_csv('bank-statements/hdfc.csv')
# raw_df['Date'].map! {|row| DateTime::strptime( row, "%d/%m/%y") }
# raw_df.index = Daru::DateTimeIndex.new(raw_df['Date'])

# cleaned_df = raw_df
# cleaned_df['Name'] = cleaned_df.map(:row) {|row| row['Name'].sub(POS_STRING_1, "POS").sub(POS_STRING_2, "").sub(ATM_STRING, "ATM")	}
names = raw_df.group_by('Name').size
names = names.sort(ascending:false)
# plot = GnuplotRB::Plot.new [df, with: 'lines', title: 'Closing Balance']
# plot = plot.to_png('public/plot.png')

get "/" do
	# slim "img src='plot.png'"
	# names.sort['size'].to_s
	names.to_s
	# names.to_s
end

