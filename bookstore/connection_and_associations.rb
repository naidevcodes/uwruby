require 'active_record'

ActiveRecord::Base.establish_connection(
adapter:'mysql2',
database:'store_manager',
host:'localhost',
username:'root',
  password:'d0TH3d3w11'
)



class Product < ActiveRecord::Base
	has_many :sales
	belongs_to :vendor
end

class Sale < ActiveRecord::Base
	belongs_to :products
	belongs_to :employees
end

class Vendor < ActiveRecord::Base
	has_many :products
end

class Employee < ActiveRecord::Base
	has_many :sales
end


