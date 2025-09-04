# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# Clear existing data to ensure clean seeding
puts "🧹 Clearing existing data..."
AthleteMatch.destroy_all
Payment.destroy_all
Athlete.destroy_all
Match.destroy_all
Income.destroy_all
Expense.destroy_all

puts "👥 Creating athletes..."
athletes = {
  john_doe: {
    name: "John Doe",
    phone: 1234567890,
    date_of_birth: Date.parse("1990-05-15")
  },
  jane_smith: {
    name: "Jane Smith",
    phone: 9876543210,
    date_of_birth: Date.parse("1992-08-22")
  },
  mike_johnson: {
    name: "Mike Johnson",
    phone: 5551234567,
    date_of_birth: Date.parse("1988-12-10")
  },
  sarah_wilson: {
    name: "Sarah Wilson",
    phone: 7778889999,
    date_of_birth: Date.parse("1995-03-28")
  },
  alex_rodriguez: {
    name: "Alex Rodriguez",
    phone: 4445556666,
    date_of_birth: Date.parse("1993-07-14")
  },
  emma_davis: {
    name: "Emma Davis",
    phone: 1112223333,
    date_of_birth: Date.parse("1991-11-05")
  }
}

athletes.each do |key, attributes|
  Athlete.find_or_create_by!(name: attributes[:name]) do |athlete|
    athlete.phone = attributes[:phone]
    athlete.date_of_birth = attributes[:date_of_birth]
  end
  puts "  ✅ Created athlete: #{attributes[:name]}"
end

puts "🏟️ Creating matches..."
matches = {
  first_week: {
    date: Date.parse("2025-08-30"),
    location: "COPM"
  },
  second_week: {
    date: Date.parse("2025-09-05"),
    location: "COPM"
  },
  third_week: {
    date: Date.parse("2025-09-12"),
    location: "COPM"
  },
  fourth_week: {
    date: Date.parse("2025-09-18"),
    location: "COPM"
  }
}

matches.each do |key, attributes|
  Match.find_or_create_by!(date: attributes[:date], location: attributes[:location]) do |match|
    match.date = attributes[:date]
    match.location = attributes[:location]
  end
  puts "  ✅ Created match: #{attributes[:location]} on #{attributes[:date]}"
end

puts "🏷️ Creating transaction categories..."
transaction_categories = {
  daily: {
    name: "Daily",
    description: "Daily game participation income"
  },
  monthly: {
    name: "Monthly",
    description: "Monthly subscription income"
  }
}

transaction_categories.each do |key, attributes|
  TransactionCategory.find_or_create_by!(name: attributes[:name]) do |category|
    category.description = attributes[:description]
  end
  puts "  ✅ Created transaction category: #{attributes[:name]}"
end

puts "💰 Creating incomes..."
incomes = {
  daily: {
    transaction_category_name: "Daily",
    unit_value: 15.0,
    date: Date.parse("2025-08-15")
  },
  monthly: {
    transaction_category_name: "Monthly",
    unit_value: 35.0,
    date: Date.parse("2025-08-20")
  }
}

incomes.each do |key, attributes|
  transaction_category = TransactionCategory.find_by!(name: attributes[:transaction_category_name])
  Income.find_or_create_by!(transaction_category: transaction_category, date: attributes[:date]) do |income|
    income.unit_value = attributes[:unit_value]
    income.date = attributes[:date]
  end
  puts "  ✅ Created income: #{attributes[:transaction_category_name]} - $#{attributes[:unit_value]}"
end

puts "💸 Creating expenses..."
expenses = {
  food: {
    type: "Basic",
    description: "Field",
    unit_value: 650.0,
    quantity: 1,
    date: Date.parse("2025-08-15")
  },
  transportation: {
    type: "Intermediary",
    description: "Goalkeeper",
    unit_value: 50.0,
    quantity: 2,
    date: Date.parse("2025-08-16")
  },
  entertainment: {
    type: "Intermediary",
    description: "Football Vest",
    unit_value: 350.0,
    quantity: 1,
    date: Date.parse("2025-08-17")
  },
  utilities: {
    type: "Intermediary",
    description: "Football balls",
    unit_value: 150.0,
    quantity: 1,
    date: Date.parse("2025-08-18")
  },
  equipment: {
    type: "Advanced",
    description: "Barbecue",
    unit_value: 650.0,
    quantity: 1,
    date: Date.parse("2025-08-19")
  }
}

