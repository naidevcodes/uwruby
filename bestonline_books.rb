require 'random-word'
require 'seeing_is_believing'


class SimStore
  MAX_STOCK = 1000
  MAX_BOOKS = 10
  GET_SKU = 0brew upd

  def initialize 	
    @arr = (GET_SKU..MAX_BOOKS + GET_SKU).to_a.shuffle
    @product_list = Array.new
    @sales = Array.new
    @products_sold = Array.new
  end

  def generate_book
    title = RandomWord.nouns.next
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

  def make_product_list
    
    MAX_BOOKS.times do 
    @product_list.push(generate_book)
    end
  end

  def daily_sales
    sales_events = rand(0..100)

    sales_events.times do 
      @sales << {
        product_sale_details: @product_list[rand(0..@product_list.length - 1)],
        time: Time.new.strftime("%b %-d @%l:%m %P")
      }

    end
    @sales
  end

  def bestsellers

    @product_list.each do |product|
      puts "Number of titles in stock at beginning of day: #{product[:stock]}"
      count = 0
        @sales.select {|k, v|
          if k[:product_sale_details][:sku] == product[:sku]
            count += 1
            product[:stock] -= 1
          end
        }

      puts "End of day report: sku # #{product[:sku]} of title: \"#{product[:title].capitalize.gsub(/_/, " ")}\" sold #{count} copies @ $#{product[:price]} each. #{product[:stock]} remain in stock.\n-----------------"

      @products_sold << {sku: product[:sku], title: product[:title], sold: count}
      @products_sold.sort_by!{|x| x[:sold] }.reverse!  
    end
  end

  def test
    make_product_list
    daily_sales 
    bestsellers
  end

end

a = SimStore.new
a.test
