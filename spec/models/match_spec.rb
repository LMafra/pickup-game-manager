require 'rails_helper'

RSpec.describe Match, type: :model do
  fixtures :matches

  describe 'attributes' do
    let(:match) { matches(:weekend_game) }

    it 'has the correct date' do
      expect(match.date).to eq(Date.parse('2025-08-30'))
    end

    it 'has the correct location' do
      expect(match.location).to eq('Central Park')
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
      dates = [
        matches(:weekend_game).date,
        matches(:indoor_match).date,
        matches(:beach_game).date,
        matches(:night_match).date
      ]

      expect(dates.uniq.length).to eq(4)
    end

    it 'has different locations for each match' do
      locations = [
        matches(:weekend_game).location,
        matches(:indoor_match).location,
        matches(:beach_game).location,
        matches(:night_match).location
      ]

      expect(locations.uniq.length).to eq(4)
    end
  end

  describe 'data types' do
    let(:match) { matches(:indoor_match) }

    it 'stores date as date' do
      expect(match.date).to be_a(Date)
      expect(match.date).to eq(Date.parse('2025-09-05'))
    end

    it 'stores location as string' do
      expect(match.location).to be_a(String)
      expect(match.location).to eq('Sports Complex')
    end
  end

  describe 'model behavior' do
    it 'can create a new match' do
      match = Match.new(date: Date.today, location: 'Test Location')
      expect(match).to be_valid
      expect(match.save).to be true
    end

    it 'can update an existing match' do
      match = matches(:weekend_game)
      match.location = 'Updated Location'
      expect(match.save).to be true
      expect(match.reload.location).to eq('Updated Location')
    end
  end
end
