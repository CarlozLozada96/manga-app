# db/seeds.rb

# Create default roles
admin_role = Role.find_or_create_by(name: 'admin')
user_role = Role.find_or_create_by(name: 'user')

# Create default admin user
admin1 = User.find_or_create_by(email: 'admincarloz@manga.com') do |user|
  user.password = 'mangas'
  user.password_confirmation = 'mangas'
  user.add_role :admin
end

admin2 = User.find_or_create_by(email: 'admintrisha@manga.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.add_role :admin
end

reader1 = User.find_or_create_by(email: 'user1@email.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
  user.add_role :user
end
