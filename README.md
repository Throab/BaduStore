# BaduStore

A full-stack e-commerce web application built with ASP.NET Core Web API and Angular.

## Features

- User authentication with JWT
- Google Login
- Product management
- Category & Brand management
- Shopping cart using Redis
- Order management
- User profile management
- Cloudinary image upload

## Tech Stack

### Backend

- ASP.NET Core Web API
- Entity Framework Core
- SQL Server
- Redis
- JWT Authentication

### Frontend

- Angular 19
- TypeScript
- RxJS
- NG-ZORRO

### Others

- Docker Compose
- Cloudinary

## Project Structure

```
BaduStore
├── App/              # Angular Frontend
├── Service/          # ASP.NET Core Web API
├── docker-compose.yml
└── README.md
```

## Getting Started

### Clone repository

```bash
git clone https://github.com/Throab/BaduStore.git
```

## Database Configuration

1. Update the SQL Server connection string:

```json
{
  "ConnectionStrings": {
    "ConnectionString": "Server=SERVER;Database=DATABASE;User Id=sa;Password=YourPassword;TrustServerCertificate=True;"
  }
}
```

2. Execute the database script:

```
Script.sql
```

### Backend

```bash
cd Service
dotnet restore
dotnet run
```

### Frontend

```bash
cd App
npm install
ng serve
```

### Redis

```bash
docker compose up -d
```

## Main Technologies

- ASP.NET Core
- Angular
- SQL Server
- Entity Framework Core
- Redis
- JWT
- Cloudinary
- Docker

## Author

Nguyen Bao
