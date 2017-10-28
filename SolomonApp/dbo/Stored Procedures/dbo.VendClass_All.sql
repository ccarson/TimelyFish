 /****** Object:  Stored Procedure dbo.VendClass_All    Script Date: 4/7/98 12:19:55 PM ******/
Create Proc VendClass_All @parm1 varchar (10) as
    Select * from VendClass where ClassId like @parm1 order by ClassId


