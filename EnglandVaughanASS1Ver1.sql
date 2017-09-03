-- create database hospital2017;

use hospital2017;

drop table if exists referral;
drop table if exists surgeon;
drop table if exists patient;
drop table if exists department;
drop table if exists gender;

create table gender(
genderID int primary key,
genderType varchar(8)
)engine=innodb;

load data infile 'H:\\Gender.csv'
into table gender
fields terminated by ','
lines terminated by '\n'
(genderID, genderType);

select * from gender;


