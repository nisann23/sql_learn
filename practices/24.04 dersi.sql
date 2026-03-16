select sum(salary)/count(Salary) from employee;
select std(salary) from employee; #st sapma
select var_samp(salary) from employee; #varyans
select max(salary)-min(salary) from employee;
select distinct position from employee;

select distinct sex from employee;
select max(salary) from employee where sex='F';

select salary*1.1 from employee;
select fname, lname from employee where salary=(select min(salary) from employee);

select fname from employee where salary>(Select avg(salary) from employee);

select fname from employee where salary>(select avg(Salary) from employee);

select * from employee order by salary;
select * from employee order by position, salary;

select * from employee order by salary desc;

select * from employee where branchno="B003" order by position desc, salary asc;
select * from employee where branchno in ("b003", "b005"); #in ve or aynı anlamda






