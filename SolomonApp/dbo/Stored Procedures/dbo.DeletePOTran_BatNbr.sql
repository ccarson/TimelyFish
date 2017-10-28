 /****** Object:  Stored Procedure dbo.DeletePOTran_BatNbr    Script Date: 4/16/98 7:50:25 PM ******/
Create Procedure DeletePOTran_BatNbr @parm1 varchar ( 10) As
   Delete potran from POTran Where BatNbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeletePOTran_BatNbr] TO [MSDSL]
    AS [dbo];