expenses.each do |key, attributes|
  Expense.find_or_create_by!(type: attributes[:type], description: attributes[:description], date: attributes[:date]) do |expense|
    expense.unit_value = attributes[:unit_value]
    expense.quantity = attributes[:quantity]
    expense.date = attributes[:date]
  end
  puts "  ✅ Created expense: #{attributes[:type]} - #{attributes[:description]} - $#{attributes[:unit_value]} x #{attributes[:quantity]}"
end

puts "🤝 Creating athlete matches..."
athlete_matches_data = [
  { athlete_name: "John Doe", match_location: "COPM", match_date: "2025-08-30" },
  { athlete_name: "Jane Smith", match_location: "COPM", match_date: "2025-09-05" },
  { athlete_name: "Mike Johnson", match_location: "COPM", match_date: "2025-09-12" },
  { athlete_name: "Sarah Wilson", match_location: "COPM", match_date: "2025-09-18" },
  { athlete_name: "John Doe", match_location: "COPM", match_date: "2025-09-05" },
  { athlete_name: "Jane Smith", match_location: "COPM", match_date: "2025-09-12" },
  { athlete_name: "Mike Johnson", match_location: "COPM", match_date: "2025-09-18" },
  { athlete_name: "Sarah Wilson", match_location: "COPM", match_date: "2025-08-30" },
  { athlete_name: "Alex Rodriguez", match_location: "COPM", match_date: "2025-08-30" },
  { athlete_name: "Emma Davis", match_location: "COPM", match_date: "2025-09-05" },
  { athlete_name: "Alex Rodriguez", match_location: "COPM", match_date: "2025-09-12" },
  { athlete_name: "Emma Davis", match_location: "COPM", match_date: "2025-09-18" }
]

athlete_matches_data.each do |data|
  athlete = Athlete.find_by!(name: data[:athlete_name])
  match = Match.find_by!(location: data[:match_location], date: data[:match_date])

  AthleteMatch.find_or_create_by!(athlete: athlete, match: match)
  puts "  ✅ Created athlete match: #{data[:athlete_name]} in #{data[:match_location]} on #{data[:match_date]}"
end

puts "💳 Creating payments..."
payments_data = [
  { athlete_name: "John Doe", match_location: "COPM", amount: 15.0, status: "paid", description: "First week game payment", transaction_category_name: "Daily" },
  { athlete_name: "Jane Smith", match_location: "COPM", amount: 15.0, status: "paid", description: "Second week game payment", transaction_category_name: "Daily" },
  { athlete_name: "Mike Johnson", match_location: "COPM", amount: 15.0, status: "pending", description: "Third week game payment", transaction_category_name: "Daily" },
  { athlete_name: "Sarah Wilson", match_location: "COPM", amount: 15.0, status: "paid", description: "Fourth week game payment", transaction_category_name: "Daily" },
  { athlete_name: "Alex Rodriguez", match_location: "COPM", amount: 15.0, status: "paid", description: "First week game payment", transaction_category_name: "Daily" },
  { athlete_name: "Emma Davis", match_location: "COPM", amount: 15.0, status: "pending", description: "Second week game payment", transaction_category_name: "Daily" }
]

payments_data.each do |data|
  athlete = Athlete.find_by!(name: data[:athlete_name])
  match = Match.find_by!(location: data[:match_location])
  transaction_category = TransactionCategory.find_by!(name: data[:transaction_category_name])

  Payment.find_or_create_by!(athlete: athlete, match: match) do |payment|
    payment.amount = data[:amount]
    payment.status = data[:status]
    payment.description = data[:description]
    payment.date = match.date
    payment.transaction_category = transaction_category
  end
  puts "  ✅ Created payment: #{data[:athlete_name]} - $#{data[:amount]} (#{data[:status]}) for #{data[:match_location]}"
end

puts ""
puts "🎉 Database seeding completed successfully!"
puts ""
puts "📊 Summary:"
puts "  🏷️ Transaction Categories: #{TransactionCategory.count}"
puts "  👥 Athletes: #{Athlete.count}"
puts "  🏟️ Matches: #{Match.count}"
puts "  💰 Incomes: #{Income.count}"
puts "  💸 Expenses: #{Expense.count}"
puts "  🤝 Athlete Matches: #{AthleteMatch.count}"
puts "  💳 Payments: #{Payment.count}"
puts ""
puts "🚀 You can now test your application with realistic data!"
puts "💡 Use 'bin/rails db:seed' to re-run this anytime."
