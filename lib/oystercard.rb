class Oystercard
  attr_reader :balance, :limit
  DEFAULT_LIMIT = 90

  default_limit = DEFAULT_LIMIT
  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
  end

  def top_up(amount)
    @balance + amount > @limit ? fail('Max limit of #{default_limit} GBP reached') : @balance += amount
  end
end