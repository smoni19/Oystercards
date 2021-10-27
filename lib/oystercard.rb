class Oystercard
  attr_reader :balance, :limit, :entry_station

  DEFAULT_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @entry_station = nil
  end

  def top_up(amount)
    @balance + amount > @limit ? fail("Max limit of #{DEFAULT_LIMIT} GBP reached") : @balance += amount
  end

  def touch_in(station)
    @balance < MINIMUM_AMOUNT ? fail("Please top up") : @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end