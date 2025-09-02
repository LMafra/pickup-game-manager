require 'rails_helper'

RSpec.describe Expense, type: :model do
  fixtures :expenses

  describe 'validations' do
    it 'is valid with valid attributes (from fixtures)' do
      expect(expenses(:food)).to be_valid
      expect(expenses(:transportation)).to be_valid
      expect(expenses(:entertainment)).to be_valid
      expect(expenses(:utilities)).to be_valid
    end

    it 'requires type' do
      expense = Expense.new(description: 'Test expense', unit_value: 10.0, date: Date.today)
      expect(expense).not_to be_valid
      expect(expense.errors[:type]).to include("can't be blank")
    end

    it 'requires description' do
      expense = Expense.new(type: 'Food', unit_value: 10.0, date: Date.today)
      expect(expense).not_to be_valid
      expect(expense.errors[:description]).to include("can't be blank")
    end

    it 'requires unit_value' do
      expense = Expense.new(type: 'Food', description: 'Test expense', date: Date.today)
      expect(expense).not_to be_valid
      expect(expense.errors[:unit_value]).to include("can't be blank")
    end

    it 'requires date' do
      expense = Expense.new(type: 'Food', description: 'Test expense', unit_value: 10.0)
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("can't be blank")
    end
  end

  describe 'attributes' do
    let(:expense) { expenses(:food) }

    it 'has the correct type' do
      expect(expense.type).to eq('Food')
    end

    it 'has the correct description' do
      expect(expense.description).to eq('Grocery shopping')
    end

    it 'has the correct unit_value' do
      expect(expense.unit_value).to eq(85.50)
    end

    it 'has the correct date' do
      expect(expense.date).to eq(Date.parse('2025-08-15'))
    end
  end
end
