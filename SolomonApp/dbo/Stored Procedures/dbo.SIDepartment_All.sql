 /****** Object:  Stored Procedure dbo.SIDepartment_All    Script Date: 4/7/98 12:42:26 PM ******/
/****** Object:  Stored Procedure dbo.SIDepartment_All    Script Date: 12/17/97 10:49:00 AM ******/
Create Procedure SIDepartment_All @Parm1 Varchar(10) as
Select * from SIDepartment WHERE DeptID LIKE @Parm1 Order by DeptID


