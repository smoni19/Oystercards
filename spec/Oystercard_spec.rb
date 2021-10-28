require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new }
  #let(:station){ double 'station' }
  let(:station) { double('station', :name => 'Camden', :zone => 2)}

  it 'initialises with a balance of 0' do
    expect(subject.balance).to eq 0
  end
    describe '#top_up' do
      it 'increases balance by amount given' do
        expect { subject.top_up(10) }.to change { subject.balance }.by(10)
      end
    end
    it 'has a maximum limit of 90' do
      expect(subject.limit).to eq 90
    end

    it 'raises an error if balance + #top_up amount is greater than limit' do
      subject.top_up(Oystercard::DEFAULT_LIMIT)
      expect { subject.top_up 1 }.to raise_error "Max limit of #{Oystercard::DEFAULT_LIMIT} GBP reached"
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

    describe '#touch_in' do
      it 'changes in_use to true' do
        subject.top_up(10)
        expect { subject.touch_in(station, 2) }.to change { subject.entry_station }.from(nil).to(station)
      end
      it 'doesn\'t allow user to touch in when balance is less than 1 pound' do
        expect { subject.touch_in(station, 2) }.to raise_error 'Please top up'
      end
      it 'takes a station argument and changes entry_station to it' do
        subject.top_up(10)
        expect { subject.touch_in(station, 2) }.to change { subject.entry_station }.to station
      end
    end

    describe '#touch_out' do
      before { subject.top_up(10) }
      before { subject.touch_in(station, 2) }
      it 'changes entry_station to nil' do
        expect { subject.touch_out(station, 2) }.to change { subject.entry_station }.from(station).to(nil)
      end
      it 'deducts fare from balance' do
        expect { subject.touch_out(station, 2) }.to change { subject.balance }.by(-1)
      end
    end

    describe '#in_journey?' do
      it 'returns true if touched in' do
        subject.top_up(10)
        subject.touch_in(station, 2)
        expect(subject).to be_in_journey
      end
    end

    it 'card has an empty list of journeys by default' do
      expect(subject.all_journeys).to be_empty
    end

    it 'creates one journey when touching in and out' do
      subject.top_up(10)
      subject.touch_in(station, 2)
      subject.touch_out(station, 2)
      subject.touch_in(station, 2)
      subject.touch_out(station, 2)
      expect(subject.all_journeys.length).to eq 2
    end
end