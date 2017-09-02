use hospital2017;

select count(*) as 'Referral Count'
from referral
where HTE = 'Yes';

select deptName, round(avg(datediff(fsaDate,refDate))) as 'Average days to be seen' 
from referral R inner join surgeon S
on R.surgeonID = S.surgeonID
inner join department D
on S.deptID = D.deptID
where HTE = 'Yes'
group by D.deptID;

select concat(surgeonFName, " ", surgeonLName) as 'Surgeon', concat(patFName, " ", patLName) as 'Patient', datediff(fsaDate, refDate) as 'Days to be seen'
from surgeon S inner join referral R
on R.surgeonID = S.surgeonID
inner join patient P
on R.NHI = P.NHI
where HTE = 'Yes'
order by S.surgeonID;

select  deptName as 'Department', concat(patFName, ' ', PatLName) as 'Patient', round(datediff(current_date(),DOB)/365.25) as 'Age'
from surgeon S inner join referral R
on R.surgeonID = S.surgeonID
inner join patient P
on R.NHI = P.NHI
inner join department D
on S.deptID = D.deptID 
where HTE = 'Yes'
	and round(datediff(current_date(),DOB)/365.25) < 18  
    and deptName <> 'Paediatric Surgery';

create or replace view patientUnder80Days as
select D.deptID, deptName as 'Department', datediff(fsaDate,refDate) as 'Days till seen', count(refID) as 'Under80Count'
from surgeon S inner join referral R
on R.surgeonID = S.surgeonID
inner join department D
on S.deptID = D.deptID 
where HTE = 'Yes'
	and datediff(fsaDate,refDate) <= 80
group by D.deptID;

create or replace view patientPerDeptment as
select D.deptID, deptName as 'Department', count(*) as 'TotalCount'
from surgeon S inner join referral R
on R.surgeonID = S.surgeonID
inner join department D
on S.deptID = D.deptID 
where HTE = 'Yes'
group by D.deptID;

create or replace view patientPercentSeen as
select PUD.Department, Under80Count/TotalCount*100 as 'Percent'
from patientUnder80Days PUD inner join patientPerDeptment PPD
on PUD.deptID = PPD.deptID;

select *
from patientUnder80Days;

select *
from patientPerDeptment;

select *
from patientPercentSeen;
