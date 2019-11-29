DROP SCHEMA IF EXISTS mail CASCADE;
DROP TABLE IF EXISTS contact CASCADE;
DROP TABLE IF EXISTS info CASCADE;
DROP TABLE IF EXISTS history CASCADE;

CREATE SCHEMA mail;

CREATE TABLE info(
	email_id             text  NOT NULL PRIMARY KEY
 );

CREATE TABLE contact (
	email_id             text  NOT NULL REFERENCES  info(email_id),
	friend_email         text  NOT NULL ,
	description          text,
	unique(email_id, friend_email)
 );

CREATE TABLE history (
    email_id            text NOT NULL REFERENCES info(email_id),
    sent_date           timestamp NOT NULL,
    receiver            text NOT NULL,
    subject             text NOT NULL,
    message             text NOT NULL,
    unique (email_id,sent_date,receiver)
);

INSERT INTO info VALUES('wielgorskidominik@gmail.com');
INSERT INTO contact VALUES('wielgorskidominik@gmail.com','test@gmail.com', 'testVal');
INSERT INTO contact VALUES('wielgorskidominik@gmail.com','test2@gmail.com', 'testVal2');
insert into history values('wielgorskidominik@gmail.com', '16 Nov 2019 01:24:58','asdM@asd.com','test','testM');
insert into history values('wielgorskidominik@gmail.com', '18 Nov 2018 01:24:58','asdM@asd.com','test2','testMM');
insert into history values('wielgorskidominik@gmail.com', '13 Nov 2018 01:24:58','asdMM@asd.com','test3','testMMM');
