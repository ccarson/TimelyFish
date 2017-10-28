 /****** Object:  Stored Procedure dbo.CustClass_All    Script Date: 4/7/98 12:30:33 PM ******/
Create Proc CustClass_All @parm1 varchar ( 6) as
    Select * from CustClass where ClassId like @parm1 order by ClassId


