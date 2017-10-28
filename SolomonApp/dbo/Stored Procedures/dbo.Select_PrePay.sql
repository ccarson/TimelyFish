 ---DCR added 5/21/98
Create Proc Select_PrePay @parm1 varchar(15), @parm2 varchar(10)as
SELECT	j.*
FROM	apadjust j
Join apdoc d on j.adjddoctype = d.doctype AND d.refnbr = j.AdjdRefNbr AND j.vendid = d.vendid 
left outer join VS_UnreleasedAPVoidCheck t on j.AdjgAcct = t.Acct and j.Adjgsub = t.sub and j.AdjgRefNbr = t.RefNbr 
WHERE	
j.adjddoctype IN ('PP')
AND	j.AdjAmt > 0
AND	d.docbal <> d.origdocamt
AND	j.s4future11 <> 'V'
and t.acct is null
AND	j.vendid = @parm1
AND	j.adjdrefnbr like @parm2
ORDER BY j.adjdrefnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Select_PrePay] TO [MSDSL]
    AS [dbo];

