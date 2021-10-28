class Oystercard
  attr_reader :balance, :limit, :entry_station, :all_journeys

  DEFAULT_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station = nil
    @all_journeys = []
    @single_journey = {:entry_station => "", :exit_station => ""}
  end

  def top_up(amount)
    @balance + amount > @limit ? fail("Max limit of #{DEFAULT_LIMIT} GBP reached") : @balance += amount
  end

  def touch_in(entry_station)
    @balance < MINIMUM_FARE ? fail("Please top up") : @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    record_journey(@entry_station, exit_station)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  def record_journey(entry_station, exit_station)
    @single_journey = {:entry_station => entry_station, :exit_station => exit_station}
    @all_journeys << @single_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end