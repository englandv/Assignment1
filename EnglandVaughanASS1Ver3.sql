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

create table department(
deptID int primary key,
deptName varchar(50)
)engine=innodb;

load data infile 'H:\\Department.csv'
into table department
fields terminated by ','
lines terminated by '\n'
(deptID, deptName);

select * from department;


create table patient(
NHI char(7) primary key,
patFName varchar(50),
patLName varchar(50),
DOB date,
genderID int,
foreign key (genderID) references gender(genderID)
)engine=innodb; 

load data infile 'H:\\Patient.csv'
into table patient
fields terminated by ','
lines terminated by '\n'
(NHI, patFName, patLName, DOB, genderID);

select * from patient;




