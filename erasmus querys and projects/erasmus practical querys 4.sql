--1
-- this query automatically calculates the TotalPrice when a new invoice is created by multiplying Price by NightsNumber

create trigger autoinvoice on invoices
after insert
as
begin
update [dbo].[invoices]
set TotalPrice= cast((i.price * i.nightsnumber) as nchar(10))
				from dbo.Invoices inv
inner join inserted i on inv.InvoiceID=i.InvoiceID
print ('Total price has been calculated succesfully')
end 
go 

--2
--Validates data updates on the Rooms table. It checks if the new price is negative; 
--if so, it rolls back the transaction.

create trigger beforeupdatetrigger on rooms 
after update
as begin 
if exists (select * from inserted where price<0)
	begin
		rollback transaction;
		print 'Price cannot be negative, plase change.';
		end
end

--3
--When an invoice is deleted (indicating a cancellation or checkout), 
--this trigger automatically updates the Facilities table to reset the Minibar status for that room.

create trigger on invoices 
after delete 
as begin
update dbo.Facilities
    set Minibar = '0' from dbo.Facilities f
    inner join  deleted d ON f.RoomNumber = d.RoomNumber;

    PRINT 'Invoice deleted. Minibar status reset for the related room.';
END;
