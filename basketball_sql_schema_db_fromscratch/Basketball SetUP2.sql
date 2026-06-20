DROP DATABASE IF EXISTS BasketBall; 

CREATE DATABASE BasketBall;

use BasketBall;



CREATE TABLE Teams (
	TeamID int NOT NULL PRIMARY KEY, 
    TeamName varchar (25) NULL, 
    CoachFirstName varchar (25) NULL, 
    CoachLastName varchar (25) NULL
);

CREATE TABLE Tournaments (
	TourneyID int NOT NULL PRIMARY KEY, 
    TourneyDate date NULL, 
    TourneyLocation char (45) NULL 
);

CREATE TABLE TourneyMatches (
	GameID int  NOT NULL PRIMARY KEY,
	TourneyID int NOT NULL,
    Foreign Key(TourneyID) References Tournaments(TourneyID),
   # GameID int NOT NULL,
    #Foreign Key(GameID) References Scores(GameID),  #added this foreign key 
	HomeTeam int NOT NULL DEFAULT 0 ,
	AwayTeam int NOT NULL DEFAULT 0, 
    WinningTeam int NOT NULL DEFAULT 0
);

CREATE TABLE Players (
	PlayerID int NOT NULL PRIMARY KEY ,
	PlayerFirstName varchar (25) NULL ,
	PlayerLastName varchar (25) NULL ,
	PlayerAddress varchar (50) NULL, 
	PlayerCity varchar (30) NULL ,
	PlayerState varchar (2) NULL ,
	PlayerZip varchar (10) NULL, 
    TeamID int NOT NULL, 
    Foreign Key (TeamID) References Teams(TeamID) #added this foreign key 
);

CREATE TABLE Scores (
	#GameID int NOT NULL DEFAULT 0 PRIMARY KEY,  #added primary key to GAMEID
    GameID int NOT NULL DEFAULT 0, 
    Foreign Key (GameID) References TourneyMatches(GameID), #added this foreign key 
	PlayerID int NULL DEFAULT 0 ,
    Foreign Key (PlayerID) References Players(PlayerID), #added this foreign key 
	PlayerScore int NULL DEFAULT 0
);








CREATE  INDEX PlayerTeamID ON Players(TeamID) ;
CREATE  INDEX PlayerID ON Scores(PlayerID) ;
CREATE  INDEX PlayerLastName ON Players(PlayerLastName) ;
CREATE  INDEX GamePlayerScores ON Scores(GameID) ;
CREATE  INDEX HomeTeamMatches ON TourneyMatches(HomeTeam) ;
CREATE  INDEX AwayTeamMatches ON TourneyMatches(AwayTeam) ;
#CREATE  INDEX TeamWin1ID ON TourneyMatches(WinningTeam) ;
#CREATE  INDEX TourneyMatchesTourneyID ON TourneyMatches(TourneyID) ;   says it was duplicate key name



#ALTER TABLE Scores ADD 
#	CONSTRAINT Scores_FK00 FOREIGN KEY 
#	(
#		PlayerID
#	) REFERENCES Players (
#		PlayerID
#	);

#ALTER TABLE Players ADD 
#	CONSTRAINT Players_FK00 FOREIGN KEY 
#	(
#		TeamID
#	) REFERENCES Teams (
#		TeamID
#	);

#ALTER TABLE Tournaments ADD 
#	CONSTRAINT Tournaments_FK00 FOREIGN KEY 
#	(
#		TourneyID
#	) REFERENCES TourneyMatches (
#		TourneyID
#	);

ALTER TABLE TourneyMatches ADD 
	CONSTRAINT TourneyMatches_FK00 FOREIGN KEY 
	(
		HomeTeam
	) REFERENCES Teams (
		TeamID
	),
    ADD CONSTRAINT TourneyMatches_FK01 FOREIGN KEY 
	(
		AwayTeam
	) REFERENCES Teams (
		TeamID
	);
    ADD CONSTRAINT TourneyMatches_FK02 FOREIGN KEY 
	(
		WinningTeam
	) REFERENCES Teams (
		TeamID
	);
    

select * from Teams;
select * from Players;
select * from Tournaments;
select * from TourneyMatches;
select * from Scores; 


# 1.4.1 Provide locations where the association is holding tournaments
select TourneyLocation from Tournaments; 

# 1.4.2 Display all players and their address formatted 
#suitably for a mailing list, sorted by zip code
select concat(PlayerFirstName, " ", PlayerLastName)  PlayerName, 
	concat(PlayerAddress, ", ", PlayerCity, ", ", PlayerState, ", ", PlayerZip ) Address
from Players
order by PlayerZip;

# 1.4.3 Display teams and the name of their head coach
select TeamName, concat(CoachFirstName, " ", CoachLastName) As HeadCoach 
from teams;

# 1.4.4 Show tournaments that have not been played yet  
select * from Tournaments
left join TourneyMatches  on Tournaments.TourneyID = TourneyMatches.TourneyID
where GameID is NULL;


# 1.4.5 Display name of top 10 scorers
#Players who scored highest along with their score
select concat(PlayerFirstName, " ", PlayerLastName) PlayerName, sum(PlayerScore) TotalScore
from Players
left join Scores  on Players.PlayerID = Scores.PlayerID
group by PlayerName
order by TotalScore desc limit 10; 

# 1.4.6 Display players’ names along with their highest score
select concat(PlayerFirstName, " ", PlayerLastName) PlayerName, max(PlayerScore) MaxScore
from Players
left join Scores on Players.PlayerID = Scores.PlayerID
group by PlayerName;

# 1.4.7 List the players' names whose highest score in a game is
#more than 10 points higher than their average
select concat(PlayerFirstName, " ", PlayerLastName) PlayerName, max(PlayerScore) MaxScore, avg(PlayerScore) AvgScore
from Players
left join Scores on Players.PlayerID = Scores.PlayerID
group by PlayerName
having MaxScore - AvgScore> 10;







# 1.5 Create a view of all the tournaments 
#that have been played at Red Rooster
CREATE VIEW Red_Rooster AS 
select * from Tournaments 
where TourneyLocation = "Red Rooster Arena";
Select * From Red_Rooster;
