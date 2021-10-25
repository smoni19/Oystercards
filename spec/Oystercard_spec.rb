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

    # commented out because its now managed by touch in
    #
    # describe 'deduct' do
    #   it 'deducts money from oystercard' do
    #     oystercard = Oystercard.new
    #     subject.top_up(10)
    #     expect { subject.deduct(5) }.to change { subject.balance }.by(-5)
    #   end
    # end

    describe 'touch_in' do
      it 'it changes in use to true' do
        oystercard = Oystercard.new
        subject.top_up(10)
        expect { subject.touch_in }.to change { subject.in_use }.from(false).to(true)
      end
      it 'doesn/t allow user to touch in when balance is less than 1 pound' do
        oystercard = Oystercard.new
        expect { subject.touch_in }.to raise_error 'Please top up'
      end
    end

    describe 'touch_out' do
      it 'it changes in use to false' do
        oystercard = Oystercard.new
        subject.top_up(10)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.in_use }.from(true).to(false)
      end
    end

    describe 'in_journey?' do
      it 'returns true if touched in' do
        oystercard = Oystercard.new
        subject.top_up(10)
        subject.touch_in
        expect(subject).to be_in_journey
      end
    end
end