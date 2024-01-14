<kbd>:blossom: backend</kbd>

Backend for the [Unfoword](https://github.com/adhhl) application. Empowered by Ruby on Rails.

# Architecture

![image](https://github.com/adhhl/backend/assets/75170473/45623bf5-b7ee-4f99-a4a9-0a0e47651a61)

+ The backend communicates with the front-end to deliver data seamlessly.
+ Specifically for tasks related to card-related information calculations, it interfaces with the FSRS service.

## Why Ruby ♦️ and Rails?
+ **Ruby Language**: Known for its clean and readable syntax, Ruby makes coding enjoyable and less error-prone.
+ **Rails**: Rails API mode provides blazing fast, lightweight and efficient way to build APIs, ensuring seamless communication between your frontend and backend. 
  + The framework includes robust tools for serialization, making it simple to structure and format API responses.
  + Rails's active job allow to handle background processing seamlessly, enhancing performance and responsiveness.
  + Rails support action mailer for simplifies email handling, making it straightforward to incorporate email functionality into my [Unfoword](https://github.com/adhhl)
  
# Getting Started
### Presiquites
+ Ruby 3.2.2
+ Rails 7.0.8
+ MySQL 8.0.26
### Installation
1. Clone the repo
    ```sh
    $ git clone https://github.com/adhhl/backend.git
    $ cd backend
    ```
2. Check environment variables
    ```sh
    $ cp .env.example .env
    ```
    If you run the app locally, you should change the `DB_HOST` to "", also the `DB_USERNAME` and `DB_PASSWORD` to your local MySQL credentials.
    The socket path should be `/var/run/mysqld/mysqld.sock` for Linux and `/tmp/mysql.sock` for Mac.
    
> [!TIP]
> Run on Docker can keep the default values.
     
3. Install `bundle`
    ```sh
    $ gem install bundle
    ```
4. Install dependencies and run the server
    ```sh
    $ bundle install
    $ rails db:create
    $ rails db:migrate
    $ rails s
    ```
The server should be running on `localhost:3001` now.
### With Docker
```
$ cp .env.example .env
$ docker-compose up
```

# License
Distributed under the MIT License. See `LICENSE` for more information.
