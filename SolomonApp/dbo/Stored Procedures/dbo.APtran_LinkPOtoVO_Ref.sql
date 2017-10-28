 Create Procedure APtran_LinkPOtoVO_Ref @RefNbr varchar (10), @DrCr varchar(1) As

select '0', p.Acct, p.BatNbr,p.CuryTranAmt,p.CuryUnitPrice,c.Descr,
			p.LineRef,p.Qty,p.RecordID, p.RefNbr,p.Sub, p.TranDate,
			 p.UnitDesc,p.VendId
 from aptran p
inner join account c on p.acct = c.acct
	where p.refnbr = @RefNbr
	AND p.drcr = @DrCr
	AND (p.trantype = 'VO' or p.trantype = 'AD')
	AND  p.tranclass <> 'T'
	AND (PONbr = '' OR PONbr is null)
	Order By p.BatNbr, p.RefNbr, p.LineRef asc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[APtran_LinkPOtoVO_Ref] TO [MSDSL]
    AS [dbo];

