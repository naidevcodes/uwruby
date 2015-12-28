$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'random-word'
require 'faker'
require 'active_support/all'
require 'class_associations_nitrous.rb'
require 'db_active_record_connection'
require 'byebug'


class SimStore
  MAX_STOCK = 1000
  MAX_BOOKS = 10
  GET_SKU = 0

  def initialize
    @sales_events = rand(0..100)
    @arr = (GET_SKU..MAX_BOOKS + GET_SKU).to_a.shuffle
    @product_list = Array.new
    @sales = Array.new
    @products_sold = Array.new
  end

  def generate_book
    title = RandomWord.adjs.next
    price = rand(1..100)
    sku_number = @arr.pop
    stock = rand(1..MAX_STOCK)
    product = {
      title: title,
      price: price,
      sku: sku_number,
      stock: stock
    }
  end

  def products_to_db
    MAX_BOOKS.times do
      product = generate_book
      vendor_id = Vendor.offset(rand(Vendor.count)).first.id
      products = Product.create(title: product[:title], vendor_id: vendor_id, price: product[:price], stock: product[:stock])
    end
  end

  def sales_to_db
    @sales_events.times do
      qty_of_sale = rand(1..5)
      product = Product.offset(rand(Product.count)).first
      employee_id = Employee.offset(rand(Employee.count)).first.id
      revenue = qty_of_sale * product.price
      product.update(stock: product.stock - qty_of_sale, )
      time_of_sale = rand(1..96).hours.ago
      sales = Sale.create(employee_id: employee_id, title: product.title, quantity_sold: qty_of_sale, product_id: product.id, created_at: time_of_sale, revenue: revenue, item_price: product.price)
    end
  end

  def sales_list(start_date, end_date)
    Sale.where(created_at: start_date..end_date).each do |sale|
      sale
    end
  end

  def total_revenues(start_date, end_date)
    Sale.where(created_at: start_date..end_date).sum(:revenue)
    end

  def items_to_replenish(minimum_stock)
    Product.where(stock: 0..minimum_stock).select  {|product| product.stock < minimum_stock}
  end

  def promotions # doesn't work
    promos_applied = 0.25
    promos_arr = ["3 for 2", "2 for 1", "2nd item 1/2 off"]
    promo_count = ((promos_arr.count/promos_applied) - promos_arr.count)

    (1..promo_count).each do
      promos_arr.push("No promo")
    end
    promos_arr.sample
  end



  def test
#     print sales_list("2015-11-14", "2015-11-15")
#     print total_revenues("2015-11-16", "2015-11-17")
#     print items_to_replenish(50)
#     puts promotions
  end

end



class DbManager

  TABLES = [
    "sales", "products", "employees", "vendors"
    ]

  def use_simstore_to
    simstore = SimStore.new
    @add_products_to_db = simstore.products_to_db
    @add_sales_to_db = simstore.sales_to_db
  end

  def clean_database
    TABLES.each{ |table_name| clean_table(table_name) }
  end

  def clean_table(table_name)
    table_name.singularize.camelize.constantize.delete_all
  end

  def populate_table(table_name)
    TABLES.reverse.each {|table| eval("#{table}")}
  end

  def populate_tables
    TABLES.reverse.each {|table_name| populate_table(table_name)}
  end

  def products
    use_simstore_to
    @add_products_to_db
  end

  def vendors
    5.times do
      vendors = Vendor.create(:name => Faker::Company.name )
    end
  end

  def sales
    use_simstore_to
    @add_sales_to_db
  end

  def employees
    10.times do
      employee = Employee.create(:name => Faker::Name.first_name)
    end
  end

  def test

  end

end


a = SimStore.new
a.test


store_manager = DbManager.new
# store_manager.test
# store_manager.clean_database
# store_manager.populate_tables

# Cleans specific table
# store_manager.clean_table("vendors")
# store_manager.clean_table("employees")
# store_manager.clean_table("sales")
# store_manager.clean_table("products")

# Populates specific table
# store_manager.populate_table("employees")
# store_manager.populate_table("vendors")
# store_manager.populate_table("products")
# store_manager.populate_table("sales")