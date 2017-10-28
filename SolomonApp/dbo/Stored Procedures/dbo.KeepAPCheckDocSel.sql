 /****** Object:  Stored Procedure dbo.KeepAPCheckDocSel    Script Date: 4/7/98 12:19:55 PM ******/
Create Procedure KeepAPCheckDocSel @parm1 varchar ( 10), @parm2 varchar ( 10) As
        Select * From APDoc Where
                BatNbr = @parm1 and
                RefNbr = @parm2 and
                Status = 'T' and
                Acct <> '' and
                Sub <> '' and
                DocType Not In ('MC', 'SC')
         Order By BatNbr, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[KeepAPCheckDocSel] TO [MSDSL]
    AS [dbo];

