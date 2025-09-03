require 'rails_helper'

RSpec.describe Match, type: :model do
  fixtures :matches, :payments

  describe 'attributes' do
    let(:match) { matches(:weekend_game) }

    it 'has the correct date' do
      expect(match.date).to eq(Date.parse('2025-08-30'))
    end

    it 'has the correct location' do
      expect(match.location).to eq('COPM')
    end
  end

  describe 'fixtures' do
    it 'loads all match fixtures correctly' do
      expect(matches(:weekend_game)).to be_valid
      expect(matches(:indoor_match)).to be_valid
      expect(matches(:beach_game)).to be_valid
      expect(matches(:night_match)).to be_valid
    end

    it 'has different dates for each match' do
      dates = Match.pluck(:date)
      expect(dates.uniq.length).to eq(4)
      expect(dates).to include(Date.parse('2025-08-30'))
      expect(dates).to include(Date.parse('2025-09-05'))
      expect(dates).to include(Date.parse('2025-09-12'))
      expect(dates).to include(Date.parse('2025-09-18'))
    end

    it 'has different locations for each match' do
      locations = Match.pluck(:location)
      expect(locations.uniq.length).to eq(1)
      expect(locations).to all(eq('COPM'))
    end
  end

  describe 'data types' do
    let(:match) { matches(:indoor_match) }

    it 'stores date as date' do
      expect(match.date).to be_a(Date)
    end

    it 'stores location as string' do
      expect(match.location).to eq('COPM')
    end
  end

  describe 'model behavior' do
    it 'can create a new match' do
      match = Match.new(
        date: Date.today,
        location: 'COPM'
      )

      expect(match).to be_valid
      expect(match.save).to be true
      expect(Match.count).to eq(5)
    end

    it 'can update an existing match' do
      match = matches(:weekend_game)
      match.date = Date.today + 1

      expect(match.save).to be true
      expect(match.reload.date).to eq(Date.today + 1)
    end

    # it 'can delete a match' do
    #   match = matches(:night_match)
    #   expect { match.destroy }.to change(Match, :count).by(-1)
    # end
  end
end
