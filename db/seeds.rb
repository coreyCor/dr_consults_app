puts "Seeding users..."

# Create users
admin = User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password",
  user_role: User::ADMIN_ROLE,
  daily_consult_limit: 10,
  cooldown_minutes: 60,
  available_start_time: "08:00",
  available_end_time: "18:00"
)

user1 = User.create!(
  name: "Dr. Alice",
  email: "alice@example.com",
  password: "password",
  user_role: User::USER_ROLE,
  daily_consult_limit: 5,
  cooldown_minutes: 60,
  available_start_time: "09:00",
  available_end_time: "17:00"
)

user2 = User.create!(
  name: "Dr. Bob",
  email: "bob@example.com",
  password: "password",
  user_role: User::USER_ROLE,
  daily_consult_limit: 5,
  cooldown_minutes: 60,
  available_start_time: "10:00",
  available_end_time: "16:00"
)

puts "Seeding consults..."

# Create some consults
Consult.create!(
  title: "Patient A - Chest Pain",
  body: "What would you recommend for patient A with chest pain?",
  asked_by: user1,
  assigned_to: user2,
  consult_status: Consult::STATUS_PENDING,
  assigned_at: Time.now
)

Consult.create!(
  title: "Patient B - Geriatrics",
  body: "Any suggestions for medication adjustment in geriatric patient B?",
  asked_by: user2,
  assigned_to: user1,
  consult_status: Consult::STATUS_PENDING,
  assigned_at: Time.now
)

puts "Seeding complete!"
