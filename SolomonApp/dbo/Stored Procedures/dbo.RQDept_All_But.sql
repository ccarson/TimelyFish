 /****** Object:  Stored Procedure dbo.RQDept_All_But    Script Date: 9/4/2003 6:21:19 PM ******/
Create Procedure RQDept_All_But @Parm1 Varchar(10), @Parm2 Varchar(10) as
Select * from RQDept
WHERE
	DeptID <> @Parm1 and
	DeptID like @Parm2
Order by DeptID


