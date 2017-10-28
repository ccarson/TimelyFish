 /****** Object:  Stored Procedure dbo.ARDoc_UnRlsed_CustId5    Script Date: 5/19/98 11:30:33 AM ******/
Create Procedure ARDoc_UnRlsed_CustId5 @parm1 varchar ( 15) as
        SELECT * FROM ARDoc WHERE CustId = @parm1
        AND ((ARDoc.Rlsed = 0 and ARDoc.Doctype <> 'RC')
        OR (ARDoc.DocType ='RC'and ARDoc.NbrCycle > 0))
        ORDER BY ARDoc.BatNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_UnRlsed_CustId5] TO [MSDSL]
    AS [dbo];

