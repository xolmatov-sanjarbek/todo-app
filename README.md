# Todo App

A modern, user-friendly todo application built with **Ruby on Rails 8** and styled with **Tailwind CSS**. Organize your tasks efficiently with project-based grouping, user authentication, and a responsive web interface.

## ✨ Features

- **User Authentication**: Secure sign-up and login with password hashing using bcrypt
- **Project Organization**: Group todos into projects for better organization
- **Todo Management**: Create, edit, update, and delete todos with priority levels and descriptions
- **Priority Levels**: Assign priority to tasks for better task management
- **Responsive Design**: Beautiful, mobile-friendly UI built with Tailwind CSS
- **Real-time Updates**: Powered by Hotwire (Turbo Rails + Stimulus) for smooth interactions
- **User Sessions**: Persistent login sessions with secure cookie handling

## 🛠️ Tech Stack

- **Framework**: Rails 8.1
- **Database**: PostgreSQL
- **Frontend**:
  - Tailwind CSS for styling
  - Hotwire (Turbo Rails + Stimulus) for dynamic interactions
  - ESM import maps for JavaScript modules
- **Authentication**: bcrypt with has_secure_password
- **Testing**: Rails default testing framework
- **Deployment**: Docker-ready with Kamal support
- **Background Jobs**: Solid Queue
- **Caching**: Solid Cache
- **Real-time Communication**: Solid Cable

## 📋 Prerequisites

- Ruby 3.2+ (see `.ruby-version`)
- PostgreSQL 12+
- Node.js 18+ (for asset compilation)
- Bundler

## 🚀 Getting Started

### 1. Clone and Setup

```bash
git clone <repository-url>
cd todo_app
bundle install
```

### 2. Database Setup

```bash
# Create, migrate, and seed the database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### 3. Start the Development Server

```bash
# Using the dev script (includes Tailwind CSS watching)
bin/dev

# Or manually start Puma:
bin/rails server
```

The app will be available at `http://localhost:3000`

## 📁 Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── todos_controller.rb
│   ├── projects_controller.rb
│   ├── sessions_controller.rb
│   ├── sign_ups_controller.rb
│   └── passwords_controller.rb
├── models/
│   ├── user.rb
│   ├── todo.rb
│   ├── project.rb
│   └── session.rb
├── views/
│   ├── todos/
│   ├── projects/
│   ├── sessions/
│   ├── sign_ups/
│   └── layouts/
└── javascript/
    └── controllers/

config/
├── routes.rb          # Route definitions
├── database.yml       # Database config
└── environments/      # Rails environment configs

db/
├── migrate/           # Database migrations
├── schema.rb          # Current database schema
└── seeds.rb           # Seed data

test/                  # Test suite
```

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the project root (if needed for custom config):

```bash
# Database
DATABASE_URL=postgresql://user:password@localhost:5432/todo_app_dev
```

### Database Configuration

Edit `config/database.yml` to configure your PostgreSQL connection.

## 🧪 Running Tests

```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/controllers/todos_controller_test.rb

# Run with verbose output
bin/rails test --verbose
```

## 📦 Database Schema

### Users Table

- `id`: Primary key
- `email`: Unique email address
- `password_digest`: Hashed password
- `created_at`, `updated_at`: Timestamps

### Projects Table

- `id`: Primary key
- `user_id`: Foreign key to users
- `name`: Project name
- `created_at`, `updated_at`: Timestamps

### Todos Table

- `id`: Primary key
- `user_id`: Foreign key to users
- `project_id`: Optional foreign key to projects
- `name`: Todo title
- `description`: Detailed description
- `priority`: Priority level (1-5)
- `completed`: Completion status (boolean)
- `created_at`, `updated_at`: Timestamps

## 🔑 Key Models & Relationships

**User**

- `has_many :todos`
- `has_many :projects`

**Project**

- `belongs_to :user`
- `has_many :todos`

**Todo**

- `belongs_to :user`
- `belongs_to :project` (optional)

## 🛣️ API Routes

```
GET    /                          # Home page (todos index)
GET    /projects                  # List all projects
POST   /projects                  # Create project
GET    /projects/:id              # Show project with todos
PATCH  /projects/:id              # Update project
DELETE /projects/:id              # Delete project

GET    /projects/:project_id/todos # List todos in project
GET    /projects/:project_id/todos/new
POST   /projects/:project_id/todos # Create todo in project

GET    /todos/:id                 # Show todo details
GET    /todos/:id/edit            # Edit todo
PATCH  /todos/:id                 # Update todo
DELETE /todos/:id                 # Delete todo

GET    /sign_up                   # Sign up form
POST   /sign_up                   # Create new user
GET    /session                   # Login form
POST   /session                   # Create session
DELETE /session                   # Logout
```

## 🚢 Deployment

This application is Docker-ready and can be deployed using Kamal:

```bash
# Build and deploy
kamal deploy

# View logs
kamal logs
```

For traditional servers, use:

```bash
RAILS_ENV=production bundle install --no-development
RAILS_ENV=production bin/rails db:migrate
RAILS_ENV=production bin/rails assets:precompile
bundle exec puma -t 5:5 -p 3000
```

## 🐛 Troubleshooting

### Database connection issues

```bash
# Check PostgreSQL is running and accessible
psql -U postgres -h localhost

# Reset database
bin/rails db:drop db:create db:migrate db:seed
```

### Asset compilation issues

```bash
# Clear compiled assets
bin/rails assets:clobber

# Recompile
bin/rails assets:precompile
```

### Port already in use

```bash
# Use a different port
bin/rails server -p 3001
```

## 📝 License

This project is open source and available under the MIT License.

## 👨‍💻 Contributing

1. Create a feature branch (`git checkout -b feature/amazing-feature`)
2. Commit your changes (`git commit -m 'Add amazing feature'`)
3. Push to the branch (`git push origin feature/amazing-feature`)
4. Open a Pull Request

## 📞 Support

For issues or questions, please open an issue in the repository.
