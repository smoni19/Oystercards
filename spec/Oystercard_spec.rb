require 'oystercard'

describe Oystercard do
  it 'returns balance 0' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
end