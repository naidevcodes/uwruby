$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'active_record'
require 'active_support/all'

ActiveRecord::Base.establish_connection(
adapter:'mysql2',
  database:'flights',
host:'localhost',
username:'root',
  password:'d0TH3d3w11' # password censored
)
class FlightsDB < ActiveRecord::Migration
  def db_up
    unless ActiveRecord::Base.connection.table_exists? 'flights'
      create_table :flights do |t|
        t.string :flight_code
        t.timestamp :entry_at
        t.integer :dscnt_spd
        t.string :status
        t.timestamp :landing_at
      end
    end
  end
end


  a = FlightsDB.new

a.db_up







class Flight < ActiveRecord::Base

  SPEC = YAML::load_file('../design_spec.yml')

  def initiate_db
    unless Flight.first
      entry_at = Time.now - 3600
      Flight.create(
        flight_code: 'AB 2222',
        entry_at: entry_at,
        dscnt_spd: 128,
        status: 'accepted',
        landing_at: entry_at + 700
        )
    end
  end

  def time_of_landing(flight_id)
    Flight.find(flight_id).entry_at +
    SPEC['stndrd_dscnt_trajectory'] / dscnt_spd
  end

  def time_of_final_approach(speed)
    SPEC['stndrd_dscnt_trajectory'] / speed
  end

  def flight_status

  end

  def distance(speed, entry_at)
    speed * (entry_at)
  end

  def descent_speed
    if Flight.last.dscnt_spd < Time.now
      SPEC['dscnt_spd_max']
    else
      
    end
  end

  def descent_time(speed)
    SPEC['stndrd_dscnt_trajectory'] / speed
  end

  def descent_rate(speed)
    SPEC['downward_alt_slant'] / speed
  end

  def current_position(distance)
    x = ( -2.1e-12 * distance**3 ) -
        ( 4.41e-6 * distance**2 ) +
        ( 0.047 * distance ) + 16000

    y = ( 2.23e-14 * distance**4 ) -
        ( 2e-9 * distance**3 ) +
        ( 1.022e-4 * distance**2 ) -
        ( 5 * distance ) + 47000
  end

  def test
    initiate_db
  end

end

b = Flight.new
b.test