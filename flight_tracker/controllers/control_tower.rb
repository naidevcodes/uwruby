$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_support'
require 'active_record'
require '../models/models'
require '../simulator'


class ControlTower

  include Sim


  def intitalize
    @flight = Flight.new
  end

  def all_airborne_flights
    Flight.where('landing_at' > Time.now)
  end

  def planes_landed(seconds)
    Flight.where('landing_at' > Time.now - seconds)
  end

  def test
    flight_loop
  end

end

a = ControlTower.new
a.test

