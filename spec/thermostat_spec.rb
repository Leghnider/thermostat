require 'thermostat'

describe Thermostat do
    describe '#temperature' do
        it 'has a default temperature of 20 degrees' do
            expect(subject.temperature).to eq Thermostat::DEFAULT_TEMP
        end
    end
    
    describe '#up' do
        it 'can increase the temperature' do
            subject.up
            expect(subject.temperature).to eq 21
        end

        context 'power saving on'
            it 'has a maximum of 25 degrees' do
                6.times { subject.up }
                expect(subject.temperature).to eq 25
            end
        
        context 'power saving off'
            it 'has a maximum of 32 degrees' do
                subject.psm_off
                12.times { subject.up }
                expect(subject.temperature).to eq 32
            end
    end

    describe '#down' do
        it 'can decrease the temperature' do
            subject.down
            expect(subject.temperature).to eq 19
        end

        it 'has a minimum temperature' do
            11.times { subject.down }
            expect(subject.temperature).to eq 10
        end
    end

    describe '#reset' do
        it 'resets the temperature to 20' do
            subject.up
            expect(subject.temperature).to eq 21
            subject.reset
            expect(subject.temperature).to eq 20
        end
    end

    describe '#in_power_saving_mode?' do
        it 'is in power saving mode by default' do
            expect(subject).to be_in_power_saving_mode
        end

        it 'switches power saving mode off' do
            subject.psm_off
            expect(subject).not_to be_in_power_saving_mode
        end

        it 'switches power saving mode on' do 
            subject.psm_off
            subject.psm_on
            expect(subject).to be_in_power_saving_mode
        end
    end


    describe "#energy_usage" do
        context "temperature is below 18 degrees" do
        it "has low energy usage" do
            subject.down
            subject.down
            subject.down
            expect(subject.energy_usage).to eq :low
        end
    end

    context "temperature is between 18 and 25 degrees" do
      it "has low energy usage" do
        expect(subject.energy_usage).to eq :medium
      end
    end

    context "temperature is 25 or more degrees" do
      it "has low energy usage" do
        5.times { subject.up }
        expect(subject.energy_usage).to eq :high
      end
    end
  end
end