USE Company_SD;

-- Display the Department id, name and id and the name of its manager.
SELECT dnum, dname, mgrssn, CONCAT(fname, ' ', lname)
FROM Departments
INNER JOIN Employee
ON mgrssn = ssn;


-- Display the name of the departments and the name of the projects under its control.
SELECT dname, pname
FROM Departments D
INNER JOIN Project P
ON D.dnum = P.dnum;


-- Display the full data about all the dependence associated with the name of the employee they depend on him/her.
SELECT dependent_name, D.sex, D.bdate, CONCAT(E.fname, ' ', E.lname) AS 'Employee Name'
FROM Dependent D
LEFT JOIN Employee E
ON D.essn = E.ssn;



-- Display the Id, name and location of the projects in Cairo or Alex city.
SELECT pnumber, pname, plocation
FROM project
WHERE city IN ('Cairo', 'Alex');

-- Display the Projects full data of the projects with a name starts with "a" letter.
SELECT *
FROM project
WHERE pname LIKE 'a%';


-- display all the employees in department 30 whose salary from 1000 to 2000 LE monthly
SELECT *
FROM Employee
WHERE Dno = 30 AND salary BETWEEN 1000 AND 2000;


-- Retrieve the names of all employees in department 10 who works more than or equal10 hours per week on "AL Rabwah" project.
SELECT CONCAT(fname, ' ', lname), W.hours AS 'Employee Name'
FROM Employee E
INNER JOIN Project P
ON pname = 'AL Rabwah'
LEFT JOIN works_for W
ON W.pno = P.pnumber
WHERE w.hours >= 10;

-- Find the names of the employees who directly supervised with Kamel Mohamed.
SELECT CONCAT(E1.fname, ' ', E1.lname) AS 'Employee Name'
FROM Employee E1
LEFT JOIN Employee E2
ON E2.Fname = 'Kamel' AND E2.Lname = 'Mohamed'
WHERE E2.SSN = E1.Superssn;


-- Retrieve the names of all employees and the names of the projects they are working on, sorted by the project name.
SELECT CONCAT(E.fname, ' ', E.lname) AS 'Employee Name', P.pname
FROM Employee E
INNER JOIN works_for W
ON W.ESSn = E.ssn
LEFT JOIN Project P
ON W.Pno = P.Pnumber;


-- For each project located in Cairo City , find the project number, the controlling department name ,the department manager last name ,address and birthdate.
SELECT P.pnumber, D.dname, E.lname, E.Address, E.bdate
FROM project P
INNER JOIN Departments D
ON P.Dnum = D.Dnum
LEFT JOIN Employee E
ON E.ssn = D.MGRSSN
WHERE P.city = 'Cairo';

/*
SELECT * FROM Departments;
SELECT * FROM Employee;
SELECT * FROM Project;
*/

-- Display All Data of the mangers
SELECT *
FROM Employee E
RIGHT JOIN Departments D
ON D.MGRSSN = E.SSN;

-- Display All Employees data and the data of their dependents even if they have no dependents
SELECT *
FROM Employee E
LEFT JOIN Dependent D
ON E.ssn = D.ESSN;


--Data Manipulating Language:

--Insert your personal data to the employee table as a new employee in department number 30, SSN = 102672, Superssn = 112233, salary=3000.
SELECT * FROM employee;
INSERT INTO Employee(dno, ssn, superssn, salary, fname, lname, bdate, address)
		Values(30, 102672, 112233, 3000, 'Mohamed', 'Abdallah', '2005-2-20', 'Somewhere On The Earth');

DELETE FROM Employee WHERE SSN = 102672;

--Insert another employee with personal data your friend as new employee in department number 30, SSN = 102660, but don’t enter any value for salary or manager number to him.
INSERT INTO Employee(dno, ssn, fname, lname, bdate, address)
		Values(30, 102660, 'Mohamed', 'Abdallah', '2005-2-20', 'Somewhere On The Earth');

DELETE FROM Employee WHERE SSN = 102660;



--Upgrade your salary by 20 % of its last value.
UPDATE Employee
SET salary = salary + (salary * 20 / 100)
WHERE ssn = 102672;

SELECT * FROM Employee WHERE SSN = 102672;