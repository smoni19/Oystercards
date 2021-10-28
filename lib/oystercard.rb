class Oystercard
  #include Station

  attr_reader :balance, :limit, :entry_station, :all_journeys, :entry_zone, :exit_zone

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station = nil
    @entry_zone = nil
    @all_journeys = []
    @single_journey = { :entry_station => "", :entry_zone => nil, :exit_station => "", :exit_zone => nil }
    #@zone_list = list_zones
  end

  def top_up(amount)
    @balance + amount > @limit ? fail("Max limit of #{DEFAULT_LIMIT} GBP reached") : @balance += amount
  end

  def touch_in(entry_station, entry_zone)
    @balance < MINIMUM_FARE ? fail("Please top up") : @entry_station = entry_station
    @entry_zone = entry_zone
  end

  def touch_out(exit_station, exit_zone)
    deduct(MINIMUM_FARE)
    record_journey(@entry_station, @entry_zone, exit_station, exit_zone)
  end

  def in_journey?
    !!@entry_station
  end

  def record_journey(entry_station, entry_zone, exit_station, exit_zone)
    @single_journey = {:entry_station => entry_station, :entry_zone => entry_zone, :exit_station => exit_station, :exit_zone => exit_zone}
    @all_journeys << @single_journey
    @entry_station = nil
    @entry_zone = nil
  end

 # def test
 #   puts @zones[:zone1]
 # end

  private

  def deduct(amount)
    @balance -= amount
  end
end