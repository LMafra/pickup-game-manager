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

  describe 'fixtures' do
    it 'loads all expense fixtures correctly' do
      expect(expenses(:food)).to be_valid
      expect(expenses(:transportation)).to be_valid
      expect(expenses(:entertainment)).to be_valid
      expect(expenses(:utilities)).to be_valid
    end

    it 'has different expense types' do
      types = Expense.pluck(:type)
      expect(types).to include('Food', 'Transportation', 'Entertainment', 'Utilities')
    end

    it 'has different expense amounts' do
      amounts = Expense.pluck(:unit_value)
      expect(amounts).to include(85.50, 45.00, 24.00, 120.75)
    end
  end

  describe 'data types' do
    let(:expense) { expenses(:transportation) }

    it 'stores type as string' do
      expect(expense.type).to be_a(String)
      expect(expense.type).to eq('Transportation')
    end

    it 'stores description as string' do
      expect(expense.description).to be_a(String)
      expect(expense.description).to eq('Gas for car')
    end

    it 'stores unit_value as float' do
      expect(expense.unit_value).to be_a(Float)
      expect(expense.unit_value).to eq(45.00)
    end

    it 'stores date as date' do
      expect(expense.date).to be_a(Date)
      expect(expense.date).to eq(Date.parse('2025-08-20'))
    end
  end

  describe 'model behavior' do
    it 'can create a new expense' do
      expense = Expense.new(type: 'Healthcare', description: 'Doctor visit', unit_value: 75.0, date: Date.today)
      expect(expense).to be_valid
      expect(expense.save).to be true
    end

    it 'can update an existing expense' do
      expense = expenses(:food)
      expense.unit_value = 95.0
      expect(expense.save).to be true
      expect(expense.reload.unit_value).to eq(95.0)
    end
  end
end
