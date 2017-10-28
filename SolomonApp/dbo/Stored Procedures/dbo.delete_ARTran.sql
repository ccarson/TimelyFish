 /****** Object:  Stored Procedure dbo.delete_ARTran    Script Date: 4/7/98 12:30:34 PM ******/
Create PROC delete_ARTran @parm1 varchar ( 6) As
        DELETE artran FROM ARTran WHERE PerPost <= @parm1
        AND NOT EXISTS (SELECT ARDoc.RefNbr FROM ARDoc WHERE ARDoc.RefNbr = ARTran.RefNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[delete_ARTran] TO [MSDSL]
    AS [dbo];

