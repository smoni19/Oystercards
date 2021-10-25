require 'oystercard'

describe Oystercard do
  it 'returns balance 0' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq 0
  end
    describe '#top_up' do
      it 'increases balance by amount given' do
        expect { subject.top_up(10) }.to change { subject.balance }.by(10)
      end
    end
    it 'has a maximum limit of 90' do
      oystercard = Oystercard.new
      expect(oystercard.limit).to eq 90
    end

    it 'raises and error if balance + top_up amount is greater than limit' do
      default_limit = Oystercard::DEFAULT_LIMIT
      subject.top_up default_limit
      expect { subject.top_up 1 }.to raise_error 'Max limit of #{default_limit} GBP reached'
    end
end