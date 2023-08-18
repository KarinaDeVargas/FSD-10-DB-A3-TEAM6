/* Purpose: Database MovinOn_T6
	View Of Employees, Active/InActive, Years Served, Vested/NotVested
Script Date: August 18, 2023
Developed by: Team 6
				Benjamin Pye
				Claudiu Terenche
				Karina De Vargas Pereira
*/

-- switch to the current database
use movinon_t6;
go

-- 2.
if OBJECT_ID('dbo.EmployeesStatusVestedView', 'V') is not null
	drop view dbo.EmployeesStatusVestedView
;
go

create view dbo.EmployeesStatusVestedView 
as select
	EmpID as 'Employee ID',
	CONCAT_WS(' ' , EmpFirst, EmpLast) as 'Employee Full Name', 
	IIF(EndDate IS NULL, 'Active', 'Inactive') as 'Employee Status',
	dbo.getEmployeeYearsServedFn(StartDate, EndDate) as 'Years Served',
	CASE
        when EndDate IS NULL AND StartDate IS NOT NULL AND (DATEDIFF(YEAR, StartDate, GETDATE()) >= 5) then 'Fully Vested'
        else 'Not Vested'
    END as 'Vesting Status'
from HumanResources.Employees
;
go

--test
select *
from dbo.EmployeesStatusVestedView
order by 'Years Served' asc
;
go