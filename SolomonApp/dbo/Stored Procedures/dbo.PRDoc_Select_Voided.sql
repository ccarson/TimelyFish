 CREATE PROC PRDoc_Select_Voided @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 smalldatetime
as

Select a.* from prdoc a, prdoc b
Where a.cpnyid = @parm1
	and a.acct = @parm2
	and a.sub = @parm3
	and a.DocType <> 'VC'
	and a.status = 'V'
	and a.ChkDate <= @parm4
	and a.rlsed = 1
	and a.acct = b.acct
	and a.sub = b.sub
	and a.ChkNbr = b.ChkNbr
	and b.DocType = 'VC'
	and b.status = 'V'
	and b.ChkDate > @parm4
	and b.rlsed = 1
Order by a.ChkNbr, a.ChkDate



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRDoc_Select_Voided] TO [MSDSL]
    AS [dbo];

