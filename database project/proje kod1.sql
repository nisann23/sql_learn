create table Companies(
CompanyID int primary key identity(1,1),
CompanyName varchar(100) NOT NULL unique,
Sector varchar(50) NOT NULL,
FoundationYear date NULL,
Country varchar(50) NULL,
Revenue decimal(15,2) default 0
check (revenue>= 0) 
not null
);
insert into Companies (CompanyName, Sector, FoundationYear, Country, Revenue)
values
('Apex Capital','Investment Banking', '2001-08-10', 'USA', 75000000.50),

('DigiPay Corp', 'Fintech', '2019-03-25', 'UK', DEFAULT),
    
('Trust Bank AG', 'Commercial Banking', NULL, 'Germany', 120000000.00),
    
('Nordic Wealth', 'Asset Management', '2010-11-01', 'Norway', 3500000.25),
    
('Sentinel Risk', 'Insurance', '1985-06-12', 'Australia', 48000000.00);

select * from CompanyDetails;