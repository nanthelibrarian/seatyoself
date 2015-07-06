class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
  validate :enough_capacity
  validate :within_restaurant_hours


  def enough_capacity
    if party_size > available_seats
      errors.add(:party_size, "larger than restaurant capacity")
    end
  end

  def within_restaurant_hours
    t = time
    beginning = DateTime.new(t.year,t.month,t.day,11,0,0)
    ending = DateTime.new(t.year,t.month,t.day,20,0,0)
    unless time >= beginning && time < ending 
      errors.add(:time, "Restaurant closed")
    end
  end

  def available_seats
    t = time
    beginning = DateTime.new(t.year,t.month,t.day,t.hour,0,0)
    ending = DateTime.new(t.year,t.month,t.day,t.hour+1,0,0)

    restaurant.capacity - restaurant.reservations.where("time >= ? and time < ?", beginning, ending).sum(:party_size)
  end
end
