 /****** Object:  Stored Procedure dbo.ARDoc_Rlsed_CustId    Script Date: 4/7/98 12:30:33 PM ******/
Create Procedure ARDoc_Rlsed_CustId @parm1 varchar ( 15) as
        SELECT * FROM ARDoc WHERE Rlsed = 1
        AND DocType <> 'VT'
        AND CustId = @parm1
        ORDER BY CustId, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_Rlsed_CustId] TO [MSDSL]
    AS [dbo];

