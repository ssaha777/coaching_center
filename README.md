# Coaching Center API

This Rails API application serves as a backend system for managing courses and tutors. It utilizes Active Record for database management and Active Model Serializers for JSON serialization.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Ruby (version 2.7.6)
- Rails (version 7.0.8.4)
- Bundler (if not already installed, you can install it using `gem install bundler`)
- sqlite3


## Getting Started

To get started with this application, follow these steps:

1. Clone this repository to your local machine:

   ```bash
   git clone https://github.com/ssaha777/coaching_center.git

2. Navigate to the project directory:

   ```bash
   cd coaching_center

3. Install dependencies:

    ```bash
    bundle install

4. Database setup:

    ```bash
    rake db:create
    rake db:migrate

5. Run the Rails server

    ```bash
    rails server

## Testing

To test the API endpoints and models run:

    rspec
