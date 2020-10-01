require_relative 'near_earth_objects'
require_relative 'display'

@display = Display.new

@display.request_date

date = gets.chomp
@display.create_neo_report(date)


def format_row_data(row_data, column_info)
  row = row_data.keys.map { |key| row_data[key].ljust(column_info[key][:width]) }.join(' | ')
  puts "| #{row} |"
end

def create_rows(astroid_data, column_info)
  rows = astroid_data.each { |asteroid| format_row_data(asteroid, column_info) }
end

formated_date = DateTime.parse(date).strftime("%m-%d-%Y")
puts "______________________________________________________________________________"
puts "On #{formated_date}, there were #{@display.total_number_of_asteroids} objects that almost collided with the earth."
puts "The largest of these was #{@display.largest_asteroid} ft. in diameter."
puts "\nHere is a list of objects with details:"
puts @display.divider
puts @display.header
create_rows(@display.asteroid_list, @display.column_data)
puts @display.divider
