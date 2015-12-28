$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_support'
require 'active_record'
require 'models/models'
require 'byebug'

module Sim
  SPEC = YAML::load_file('../design_spec.yml')

  def initialize
    @controller = Flight.new
  end

  def flight
    lttr1 = ('a'..'z').to_a.sample.upcase
    lttr2 = ('a'..'z').to_a.sample.upcase
    num = rand(1000..9999).to_s

    lttr1 + lttr2 + " " + num
  end

  def speed
    rand(120..130)
  end

  def flight_loop
    make_flight = {
      flight_code:  flight,
      entry_at: Flight.last.entry_at + rand(30..50).seconds,
      dscnt_spd: speed,
      status: "accepted" #get_flight_status
    }
    3.times do
      Flight.create(make_flight)
      sleep(2)
#       byebug
    end

  end

  def test
    puts @controller.time_of_landing(1)
  end
end

# a = Sim.new
# a.test

# def flight_loop
#     last_flight = nil
#     loop do
#       last_flight = Flight.create(flight_code: flight, entry_at: last_flight.nil? ? Time.now : last_flight.entry_at + rand(30..50))

#       sleep(2)
#     end
#   end