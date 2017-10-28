 /****** Object:  Stored Procedure dbo.Address_All    Script Date: 4/7/98 12:42:26 PM ******/
Create Proc Address_All @parm1 varchar ( 10) as
       Select * from Address
           where AddrId like @parm1
           order by AddrId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Address_All] TO [MSDSL]
    AS [dbo];

