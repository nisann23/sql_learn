-- exercise 1
use hotel;
alter table invoices 
add dueDate date; --adding a new column to invoices

--exercise 2
use hotel;
insert into [dbo].[Invoices]
([InvoiceID], [CheckIn], [NightsNumber], [Price], [TourismPromotionTax],
[TotalPrice], [RoomNumber], [EmployeeID], [CustomerID], [IssueDate], [dueDate])
values 
('213', '2024-12-16', 5, 750, 34, '784', '22', '110', '314', '2024-11-14', '2024-12-14')
select * from Invoices; -- we should add cotain mark for insert and date (text) 

-- exercise 3
use hotel;
insert into [dbo].[Customers]
([Customer ID], [LastName], [FirstName], [Country], [ForeignCitizen], [Phone],
[Email], [Carno])
values
('319', 'Smith', 'John', 'Italy', 'T', '0735726817', NULL, NULL)
GO
select * from Customers;


--exercise 4 update the name of the client whose code is 313
update customers
set LastName= 'Martin' where   [Customer ID] = '313';
select * from customers;


--exercise 5 changing with update
update invoices
set TourismPromotionTax = TourismPromotionTax * 1.15 where InvoiceID = '212';
select * from invoices;

