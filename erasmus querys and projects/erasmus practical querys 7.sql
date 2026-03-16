--27.11 dersi
--Currsor: Bir tablonun veya sorgunun sonuç kümesi üzerinde bir döngü kurmanızı ve
--bu döngü içinde her bir satır için ayrı ayrı özel işlemler yapmanızı sağlar.

use hotel
go

--1

declare @Employeeid nchar(3), @Lastname nchar(20), @Firstname nchar(20);

-- declaring the cursor (imlec tanimlama)
declare employee_cursor cursor for
select employeeid, lastname, firstname
from [dbo].[employees];

-- opening the cursor(imlec acma)
open employee_cursor;

-- fetching the first row
--Imleçteki sonuç kümesinin ilk satırı çekilir ve değerleri daha önce tanımlanan değişkenlere atanır. 
--Bu satır, döngü başlamadan önce mutlaka çalıştırılmalıdır.
fetch next from employee_cursor into @Employeeid, @Lastname, @Firstname;

-- iterating through the result set
--@@FETCH_STATUS, en son FETCH işleminin sonucunu tutan bir sistem değişkenidir. 
--0 değeri, satırın başarıyla çekildiği anlamına gelir.
--Döngü, başarıyla çekilebilecek satır kalmayana kadar devam eder.
while @@fetch_status = 0
begin

    -- processing each row
    print 'Employeeid: ' + @Employeeid + ', Last name: ' + @Lastname + ', First name: ' + @Firstname;


    --bir sonraki satırı çekmeye çalışır. Başarılı olursa döngü devam eder,
    --başarısız olursa (@@FETCH_STATUS artık 0 olmaz) döngü sonlanır.
    -- fetching the next row
    fetch next from employee_cursor into @Employeeid, @Lastname, @Firstname;

end;

-- closing the cursor (imleci kapama)
close employee_cursor;

--Imleç için ayrılan tüm bellek ve sistem kaynakları tamamen silinir ve veritabanı sunucusuna geri verilir. 
-- deallocating the cursor
deallocate employee_cursor;






--2




declare @employeeid nchar(3), @position nchar(15), @salary money;


declare UpdateSalaryWaiter cursor for
select employeeid, position, salary from [dbo].[employees] 
where position = 'waiter';
-- ... geri kalan kod aynı

--opening the cursor
open UpdateSalaryWaiter;

--Fetching the first row
fetch next from UpdateSalaryWaiter into @employeeid, @position, @salary;

--Iterating through the result set
while @@FETCH_STATUS = 0
begin
--calculating the new salary with a %10 increase
    set @salary = @salary * 1.10;

--updating the salary in the database
    update [dbo].[employees] 
    set salary = @salary
    where employeeid = @Employeeid;

fetch next from UpdateSalaryWaiter into @employeeid, @position, @salary;
end

close UpdateSalaryWaiter;

deallocate UpdateSalaryWaiter;





--3
declare @roomnumber nchar(3), @nightprice smallmoney, @type nchar(15), @numberofnights int, @totalprice smallmoney;

-- declaring the cursor
declare room_cursor cursor for
select roomnumber, price, type
from [dbo].[rooms];

-- opening the cursor
open room_cursor;

-- fetching the first row
fetch next from room_cursor into @roomnumber, @nightprice, @type;

-- iterating through the result set
while @@fetch_status = 0
begin

    -- calculating the total price for 5 nights of stay
    set @numberofnights = 5;
    set @totalprice = @nightprice * @numberofnights;

    -- displaying the result
    print 'room number: ' + @roomnumber + ', room type: ' + @type + ', total price for ' + 
                    cast(@numberofnights as nvarchar) + ' nights: ' + cast(@totalprice as nvarchar);

    -- fetching the next row
    fetch next from room_cursor into @roomnumber, @nightprice, @type;

end;

-- closing the cursor
close room_cursor;

-- deallocating the cursor
deallocate room_cursor;





