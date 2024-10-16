# API Endpoint Project

This project is a Ruby on Rails API application that allows users to create, update, delete, and fetch articles, along with user authentication using JWT (JSON Web Token).

## Features

- User registration and login with JWT authentication.
- Create, read, update, and delete articles.
- Association between users and articles (each article belongs to a user).
- API secured with JWT for authenticated requests.

## Requirements

- Ruby 3.x
- Rails 7.x
- PostgreSQL
- Docker (optional for containerized deployment)

## Installation

### 1. Clone the Repository

First, clone this repository to your local machine:

```bash
git clone https://github.com/your-username/project-api.git

```
### 2. Install Dependencies

Navigate to the project directory and install the required gems:

```bash
cd project-api
bundle install
```
### 3. Set Up the Database

Run the following commands to create and migrate the PostgreSQL database:

```bash
rails db:create
rails db:migrate
```
### 4. Environment Variables

Ensure you have the following environment variables set up in a .env file:

```bash
JWT_SECRET=your_jwt_secret_key
PG_HOST=your_database_host
PG_PORT=your_database_port
PG_USERNAME=your_database_username
PG_PASSWORD=your_database_password
PG_DATABASE=your_database
PG_SSLMODE=your_database&require

```
### 5. Run the Rails Server

You can now start the Rails server:

```bash
rails server
```
The application will be running on http://localhost:3000.


## API ENDPOINTS

#### User Sign-up
Description: Registers a new user 

```http
  GET /users/signup
  
```

| Parametre | Tip     | 
| :-------- | :------- | 
| `email` | `string` | 
| `name` | `string` | 
| `password` | `string` | 

#### Öğeyi getir

```http
  GET /users/login
```
Description: Authenticates a user and returns a JWT token.
| Parametre | Tip     | 
| :-------- | :------- | 
| `email`      | `string` | 
| `password`      | `string` | 


#### add(num1, num2)

İki sayı alır ve toplamı döndürür.

## Articles

#### Get All Articles
Description: Fetches all articles.

```http
  GET /articles
```

``` json
 [
  {
    "id": 1,
    "title": "My First Article",
    "body": "This is the body of my first article",
    "user": {
      "id": 1,
      "email": "user@example.com"
    }
  }
]
```


#### Create an Article
Description: Creates a new article. Requires a valid JWT token.

```http
  POST /articles
```

``` bash
Authorization: Bearer <JWT_TOKEN>

```
### request body
```  json
{
  "title": "New Article",
  "body": "Content of the article"
}
```
### response 
```  json
{
  "id": 2,
  "title": "New Article",
  "body": "Content of the article",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

#### Update an Article
Description: Updates an existing article. Requires a valid JWT token.

```http
  PUT /articles/:id
```

``` bash
Authorization: Bearer <JWT_TOKEN>

```
### request body
```  json
{
  "title": "Updated Article",
  "body": "Updated content of the article"
}
```
### response 
```  json
{
  "id": 1,
  "title": "Updated Article",
  "body": "Updated content of the article",
  "user": {
    "id": 1,
    "email": "user@example.com"
  }
}
```

#### Delete an Article
Description: Deletes an article. Requires a valid JWT token.

```http
  DELETE /articles/:id
```

``` bash
Authorization: Bearer <JWT_TOKEN>

```
### response 
```  json
{
  "message": "Article deleted successfully."
}
```
