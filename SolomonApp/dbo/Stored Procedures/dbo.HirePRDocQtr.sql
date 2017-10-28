
Create Proc HirePRDocQtr
	@Employee as char(10),
	@Year as char(4),
	@Cpny as char(10)
as
	Select MIN(CalQtr)
	From PRDoc
	Where CalYr = @Year
		and EmpId = @Employee
		and Rlsed = 1
		and Status <> 'V'
		and CpnyID = @Cpny
		AND hireact = 1
