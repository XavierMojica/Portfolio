# Basketball Tournament Database

## Overview

This project contains a MySQL database for managing a sample basketball tournament system. The database tracks teams, coaches, players, tournaments, tournament matches, winning teams, and player scores.

The project is designed to demonstrate SQL database design, table relationships, primary keys, foreign keys, indexing, and seed data insertion.

## Project Structure

```text
basketball-tournament-database/
├── schema.sql
├── seed_data.sql
└── README.md
```

## Database Features

The database includes the following entities:

- Teams and coaches
- Players and team assignments
- Tournament dates and locations
- Tournament matchups
- Winning teams
- Player-level scoring data

## Tables

### Teams

Stores basketball team information, including team name and coach details.

### Players

Stores player information and links each player to a team.

### Tournaments

Stores tournament dates and locations.

### TourneyMatches

Stores individual games, including the tournament, home team, away team, and winning team.

### Scores

Stores player scores for each game.

## Database Schema

The project uses relational database principles, including:

- Primary keys for unique records
- Foreign keys to connect related tables
- Indexes to improve query performance
- One-to-many relationships between teams and players
- One-to-many relationships between tournaments and matches
- Many-to-many style scoring relationships between players and games

## How to Run

1. Open MySQL Workbench or another MySQL-compatible SQL client.

2. Run the schema file first:

```sql
SOURCE schema.sql;
```

3. Run the seed data file second:

```sql
SOURCE seed_data.sql;
```

Alternatively, you can copy and paste the SQL from each file directly into your SQL editor and execute it in order.

## Important Notes

This project uses sample basketball data for educational purposes. Any names or addresses included in the seed data should be treated as fictional sample data.



## Skills Demonstrated

This project demonstrates:

- SQL database design
- Relational schema creation
- Primary key and foreign key relationships
- Data normalization basics
- SQL indexing
- Insert statements and seed data loading
- Tournament and sports data modeling
- MySQL syntax and database setup

## Technologies Used

- MySQL
- SQL
- MySQL Workbench or compatible SQL client

## Future Improvements

Possible future improvements include:

- Add sample analytical queries
- Add views for tournament summaries
- Add stored procedures for inserting new games
- Add win/loss records by team
- Add player scoring averages
- Add ERD diagram
- Convert the project into a Dockerized MySQL setup

## Author

Xavier Mojica
