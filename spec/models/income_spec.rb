require 'rails_helper'

RSpec.describe Income, type: :model do
  fixtures :incomes

  describe 'validations' do
    it 'is valid with valid attributes (from fixtures)' do
      expect(incomes(:salary)).to be_valid
      expect(incomes(:bonus)).to be_valid
      expect(incomes(:freelance)).to be_valid
    end

    it 'requires type' do
      income = Income.new(unit_value: 10.0, date: Date.today)
      expect(income).not_to be_valid
      expect(income.errors[:type]).to include("can't be blank")
    end

    it 'requires unit_value' do
      income = Income.new(type: 'Salary', date: Date.today)
      expect(income).not_to be_valid
      expect(income.errors[:unit_value]).to include("can't be blank")
    end

    it 'requires date' do
      income = Income.new(type: 'Salary', unit_value: 10.0)
      expect(income).not_to be_valid
      expect(income.errors[:date]).to include("can't be blank")
    end
  end
end
