# Manga Project
This is a Ruby on Rails application for managing manga collections, user comments, and admin functionalities. The app includes features like user authentication, role-based access control, comment editing, and more.

#Table of Contents
- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [Endpoints](#endpoints)
- [Error Handling](#error-handling)
- [Contributing](#contributing)
- [License](#license)

## Features

- User Authentication: Managed with Devise, users can sign up, log in, and manage their accounts.
- Role Management: Using Rolify, users are assigned roles (e.g., admin, user).
- Manga Management: Admins can add, edit, and delete manga entries.
- Commenting System: Users can leave comments on manga entries.
- Comments can be edited, and edited comments are marked with an "edited" indicator.
- A "View More" and "View Less" functionality displays the first 5 comments with options to load more.
- Admin Panel: Admins can manage users and manga.
- Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/manga_project.git
cd manga_project
```
2. Install dependencies:
```bash
bundle install
```
3. Set up the database:
```bash
rails db:create
rails db:migrate
```
4. Seed the database with default roles and admin users:
```bash
rails db:seed
```
5. Start the server:
```bash
rails server
```
6. Visit http://localhost:3000 in your browser to use the app.

# Usage
- User Registration and Login: Users can sign up and log in to access the application.
- Admin Access: Admin users have additional privileges like managing manga and users.
- Commenting: Users can leave comments on manga entries, with the option to edit them.

# Roles
- Admin: Full access to all features, including user and manga management.
- Default Admins:
- Email: admincarloz@manga.com, Password: mangas
- Email: admintrisha@manga.com, Password: password
- User: Can view and comment on manga entries.

# Comment Management
- View More/Less: Initially, 5 comments are shown. Users can click "View More" to load additional comments or "View Less" to collapse them.
- Edited Indicator: If a comment is edited, it will display an "edited" label next to the timestamp.

## Contributing
If you'd like to contribute to this project, please fork the repository and submit a pull request. We welcome improvements and fixes!

## License
This project is licensed under the MIT License. See the LICENSE file for details.