 create procedure PJARPAY_sbtran @parm1 varchar (1) , @parm2 varchar (6), @parm3 varchar (10)   as
	Select PJARPAY.custid, PJARPAY.doctype, PJARPAY.check_refnbr, PJARPAY.applied_amt,
		PJARPAY.discount_amt, PJARPAY.invoice_refnbr, PJARPAY.invoice_type, PJARPAY.status,
		ARDOC.bankacct, ARDOC.banksub, ARDOC.batnbr, ARDOC.cpnyid, ARDOC.custid, ARDOC.docdate,
		ARDOC.doctype, ARDOC.perpost, ARDOC.refnbr, ARDOC.rlsed, inv.projectid, inv.pc_status, Inv.BankAcct, Inv.BankSub, 
		ARDoc.CuryEffDate, ARDoc.CuryId, ARDoc.CuryMultDiv, ARDoc.CuryRate, ARDoc.CuryRateType
	From PJARPAY, ARDOC, ARDOC inv
	Where
		PJARPAY.status = @parm1 and
		PJARPAY.doctype <> 'CM' and
		PJARPAY.custid = ARDOC.custid and
		PJARPAY.doctype  = ARDOC.doctype  and
		PJARPAY.check_refnbr = ARDOC.refnbr and
		ARDOC.rlsed =  1 and
		ARDOC.perpost = @parm2 and
		ARDOC.batnbr = @parm3 and
		PJARPAY.custid = INV.custid and
		PJARPAY.invoice_type  = INV.doctype  and
		PJARPAY.invoice_refnbr = INV.refnbr and
		INV.pc_status = '1'
	Order by PJARPAY.custid, PJARPAY.doctype, PJARPAY.check_refnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJARPAY_sbtran] TO [MSDSL]
    AS [dbo];

