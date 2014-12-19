drop table if exists Game;
drop table if exists Schedule;

CREATE TABLE "Game" ("ID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" VARCHAR(20), "icon" VARCHAR(20), "keyInfo" CLOB, "basicInfo" CLOB, "olympicInfo" CLOB);

CREATE TABLE "Schedule" ("ID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "date" DATE NOT NULL, "time" VARCHAR(20) NOT NULL, "info" VARCHAR(50), "gameID" INTEGER REFERENCES "Game" ("ID"));