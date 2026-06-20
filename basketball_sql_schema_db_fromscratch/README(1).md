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

## Suggested File Naming

Before publishing to GitHub, rename the original files for clarity:

```text
Basketball SetUP2.sql        -> schema.sql
Basketball_InsertData(1).sql -> seed_data.sql
```

Avoid spaces, parentheses, and inconsistent capitalization in file names.

## Important Notes

This project uses sample basketball data for educational purposes. Any names or addresses included in the seed data should be treated as fictional sample data.

If publishing publicly, consider replacing address fields with generic sample values such as:

```text
Address 001
Sample City
ST
00000
```

## Recommended Fixes Before Publishing

Before uploading this project to GitHub, review the following items:

### 1. Rename `TurneyLocation`

The column name `TurneyLocation` appears to be a typo. It should be renamed to:

```sql
TourneyLocation
```

### 2. Fix the `ALTER TABLE TourneyMatches` statement

The foreign key section should be written as one complete statement:

```sql
ALTER TABLE TourneyMatches
ADD CONSTRAINT TourneyMatches_FK00 FOREIGN KEY (HomeTeam) REFERENCES Teams(TeamID),
ADD CONSTRAINT TourneyMatches_FK01 FOREIGN KEY (AwayTeam) REFERENCES Teams(TeamID),
ADD CONSTRAINT TourneyMatches_FK02 FOREIGN KEY (WinningTeam) REFERENCES Teams(TeamID);
```

### 3. Add a composite primary key to `Scores`

To prevent duplicate score records for the same player in the same game, consider updating the `Scores` table:

```sql
CREATE TABLE Scores (
    GameID int NOT NULL,
    PlayerID int NOT NULL,
    PlayerScore int NULL DEFAULT 0,
    PRIMARY KEY (GameID, PlayerID),
    FOREIGN KEY (GameID) REFERENCES TourneyMatches(GameID),
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID)
);
```

### 4. Add a warning above `DROP DATABASE`

The schema file recreates the database, so add a warning comment:

```sql
-- WARNING: This script drops and recreates the BasketBall database.
DROP DATABASE IF EXISTS BasketBall;
CREATE DATABASE BasketBall;
USE BasketBall;
```

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
