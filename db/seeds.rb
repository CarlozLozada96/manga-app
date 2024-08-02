# db/seeds.rb

# Create default roles
admin_role = Role.find_or_create_by(name: 'admin')
user_role = Role.find_or_create_by(name: 'user')

# Create default admin user
admin = User.find_or_create_by(email: 'admincarloz@manga.com') do |user|
  user.password = 'mangas'
  user.password_confirmation = 'mangas'
  user.add_role :admin
end
