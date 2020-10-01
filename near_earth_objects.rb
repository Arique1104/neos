require 'faraday'
require 'figaro'
require 'pry'
require 'json'
# Load ENV vars via Figaro
Figaro.application = Figaro::Application.new(environment: 'production', path: File.expand_path('../config/application.yml', __FILE__))
Figaro.load

class NearEarthObjects

  def initialize(date)
    @date = date
    connect_to_api = Faraday.new(
      url: 'https://api.nasa.gov',
      params: { start_date: @date, api_key: ENV['nasa_api_key']}
    )
    @raw_data = connect_to_api.get('/neo/rest/v1/feed')
  end

  def parse_request
    JSON.parse(@raw_data.body, symbolize_names: true)[:near_earth_objects][:"#{@date}"]
  end

  def self.largest_asteroid_diameter
    @neo.map do |asteroid|
      asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i
    end.max
  end

  def self.total_number_of_asteroids
    @neo.count
  end

  def self.formatted_asteroid_data
    @neo.map do |asteroid|
      {
        name: asteroid[:name],
        diameter: "#{asteroid[:estimated_diameter][:feet][:estimated_diameter_max].to_i} ft",
        miss_distance: "#{asteroid[:close_approach_data][0][:miss_distance][:miles].to_i} miles"
      }
    end
  end

  def self.find_neos_by_date(date)

    neo = NearEarthObjects.new(date)
    @neo = neo.parse_request

    {
      asteroid_list: formatted_asteroid_data,
      biggest_asteroid: largest_asteroid_diameter,
      total_number_of_asteroids: total_number_of_asteroids
    }
  end
end
