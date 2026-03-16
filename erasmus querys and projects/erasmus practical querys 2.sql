--13.11 kodalri dersin ilk kismina gitmedim

--1
use hotel;
while (select avg(rooms.price) from rooms) <200
begin
  update rooms set rooms.price = rooms.price*1.15
  select max(rooms.price) from rooms 
  if (select max(rooms.price) from rooms) >450 break
  else continue
  end
print 'Prices too high for the market';



--2
select invoices.InvoiceID, invoices.CheckIn, Invoices.NightsNumber,
Invoices.Price, Invoices.TourismPromotionTax, case

when (Invoices.NightsNumber * Invoices.Price) + isnull(invoices.TourismPromotionTax, 0)>500
then 'price exceeds 500' else 'Price is below 500'
end as Pricestatus from Invoices;


--3
select employeeID, count(invoiceID) as TotalInvoices, 
sum(convert(numeric(18,2), TotalPrice)) as TotalAmount, 
case 
when sum(convert(numeric(18,2), TotalPrice))>1000 
then 'Total amount exceeds 1000'
else 'Total amount is below 1000' end as AmountStatus
from Invoices where EmployeeID is not null group by EmployeeID;


--4
DECLARE @CustomerID NCHAR(3)
SET @CustomerID = '001'
IF EXISTS (SELECT 1 FROM Customers WHERE [Customer ID] = @CustomerID)
BEGIN
    PRINT 'The client with ID ' + @CustomerID + ' Was found in the "customers" table.'
END
ELSE
BEGIN
    PRINT 'The client with ID ' + @CustomerID + ' Was not found in the "customers" table.'
END;


--5

declare @counter int
set @counter = 1
while @counter <= (select count(*) from dbo.customers)
begin
    declare @customerlastname nchar(20)
    declare @customerfirstname nchar(20)
    declare @isforeigncitizen nchar(1)

    select @customerlastname = lastname,
           @customerfirstname = firstname,
           @isforeigncitizen = foreigncitizen

    from (select *, row_number() over (order by [customer ID] ) as rownumber
         from dbo.customers) as rankedcustomers where rownumber = @counter

    if @isforeigncitizen = 't'
    begin
        print 'customer ' + @customerlastname + ' ' + @customerfirstname + ' is a foreign citizen.'
    end

    set @counter = @counter + 1
end


--6
declare @counter int
set @counter = 1

while @counter <= (select count(*) from dbo.customers)
begin
    declare @customeremail nchar(30)
    declare @customerlastname nchar(20)
    declare @customerfirstname nchar(20)

    select @customeremail = email,
           @customerlastname = lastname,
           @customerfirstname = firstname
    from (select *, row_number() over (order by [customer ID]) as rownumber
          from dbo.customers) as rankedcustomers
    where rownumber = @counter

    if @customeremail like '%@%'
    begin
        print 'customer ' + @customerfirstname + ' ' + @customerlastname + ' has a valid email address: ' + @customeremail
    end

    set @counter = @counter + 1
end