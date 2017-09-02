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



create table surgeon(
surgeonID int primary key,
surgeonFName varchar(50),
surgeonLName varchar(50),
deptID int,
foreign key (deptID) references department(deptID)
)engine=innodb;

load data infile 'H:\\Surgeon.csv'
into table surgeon
fields terminated by ','
lines terminated by '\n'
(surgeonID, surgeonFName, surgeonLName, deptID);

select * from surgeon; 

create table referral(
refID int primary key,
refDate date,
refFrom varchar(8),
refBy varchar(100),
addedToWL date,
fsaDate date default '' on update now(),
HTE varchar (3),
surgeonID int, 
NHI char(7),
foreign key (NHI) references patient(NHI),
foreign key (surgeonID) references surgeon(surgeonID)
)engine=innodb; 

load data infile 'H:\\Referral.csv'
into table referral
fields terminated by ','
lines terminated by '\n'
(refID, refDate, refFrom, refBy, addedToWL, fsaDate, HTE, surgeonID, NHI);

