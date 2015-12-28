require 'minitest/autorun'
require 'minitest/pride'
require './bestonline_books_with_db'
require 'byebug'

class
  TestStoreManager< Minitest::Test
    def setup
      @store_manager= SimStore.new
    end

  def test_title
    assert_equal "SimStore", @store_manager.
  end
end