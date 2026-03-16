--Select all details about employees, including their salaries.
use hotel;

select * from employees;

--Display all room details where the price exceeds 100 RON.
select * from rooms where price>100;


--List all invoices issued by employees whose position is "Receptionist" (the view EmployeesInvoices could
--be used).
select T1.*
from dbo.Invoices T1
join dbo.Employees T2 on T1.EmployeeID = T2.EmployeeID
where T2.Position = 'Receptionist';


--Show details of all foreign customers (the view ForeignCustomers could be used).
select firstname, lastname, country, phone, email, carno from Customers where foreigncitizen= 'T';


--Display room details for rooms equipped with both air conditioning and a balcony 
select T1.* from dbo.Rooms T1
join dbo.Facilities T2 on T1.RoomNumber = T2.RoomNumber
where T2.AirConditioning = 'T' and T2.Balcony = 'T';

--Find all invoices with an issue date in November 2024.
select * from invoices where IssueDate >= '2024-11-01' and IssueDate < '2024-12-01';

--Compute the total income from all invoices.
select sum(totalprice) as TotalIncome from Invoices;

--Show all rooms along with their corresponding facilities (the view FacilitiesRooms could be used).
select r.*, f.* from dbo.Rooms r
join dbo.Facilities f on r.RoomNumber = f.RoomNumber;

--List invoices where the due date is earlier than today.
select invoiceid, duedate from invoices where duedate  < '2025/11/27';


--List all employees who were hired after January 1, 2018, including their names, positions, and employment dates
select employeeid, firstname, lastname, employmentdate, position from employees 
where EmploymentDate>'2018-01-01';



--creating view
create view employee_details as
select
  firstname + ' ' + lastname as full_name,
  position,
  salary
from employees;


--2
create view foreign_customers_with_email as
select
  *
from customers
where
  foreigncitizen = 'T' and email is not null and email != '';


--3
create view employee_invoice_totals as
select
  e.employeeid,
  e.firstname + ' ' + e.lastname as full_name,
  sum(cast(i.totalprice as money)) as totalinvoicevalue
from employees e
inner join invoices i on e.employeeid = i.employeeid
group by
  e.employeeid,
  e.firstname,
  e.lastname;



