require 'Station'

describe Station do
let(:station) { double('station', :name => 'Camden', :zone => 2)}
it 'Station zone is 2' do
 expect(station.zone).to eq 2 
 end

 it 'Station has a name' do
expect(station.name).to eq 'Camden'
end
end