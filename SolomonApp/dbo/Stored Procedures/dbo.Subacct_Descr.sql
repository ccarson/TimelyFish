 /****** Object:  Stored Procedure dbo.Subacct_Descr    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc  Subacct_Descr @parm1 varchar ( 24) as
       Select Descr from Subacct
           where Sub = @parm1




GO
GRANT CONTROL
    ON OBJECT::[dbo].[Subacct_Descr] TO [MSDSL]
    AS [dbo];

