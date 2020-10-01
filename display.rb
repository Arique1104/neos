require_relative "near_earth_objects"
class Display
  attr_reader :column_data, :asteroid_list
  def request_date
    puts "________________________________________________________________________________________________________________________________"
    puts "Welcome to NEO. Here you will find information about how many meteors, astroids, comets pass by the earth every day. \nEnter a date below to get a list of the objects that have passed by the earth on that day."
    puts "Please enter a date in the following format YYYY-MM-DD."
    print ">>"

  end

  def total_number_of_asteroids
    @asteroid_details[:total_number_of_asteroids]
  end

  def largest_asteroid
    @asteroid_details[:biggest_asteroid]
  end

  def create_neo_report(date)
    @asteroid_details = NearEarthObjects.find_neos_by_date(date)
    @asteroid_list = @asteroid_details[:asteroid_list]
    # total_number_of_asteroids =
    # largest_asteroid =

    column_labels = { name: "Name", diameter: "Diameter", miss_distance: "Missed The Earth By:" }
    @column_data = column_labels.each_with_object({}) do |(col, label), hash|
      hash[col] = {
        label: label,
        width: [@asteroid_list.map { |asteroid| asteroid[col].size }.max, label.size].max}
    end

    # header = "| #{ @column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

  def divider
    "+-#{@column_data.map { |_,col| "-"*col[:width] }.join('-+-') }-+"
  end

  def header
    "| #{ @column_data.map { |_,col| col[:label].ljust(col[:width]) }.join(' | ') } |"
  end

end
