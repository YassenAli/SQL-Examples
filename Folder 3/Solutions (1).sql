--The name and the gender of the dependence 
--that's gender is Female and depending on Female Employee.
--And the male dependence that depends on Male Employee.
--1
select d.Dependent_name, d.Sex
from Dependent as d inner join Employee as e
on e.ssn=d.essn and e.sex='F' and d.sex='F'
Union
select d.dependent_name, d.sex
from Dependent as d inner join Employee as e
on e.ssn=d.essn and e.sex='M' and d.sex='M';


--2
--For each project, list the project name and the total hours per week 
--(for all employees) spent on that project.
select p.pname, sum(w.hours) as total
from Project as p inner join works_for as w on p.pnumber=w.pno
group by p.pname;



--3.Display the data of the department 
--which has the smallest employee ID over all employees' ID.

select d.* from Departments d, Employee e
where d.dnum=e.dno and e.ssn =(select MIN(ssn) from Employee);


--4.For each department, retrieve the department name 
--and the maximum, minimum and average salary of its employees.

select d.Dname, MAX(e.salary), min(e.salary), avg(e.salary)
from Departments d, Employee e
where d.Dnum=e.dno
group by d.Dname;


--5.List the last name of all managers who have no dependents.
select distinct e.lname
from Employee e inner join Departments d
on d.MGRSSN=e.ssn left join Dependent on essn=ssn where essn is null;


--6.For each department
-- if its average salary is less than the average salary of all employees
-- display its number, name and number of its employees.

select d.dnum, d.Dname, count(ssn) as num_of_its_employees
from Departments d, Employee e
where d.dnum=e.dno
group by d.Dnum, d.dname
having AVG(salary)<(select AVG(salary) from Employee);


--7.Retrieve a list of employees and the projects 
--they are working on ordered by department and within each department, 
--ordered alphabetically by last name, first name.

select e.fname, e.lname, p.Pname, d.dnum
from Employee e inner join Departments d
on dnum=dno inner join Project p on d.dnum=p.dnum
order by d.Dnum, e.fname, e.lname;


--8.Try to get the max 2 salaries using subquery
select top 2(salary)
from Employee
order by salary desc;
--or
SELECT max(salary) as firstmax
from Employee
union 
select max(salary)as secondmax
from Employee where salary not in (select max(salary) from Employee);


--9.Get the full name of employees that is similar to any dependent name
select fname+' '+lname as fullName
from Employee
intersect
select Dependent_name from Dependent;
--or
select fname+' '+lname as fullName
from Employee
where fname in (select Dependent_name from Dependent)
or lname in (select Dependent_name from Dependent);


--10.Try to update all salaries of employees who work in Project ‘Al Rabwah’ by 30%
 update Employee 
 set Salary+=(.3*Salary)                    
 from Employee e, Works_for w, Project p
 where e.ssn=w.ESSn and w.pno=p.Pnumber and p.pname='Al Rabwah';

 
--11.Display the employee number and name if at least one of them have dependents (use exists keyword) 
select ssn, fname
from Employee
where exists (select distinct essn from dependent where Employee.ssn=essn);
--or
select ssn from Employee intersect select essn from Dependent;


-----------------------------------------------------------------------

 --1.In the department table insert new department called "DEPT IT" , 
 --with id 100, employee with SSN = 112233 as a manager for this department. 
 --The start date for this manager is '1-11-2006'

 insert into Departments values('DEPT IT', 100, 112233, 11-1-2006);


 --2.Do what is required if you know that : 
 --Mrs.Noha Mohamed(SSN=968574)  moved to be the manager of the new department (id = 100), 
 --and they give you(your SSN =102672) her position (Dept. 20 manager) 

--a.First try to update her record in the department table
--b.Update your record to be department 20 manager.
--c.Update the data of employee number=102660 to be in your teamwork (he will be supervised by you) (your SSN =102672)

update Departments set MGRSSN = 968574 where dnum = 100;
update Departments set MGRSSN = 102672 where dnum =20;
update Employee	set Superssn = 102672 where ssn = 102660;


--3.Unfortunately the company ended the contract with Mr. Kamel Mohamed (SSN=223344) 
--so try to delete his data from your database 
--in case you know that you will be temporarily in his position.
--Hint: (Check if Mr. Kamel has dependents, works as a department manager, 
--supervises any employees or works in any projects and handle these cases).
--(your SSN =102672)
delete Dependent where ESSN=223344
delete Works_for where ESSN=223344
update Employee set Superssn=102672 where Superssn=223344;
update Departments set MGRSSN=102672 where MGRSSN=223344;
delete  Employee where SSN=223344;
