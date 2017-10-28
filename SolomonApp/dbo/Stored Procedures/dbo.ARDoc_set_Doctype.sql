 Create procedure ARDoc_set_Doctype @parm1 varchar (10), @parm2 varchar (15), @parm3 varchar (10) as
        UPDATE ARDoc SET ARDoc.DocType = "VT"
        WHERE ARDoc.BatNbr = @parm1
        AND ARDoc.Custid = @parm2
        AND ARDoc.DocType = "PA"
        AND ARDoc.RefNbr = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ARDoc_set_Doctype] TO [MSDSL]
    AS [dbo];

