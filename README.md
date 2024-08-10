# Home Page
![Manga Heart](https://media.discordapp.net/attachments/1055486048953696408/1271539536492494868/image.png?ex=66b7b4f9&is=66b66379&hm=cd1d8a5c9bb6d3a0f37ae9247397dc764761ec3a5db4888be76cc638d42c55fe&=&format=webp&quality=lossless&width=1399&height=676)
# Manga Details
![Manga Heart2](https://media.discordapp.net/attachments/1055486048953696408/1271539781775659169/image.png?ex=66b7b534&is=66b663b4&hm=375c90276ca782797a21b229fa63d54046dcbc3b2aadcd15bc7f025acc0a2ca2&=&format=webp&quality=lossless&width=1343&height=676)
# Comments
![Manga Heart 3](https://media.discordapp.net/attachments/1055486048953696408/1271540586444488786/image.png?ex=66b7b5f3&is=66b66473&hm=bb45a605ef34817d5de33ba945b69fa4c4a320170939358aecd5d44c5238ff12&=&format=webp&quality=lossless&width=1321&height=676)
# Manga View 
![Manga Heart 4](https://media.discordapp.net/attachments/1055486048953696408/1271540860932198451/image.png?ex=66b7b635&is=66b664b5&hm=8bb0aa12342066489645218237f0f23c4f655df891bf8ed4ecaf90d3c598954e&=&format=webp&quality=lossless&width=1421&height=676)

# Manga Heart
This is a Ruby on Rails application for managing manga collections, user comments, and admin functionalities. The app includes features like user authentication, role-based access control, comment editing, and more, with the goal of providing you a better manga reading experience from THE HEART.

Note: This is a non-profit application that makes use of the [MangaDex API] (https://api.mangadex.org), so there are limitation in viewing the image during live deployment, but otherwise there are no problems in viewing the images on the local machine.

# Table of Contents
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
git clone https://github.com/CarlozLozada96/manga-app.git
```
```bash
cd manga_app
```
2. Install dependencies:
```bash
bundle install
```
3. Set up the database:
```bash
rails db:create
```
```bash
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
- Viewing chapters: Users can view chapter pages either as a single page view or a multiple page veiw with pagination.

# Roles
- Admin: Full access to all features, including user and manga management.
- Admins: Can view and comment on manga entries, and can also ban users.
- User: Can view and comment on manga entries.

# Comment Management
- View More/Less: Initially, 5 comments are shown. Users can click "View More" to load additional comments or "View Less" to collapse them.
- Edited Indicator: If a comment is edited, it will display an "edited" label next to the timestamp.

## Contributing
If you'd like to contribute to this project, please fork the repository and submit a pull request. We welcome improvements and fixes!

## License
This project is licensed under the MIT License. See the LICENSE file for details.
