-- select ogreniyoruz 6.11 (onceki hafta islemedik)
--1
use hotel
select * from invoices;

--2
select distinct employeeID from invoices;

--3
select firstname, lastname, country from customers 
order by firstname asc;

--4
select firstname, lastname, country from customers
where country = 'Romania'; --hocanin sonucunda 5 tane vardı buna bir bak

--5
select firstname, lastname, country from customers
where firstname like 'A%';

--6
select customerID, checkIn, totalprice, nightsnumber
from Invoices where nightsnumber in (6,10);

--7
select customers.LastName, customers.FirstName, customers.Country, 
Invoices.NightsNumber from customers inner join Invoices on
Customers.[Customer ID] = Invoices.CustomerID 
where Invoices.NightsNumber >=5;


--8
select distinct customers.lastname, Invoices.CustomerID
from customers inner join invoices on customers.[Customer ID]=Invoices.CustomerID
where invoices.checkIN between '2008-01-01' and '2018-12-31';

--9
select min(Rooms.Price) as min_price, avg(Rooms.Price) as avg_Price,
 max(Rooms.Price) as max_price from Rooms;

 --10
 --calculate and display the total paid by the customer with code 316 for bookings
 select sum(cast(TotalPrice as numeric)) as TotalPaidValue
 from invoices where CustomerID = '316';


 --11
 --display the numbers related to invoices whose value is higher than the avarage value
 select InvoiceID, totalprice from invoices 
 where totalprice > (select avg(cast(totalprice as numeric)) from invoices);
 --totalprice numerik yaptik cunku nchardi buna tekrar bak


 --12
 --Display the customers from Romania for whom at least two invoices have been issued

 select firstname, lastname, country, count(Invoices.InvoiceID) as InvoicesNumber
 from customers inner join Invoices on customers.[Customer ID] = Invoices.CustomerID
 group by firstname, lastname, country having country= 'Romania'
 and count(Invoices.InvoiceID) >=2;

 --13
 --Display the customers who have rented apartments
 select customers.FirstName, customers.LastName, rooms.type
 from customers inner join (rooms inner join Invoices on rooms.RoomNumber =Invoices.RoomNumber)
 on customers.[Customer ID] = Invoices.CustomerID where rooms.type= 'Apartment';


 --14
 select customers.firstname, customers.LastName, left(country, 2) 
 as countryCode from customers;

 --15
 select customers.firstname, customers.LastName, right(carno, 3) as code
 from customers;


--16
-- display the invoices issued for rooms with terrace
select Invoices.InvoiceID, Facilities.Terrace 
from(rooms inner join Facilities on rooms.RoomNumber = Facilities.RoomNumber)
inner join Invoices on Rooms.RoomNumber = Invoices.RoomNumber 
where Facilities.Terrace = 'T';


--17
select employees.FirstName, employees.LastName, employees.Salary, employees.EmploymentDate,
datediff (year, employees.employmentDate, getdate()) as seniorityYears,
datediff(month, employees.employmentDate, getdate()) as seniorityMonths from employees;


--18
--romanya sosyal guvenlik numarasi acilimiymis
select substring (employees.PersonalNumericCode, 4, 2) as birthmonth,
substring (employees.PersonalNumericCode, 2, 2) as birthyear,
substring (Employees.personalnumericcode, 6,2) as birthday from employees;


--19
-- display the employees who have the lowest salary
select employees.FirstName, employees.LastName, employees.salary from employees
where salary = (select min(employees.salary) from employees);
select * from employees;


--20
--display invoices that have been issued for booking with the highest number of nights
select invoices.RoomNumber, invoices.NightsNumber from Invoices
where Invoices.NightsNumber = (select max(nightsnumber) from Invoices);


--21
--display the... for the customers who made the reservations with the highest number of nights
select Customers.FirstName, Customers.LastName, Invoices.InvoiceID, Invoices.NightsNumber
from Customers inner join invoices on Customers.[Customer ID]= Invoices.CustomerID
where Invoices.NightsNumber = (select max(nightsnumber) from Invoices);