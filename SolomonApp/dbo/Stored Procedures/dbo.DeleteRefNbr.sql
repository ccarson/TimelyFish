 Create Proc DeleteRefNbr @parm1 Varchar(10) as

delete r from refnbr r, ardoc d where r.refnbr = d.refnbr and d.batnbr = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DeleteRefNbr] TO [MSDSL]
    AS [dbo];

