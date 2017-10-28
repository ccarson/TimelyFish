 /****** Object:  Stored Procedure dbo.WrkFSTriBal_DEL_RefNbr    Script Date: 4/7/98 12:45:04 PM ******/
Create Proc WrkFSTriBal_DEL_RefNbr @parm1 varchar (10) As
     Delete from WrkFSTriBal
     Where RefNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkFSTriBal_DEL_RefNbr] TO [MSDSL]
    AS [dbo];

