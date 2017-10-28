 /****** Object:  Stored Procedure dbo.Vendor1099Yr    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure Vendor1099Yr @parm1 varchar(10) as
Select * from Vendor where
Curr1099Yr = @parm1
order by Curr1099Yr, VendID


