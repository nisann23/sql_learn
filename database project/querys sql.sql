--adding unique
alter table EmployeeDetails --tabloyu duzenle
add constraint UQ_EmployeeDetails_Email unique (Email); --kisitlama ekle

--checking if the products are positive
alter table Products
Add constraint CHK_Products_Price check (Price >= 0);

--checking
alter table Employees
Add constraint CHK_Employees_Salary check (Salary >= 30000);

--1 adding a new row (didn't include company name because IDENTITY_INSERT is set to OFF)
insert into Companies (CompanyName, Sector, FoundationYear, Country, Revenue)
			values ('Future Dynamics' , 'Ai Tegnologies' , '2000-05-06', 'Romania', 0 );


--2
-- Update the revenue of the newly added 'Future Dynamics' company to 250,000
update Companies set revenue= 250000.00 where CompanyName= 'Future Dynamics';

--checking
select * from companies;


--3
-- Increase the price of all products by 5 percent
update Products set price = Price * 1.05;
-- checking
select * from products;


--4
-- Delete the company record with the ID of 6.
delete from companies where CompanyID= 6;

--5
-- Select the first name, last name, and salary of all employees.
select firstname, lastname, salary from Employees;

--6
-- Retrieve the first name, last name, and the department name for each employee.
select e.firstname, e.lastname, d.departmentname from employees e 
	inner join Departments d on e.DepartmentID=d.DepartmentID;


--7
-- List sales details with company name, ordered by quantity in ascending orde
select s.saledate, s.quantity, c.companyname from sales s
inner join companies c on s.CompanyID= c.CompanyID 
order by Quantity asc; --asc: low to high

--8
-- Show details of employees who have a salary greater than 90,000.
select Firstname, lastname, email, phonenumber, salary from employees e 
inner join EmployeeDetails em on e.EmployeeID= em.EmployeeID 
where salary>90000;

--9
-- Select company and CEO names. Note: LEFT JOIN currently acts like INNER JOI
--note All companies in the current data have a CEOname so LEFT JOIN  works like an 
--INNER JOIN and shows no NULL values.
select companyname, CEOname from companies c 
left join CompanyDetails co on c.CompanyID= co.CompanyID;
--left join hiçbir satırı dışarda bırakmadan hepsini getirir, şirketin ceo name olmasa bile null olarak verir
--inner join şirketi vermez

--10
-- Join Sales, Employees, and Products tables to list who sold which product on what date, ordered by product price.
select  p.productid, e.employeeid, e.position, p.price, s.quantity, s.saledate from employees e
inner join sales s on e.EmployeeID= s.EmployeeID 
join products p on s.ProductID= p.ProductID
order by p.price asc;

use project_NisanurUnal;
--11 (calis buna group by neden 2)
-- Count the total number of employees working in each department, showing the department name.
select count(*) as employee_number, e.departmentid, d.departmentname from employees e 
inner join departments d on e.DepartmentID=d.DepartmentID 
group by e.DepartmentID, d.departmentname;
--selectteki bir kisim islem degilse group by kismina yazilmali

select * from Employees;
select * from Departments;

--11 den farkı ne sorabilir
--12
-- Calculate the total quantity of products purchased by each company.
select companyid, sum(quantity)as quantity_of_products from sales 
group by CompanyID;


--13
-- Find the average salary of employees within each department.
select departmentid, avg(salary) as AverageSalary from employees 
group by DepartmentID;




--14
-- List the companies that have purchased a total product quantity of more than 1000.
select companyid, sum(quantity) from sales 
group by CompanyID 
having sum(quantity)>1000;
--group by is needed when using a aggregated and non-aggreegated column


--15
-- Select products whose price is higher than the average price of all products.
select productid, price from products 
where price>(select avg(price) from products);

--16
-- Find employees who have not made any sales (ID not in Sales table).
select firstname, lastname from employees 
where employeeid not in (select distinct employeeid from sales);
--distinct means if employee made a sae, show only for once
use project_NisanurUnal;
--17
-- Find companies whose names start with the letter 'A'.
select companyname from companies where CompanyName like ('A%');

--18
-- List employees hired between the years 2020 and 2023.
select firstname, lastname, hiredate from employees 
where hiredate between'2020-01-01' and '2023-12-31';

--19
-- Calculate the age of each company in years based on its foundation year.
SELECT CompanyName, FoundationYear, 
datediff(year, FoundationYear, getdate()) AS CompanyAge FROM Companies;
--datediff calcualtes difference betweeen two dates(year(meausring choice, two dates)

--20
-- Display the employee who have the highest salary.
select firstname, lastname, salary from employees where salary= 
                                                    (select max(salary) from employees);


--21
-- Calculate the total number of employees and average salary 
--for companies within a specific sector (e.g., 'Investment Banking').
select count(e.EmployeeID) as numberofemp, avg(e.salary) as averagesalary from employees e 
inner join Departments d on d.DepartmentID= e.DepartmentID
inner join Companies c on c.CompanyID= d.CompanyID 
where c.sector ='Investment Banking';

--22
-- Display the first name, last name, and the hiring month and year for each employee.
select firstname, lastname, month(hiredate) as hiringmonth, year(hiredate) as hiringyear
from employees ;


-- 23
-- Display the full name of all employees in UPPERCASE.
SELECT UPPER(CONCAT(FirstName, ' ', LastName)) AS FullName_Upper
FROM Employees;
--concat sorgsuunu yapisittirici olarak dusunebilirsin

-- 24
-- Display the first 5 characters of the company names.
SELECT CompanyName, LEFT(CompanyName, 5) AS ShortName
FROM Companies;
--left soldan baslayarak 5 tane karakter almasi icin

--25
--Find employees who have not made any sales, using a LEFT JOIN and IS NULL condition.
select e.FirstName, e.LastName from employees e
left join sales s on e.employeeID = s.employeeID
where s.saleid is null;




--creating views
-- a view that joins sales, employees, products tables to show the
--saledate, quantity, the selling employee' s fullname and productname
--the goal is to allow access to this complex report using select command

create view V_SalesAndEmployeeDetails
as select
s.saledate, s.quantity, 
e.firstname + ' ' + e.lastname as FullName,
p.category
from sales s
inner join Employees e on s.employeeID = e.employeeID
inner join products p on p.productID= s.productID;

select * from V_SalesAndEmployeeDetails;


--a view that calculates the total revenue (calculated as SUM(Price * Quantity))
--and the total number of products purchased for each company
--KALDIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM
create view v_HighVolumeCompanySummary
as select
c.companyname, sum(p.price* s.quantity) as revenue,
sum(s.quantity) as TotalProductsPurchased
from sales s 
inner join Companies c on s.CompanyID= c.CompanyID
inner join Products p on p.ProductID= s.ProductID 
group by c.CompanyName;

select * from v_HighVolumeCompanySummary;



--create a view that provides managers with essential employee data but
--EXCLUDES the sensitive Salary and Bonus columns. The view should display the employee's FullName (concatenated), 
--Email, Position, and PerformanceScore

create view V_ManagerPerformanceView
as select
e.firstname + ' ' + e.lastname as FullName,
em.email, e.position, em.performancescore
from employees e
inner join EmployeeDetails em on e.EmployeeID = em.EmployeeID;

select * from V_ManagerPerformanceView;




--control structures
--stored procedure is automatic so its better than doing it manually every time
--
--create a stored procedure that accepts an employeeid and a performansscore
--as input parameters IF the @PerformanceScore is greater than or equal to 9.0, 
--increase the employee's Salary by 10%.
--if the score is below 9.0, increase the employee's Salary by 5%.
--Use BEGIN...END blocks for the main program flow

create procedure UpdateSalaryByPerformance
@EmployeeID int, --takes two inputs
@PerformanceScore decimal(3,2)
as begin
if @PerformanceScore >=9.0
begin 
	update employees
	set salary = salary*1.10 where EmployeeID= @EmployeeID;

	print 'Succes, number '+ cast(@employeeID as nvarchar) + ' received a 10% salary increase.' 
    --cast fro changing the data type
	end else 
	begin
	update employees 
	set salary = salary*1.05
	where EmployeeID= @EmployeeID;

	print 'Success, number' + cast(@employeeID as nvarchar) + ' received a 5% salary increase.'
    end
end
go


--test if it works
exec  UpdateSalaryByPerformance @EmployeeID = 1, @PerformanceScore = 9.5;
exec UpdateSalaryByPerformance @EmployeeID = 2 , @PerformanceScore = 7.8;

--!!!!!! used control structures in stored prosecure is it okay?

--extra
--create a stored procedure that accepts two input parameters: @StartEmployeeID (INT) and @BatchSize (INT).
--The procedure must use a dedicated WHILE loop to iterate and process employees starting from the @StartEmployeeID 
--for the number of times specified by the @BatchSize.
--Inside the loop, the procedure should:Increase the PerformanceScore of the current employee ID 
--by a fixed value of 0.10 in the EmployeeDetails table.
---Increment the current employee ID counter by 1.
--Decrement the batch size counter by 1 to control the loop termination.


create procedure BatchPerformanceAdjustment
    @startemployeeid as int,
    @batchsize as int
as 
begin
    declare @counter int;
    declare @endid int; 
    set @counter = @startemployeeid;
    set @endid = @startemployeeid + @batchsize; 
    while @counter < @endid
    begin
        update employeedetails 
        set performancescore = performancescore + 0.10
        where employeeid = @counter;
        print 'success: employee id ' + cast(@counter as nvarchar) + ' performance score increased by 0.10.';
        set @counter = @counter + 1; 
    end
    print 'batch adjustment process completed';
end
go


exec BatchPerformanceAdjustment @StartEmployeeID = 1, @BatchSize = 5;


--!!!!!!!!!!!!!KAlDIMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMmm!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!



--Create a Stored Procedure that accepts @CompanyName, @Price, and @Category as input parameters.
--The procedure must first find the CompanyID using the input @CompanyName 
--Then, safely insert a new record into the Products table using the retrieved CompanyID, @Price, and @Category
create procedure AddNewProduct 
@ProductName as nvarchar(50),
@CompanyName as nvarchar(100),
@Price as decimal(15,3),
@Category as nvarchar(100) 
as 
begin
    declare @CompanyID as int;
    Select @CompanyID = CompanyID from Companies where CompanyName = @CompanyName;

if @CompanyID is not null
begin
    insert into products (ProductName, Price, Category, CompanyID)
    values (@ProductName, @Price, @Category, @CompanyID);
PRINT 'SUCCESS: Product "' + @ProductName + '" successfully added for Company ID ' + 
                                                                    CAST(@CompanyID AS NVARCHAR) + '.';    
    end 
    else 
    begin
    PRINT 'ERROR: Company "' + @CompanyName + '" not found in the database. Product insertion failed.';
    end
end 
go

--testing
select * from companies;


EXEC AddNewProduct 
    @ProductName = 'Investment Fund A',
    @CompanyName = 'Apex Capital', -- CompanyID = 1
    @Price = 5000.00,
    @Category = 'Funds';






--cursors
--1
--a cursor that If an employee's Salary is greater than 150000, UPDATE their Position to 'Senior Manager'. 
--Print the employee ID, their salary, 
--and the update action for each processed record.
BEGIN TRANSACTION;
declare @EmployeeID  int, @OldPosition nvarchar(50), @salary decimal (10,2);

declare EmployeeCursor cursor for
select employeeID, position, salary from Employees;

open EmployeeCursor;

fetch next from EmployeeCursor into @EmployeeID,  @OldPosition, @salary

while @@FETCH_STATUS = 0
begin
    if @salary >60000
    begin
        update Employees
        set position = 'Senior Manager' where EmployeeID= @EmployeeID;

        print 'EmployeeID: ' + cast(@EmployeeID as nvarchar) + ' (Salary: ' + CAST(@Salary AS NVARCHAR) + ')' + 
              ' updated. Old Position: ' + @OldPosition + 
              ', New Position: Senior Manager.';
    end
    else
    begin
        PRINT 'LOG: Employee ID ' + CAST(@EmployeeID AS NVARCHAR) + ' skipped (Salary too low).';
    end

    fetch next from EmployeeCursor into @EmployeeID, @OldPosition, @Salary;
    end
close EmployeeCursor;
deallocate EmployeeCursor;

ROLLBACK TRANSACTION;





--2
--A cursor that lists all companies. The script must iterate through the Companies table and print the 
--CompanyName and its FoundationYear for every record processed. 

declare @CompanyName nvarchar(100), @FoundationYear int;

declare CompanyCursor cursor for
select companyname, year(foundationyear) from companies ;
 
open CompanyCursor;

fetch next from CompanyCursor into @CompanyName, @FoundationYear;
 while @@FETCH_STATUS = 0
 begin
    PRINT 'Company: ' + @CompanyName + ', Founded: ' + CAST(@FoundationYear AS NVARCHAR);

 fetch next from CompanyCursor into @CompanyName, @FoundationYear;
END

Close CompanyCursor;
Deallocate CompanyCursor;




--3 KOYMADİM BUNU PROJEYE ONCEDEN SİLDİGİM İCİN
--A cursor that perform row-by-row deletion. The cursor must join the Sales and Products tables to identify records 
--where Quantity is less than 500 AND the Price is less than 100. 
--Use the retrieved SaleID to perform a DELETE operation on the Sales table for each matching record.


--!!!!!!!!!!!!1 sikinti var kodu sildi simdi silinecek bir sey kalmadi
BEGIN TRANSACTION;

declare @SaleID INT, @Quantity INT, @Price DECIMAL(10, 2),
 @RowsDeleted INT = 0;

 declare SalesDelete cursor for
 select s.saleID, s.quantity, p.price from sales s
 inner join products p on s.ProductID= p.ProductID 
 where s.Quantity<500 and p.price <100;
 
 open SalesDelete;
    fetch next from SalesDelete into @SaleID, @Quantity, @Price;
    while @@FETCH_STATUS = 0
    begin
        delete from sales where SaleID= @SaleID;
    set @RowsDeleted= @RowsDeleted + 1;
    fetch next from SalesDelete into @SaleID, @Quantity, @Price;
end


PRINT 'INFO: ' + CAST(@RowsDeleted AS NVARCHAR) + ' records were successfully processed and deleted.';
close SalesDelete;
deallocate SalesDelete;

ROLLBACK TRANSACTION;

SELECT COUNT(*) 
FROM Sales S 
INNER JOIN Products P ON S.ProductID = P.ProductID 
WHERE S.Quantity < 500 AND P.Price < 100;






--3
--a cursor that iterate through all products. For each product, calculate the profit margin assumption (Price * 1.35) 
--and print the product ID, category, name, and the calculated margin. 
--Include only products priced over 1000."

begin transaction;

declare @productid int,  @productname nvarchar(50), @category nvarchar(50), 
              @price decimal(10, 2),@profitmargin decimal (10, 2), @totalproducts int = 0;

declare productmargincursor cursor for
select productid, productname, category, price from products where price > 1000.00;

open productmargincursor;

fetch next from productmargincursor into @productid, @productname, @category, @price;

while @@fetch_status = 0
begin
    set @profitmargin = @price * 1.35;
    set @totalproducts = @totalproducts + 1;

    print 'report: id: ' + cast(@productid as nvarchar) + ', name: ' + @productname + ', category: ' + @category +
                 ', price: ' + cast(@price as nvarchar) + ', calculated margin (x1.35): ' + cast(@profitmargin as nvarchar);
    
    fetch next from productmargincursor into @productid, @productname, @category, @price;
end

close productmargincursor;
deallocate productmargincursor;

print 'summary: total ' + cast(@totalproducts as nvarchar) + ' high-value products were processed.';
rollback transaction;


--testing
SELECT COUNT(*) AS ExpectedCount FROM Products 
WHERE Price > 1000.00;



--triggers
--1
--a trigger that When a new employee record is successfully inserted, the trigger must automatically update the EmployeesCount 
--column in the corresponding Departments table. The EmployeesCount for the relevant DepartmentID must be increased by 
--the number of new rows inserted.

create trigger EmployeeCountTrigger on employees 
after insert
as
begin
    update d 
    set EmployeesCount = d.EmployeesCount + 1 from Departments d
    inner join inserted i on d.DepartmentID = i.DepartmentID;
end
go

--testing
select EmployeesCount from Departments where DepartmentID = 1;

insert into Employees (DepartmentID, FirstName, LastName, Position, Salary, HireDate)
values (1, 'Test', 'Trigger', 'Trainee', 40000.00, getdate());

SELECT EmployeesCount FROM Departments WHERE DepartmentID = 1; 


--2
--a trigger that When one or more employee records are deleted from the table, the trigger must 
--automatically decrease the EmployeesCount column in the corresponding Departments table. The count must be decreased by the 
--number of employees removed for that specific DepartmentID.

create trigger EmployeeDeleteTrigger on employees
after delete
as
begin
    update d
    set EmployeesCount= d.EmployeesCount - number.DeletedCount from departments d
    inner join (select departmentID, count(*) as DeletedCount from deleted
                                        group by DepartmentID)
    as number on d.departmentID= number.DepartmentID;
end
go

--testing
select employeescount from Departments where DepartmentID= 1;

DELETE FROM Employees WHERE EmployeeID = 11; 
SELECT EmployeesCount FROM Departments WHERE DepartmentID = 1; 



--3
--The trigger must fire only when the Salary column is changed.
--When a salary update occurs, the trigger must insert a record into a 
--separate audit table (SalaryHistory ). This record must include the
--EmployeeID, the OldSalary , the NewSalary , and the timestamp of the modification.

Create table SalaryHistory ( HistoryID INT PRIMARY KEY IDENTITY(1,1),
   EmployeeID int NOT NULL,OldSalary Decimal(12, 2) NOT NULL,
    NewSalary Decimal(12, 2) NOT NULL,ChangeDate DATETIME DEFAULT GETDATE(),
);
GO

create trigger EmployeeSalary on employees
after update
as
begin
   --continue if the salary has changed
    if update(salary)
    begin
        insert into salaryhistory (employeeid, oldsalary, newsalary)
        select 
            i.employeeid,d.salary as oldsalary,i.salary as newsalary  
        from inserted i
        inner join deleted d on i.employeeid = d.employeeid; 
    end
end
go

--testing
select salary from employees where employeeid = 1;
select count(*) from salaryhistory; 

update employees 
set salary = 200000.00 -- new salary
where employeeid = 1;


select * from salaryhistory where employeeid = 1;



--4
--The trigger must fire only when the Position column is updated.
--If an employee's position is updated, the trigger must ensure the new 
--position name is always stored in ALL CAPITAL LETTERS 

create trigger position_standardize on employees
after update
as
begin
    if update(position)
    begin
        update e
        set position = upper(i.position) 
        from employees e
        inner join inserted i on e.employeeid = i.employeeid;
       
    end
end
go

--testing
select position from employees where employeeid = 1;

update employees 
set position = 'quality assurance' 
where employeeid = 1;

select position from employees where employeeid = 1; 



--5
--The trigger must enforce a business rule: Any newly hired employee's salary must be greater than $50,000.
--If an inserted record has a Salary less than or equal to $50,000, the trigger must print an error message,
--then use ROLLBACK TRANSACTION to prevent the insertion of the invalid record.

create trigger employee_min_salary_check
on employees
after insert
as
begin
    
    if exists (select * from inserted where salary <= 50000.00)
    begin
     print 'error: cannot insert employee. the minimum required salary for new employees is $50,001.';
        rollback transaction; 
    end
end
go

--testing
--error massage
insert into employees (departmentid, firstname, lastname, position, salary, hiredate)
values (1, 'invalid', 'hire', 'intern', 45000.00, getdate());


insert into employees (departmentid, firstname, lastname, position, salary, hiredate)
values (1, 'valid', 'hire', 'analyst', 60000.00, getdate());

-- Kontrol:
select * from employees where firstname = 'valid';