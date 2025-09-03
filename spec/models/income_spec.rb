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

  describe 'attributes' do
    let(:income) { incomes(:salary) }

    it 'has the correct type' do
      expect(income.type).to eq('Salary')
    end

    it 'has the correct unit_value' do
      expect(income.unit_value).to eq(2500.0)
    end

    it 'has the correct date' do
      expect(income.date).to eq(Date.parse('2025-08-15'))
    end
  end

  describe 'fixtures' do
    it 'loads all income fixtures correctly' do
      expect(incomes(:salary)).to be_valid
      expect(incomes(:bonus)).to be_valid
      expect(incomes(:freelance)).to be_valid
    end

    it 'has different income types' do
      types = Income.pluck(:type)
      expect(types).to include('Salary', 'Bonus', 'Freelance')
    end

    it 'has different income amounts' do
      amounts = Income.pluck(:unit_value)
      expect(amounts).to include(2500.0, 500.5, 120.75)
    end
  end

  describe 'data types' do
    let(:income) { incomes(:bonus) }

    it 'stores type as string' do
      expect(income.type).to be_a(String)
      expect(income.type).to eq('Bonus')
    end

    it 'stores unit_value as float' do
      expect(income.unit_value).to be_a(Float)
      expect(income.unit_value).to eq(500.5)
    end

    it 'stores date as date' do
      expect(income.date).to be_a(Date)
      expect(income.date).to eq(Date.parse('2025-08-20'))
    end
  end

  describe 'model behavior' do
    it 'can create a new income' do
      income = Income.new(type: 'Commission', unit_value: 750.0, date: Date.today)
      expect(income).to be_valid
      expect(income.save).to be true
    end

    it 'can update an existing income' do
      income = incomes(:salary)
      income.unit_value = 3000.0
      expect(income.save).to be true
      expect(income.reload.unit_value).to eq(3000.0)
    end
  end
end
