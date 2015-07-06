require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "make reservation" do
    restaurant = Restaurant.first
    reservation = restaurant.reservations.build(:time => DateTime.now, :party_size => 5, :user => User.first )
    
    reservation.save 
      
    assert reservation.errors.empty?
  end

  test "can't make reservation" do
    restaurant = Restaurant.first
    reservation = restaurant.reservations.build(:time => DateTime.now, :party_size => 11, :user => User.first )
    
    reservation.save 
      
    assert reservation.errors.any?
  end

  test "multiple reservations" do
    restaurant = Restaurant.first

    reservation1 = restaurant.reservations.build(:time => DateTime.now, :party_size => 5, :user => User.first )
    reservation1.save   
    assert reservation1.errors.empty?

    reservation2 = restaurant.reservations.build(:time => DateTime.now, :party_size => 6, :user => User.first )
    reservation2.save   
    assert reservation2.errors.any?
  end
 
  test "multiple reservations at different times" do
    restaurant = Restaurant.first

    reservation1 = restaurant.reservations.build(:time => DateTime.now + 2.days, :party_size => 5, :user => User.first )
    reservation1.save   
    assert reservation1.errors.empty?

    reservation2 = restaurant.reservations.build(:time => DateTime.now, :party_size => 6, :user => User.first )
    reservation2.save   
    assert reservation2.errors.empty?
  end
  
  test "can't make a reservation when restaurant closed" do
      restaurant = Restaurant.first

      reservation1 = restaurant.reservations.build(:time => DateTime.new(2016,8,1,5,0,0), :party_size => 5, :user => User.first )
      reservation1.save   
      assert reservation1.errors.any?
    end
end
