
CREATE proc [dbo].[GLTran_Trans_Credit]
 @batnbr varchar(10),
 @userid varchar (10)

as 

insert into 
		GLTRAN 
select 
		Acct			=	d.debit_gl_acct,			
		AppliedDate		=	'1900-01-01 00:00:00',			
		BalanceType		=	'A',		
		BaseCuryID		=	(select baseCuryId from glsetup),			
		BatNbr			=	c.batnbr,			
		CpnyID			=	d.debit_cpnyid,			
		CrAmt			=	d.alloc_amount,			
		Crtd_DateTime	=	getdate(),			
		Crtd_Prog		=	'PARPT',			
		Crtd_User		=	@userId,			
		CuryCrAmt		=	d.cury_alloc_amount,			
		CuryDrAmt		=	0,			
		CuryEffDate		=	d.curyeffdate,			
		CuryId			=	d.curyid,			
		CuryMultDiv		=	b.CuryMultDiv,			
		CuryRate		=	d.curyrate,			
		CuryRateType	=	d.curyratetype,			
		DrAmt			=	0,			
		EmployeeID		=	case when d.emp_detail_flag = 'Y' THEN b.employee ELSE '' end,			
		ExtRefNbr		=	b.tr_id02,			
		FiscYr			=	LEFT(c.perpost,4),			
		IC_Distribution	=	0,			
		Id				=	b.vendor_num,			
		JrnlType		=	'TFR',			
		Labor_Class_Cd	=	b.tr_id05,			
		LedgerID		=	c.ledgerid,			
		LineId			=	a.lineid + a.LastSeqNbr + (d.audit_detail_num * 2),			
		LineNbr			=	a.lineid + a.LastSeqNbr + (d.audit_detail_num * 2),				
		LineRef			=	cast(lineid as char (5)),			
		LUpd_DateTime	=	getdate(),			
		LUpd_Prog		=	'PARPT',			
		LUpd_User		=	@userId,			
		Module			=	'PA',			
		NoteID			=	a.noteid,			
		OrigAcct		=	'',			
		OrigBatNbr		=	'',			
		OrigCpnyID		=	'',			
		OrigSub			=	'',			
		PC_Flag			=	case when b.tr_status = 'N' THEN b.tr_status ELSE '' end,
		PC_ID			=	'',			
		PC_Status		=	2,			
		PerEnt			=	c.PerEnt,			
		PerPost			=	c.PerPost,			
		Posted			=	0,			
		ProjectID		=	d.post_project,			
		Qty				=	d.alloc_units,			
		RefNbr			=	b.voucher_num,			
		RevEntryOption	=	'',			
		Rlsed			=	0,			
		S4Future01		=	'',			
		S4Future02		=	'',			
		S4Future03		=	0,			
		S4Future04		=	0,			
		S4Future05		=	0,			
		S4Future06		=	0,			
		S4Future07		=	'1900-01-01 00:00:00',			
		S4Future08		=	'1900-01-01 00:00:00',			
		S4Future09		=	0,			
		S4Future10		=	0,			
		S4Future11		=	'',			
		S4Future12		=	'',			
		ServiceDate		=	'1900-01-01 00:00:00',			
		Sub				=	d.credit_gl_subacct,			
		TaskID			=	d.post_pjt_entity,			
		TranDate		=	b.trans_date,			
		TranDesc		=	b.tr_comment,			
		TranType		=	'PT',			
		Units			=	0,			
		User1			=	'',			
		User2			=	'',			
		User3			=	0,			
		User4			=	0,			
		User5			=	'',			
		User6			=	'',			
		User7			=	'1900-01-01 00:00:00',			
		User8			=	'1900-01-01 00:00:00',			
		tstamp			=	NULL
from
		PJTrnsfr a 
join			
		PJTran b 
on
		a.Origfiscalno = b.fiscalno and
		a.Origsystem_cd = b.system_cd and
		a.Origbatch_id = b.batch_id and
		a.Origdetail_num = b.detail_num
join			
		Batch c 
on
		a.batch_id = c.batnbr and 
		c.module = 'PA'
Join			
		PJAllAud d 
on
		a.Origfiscalno = d.fiscalno and
		a.Origsystem_cd = d.system_cd and
		a.Origbatch_id = d.batch_id and
		a.Origdetail_num = d.detail_num and
		d.debit_gl_acct <> '' and
		d.recalc_flag = ''
where				
		c.batnbr = @batnbr and
		c.module = 'PA'	and
		d.debit_gl_acct <> '' 	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Trans_Credit] TO [MSDSL]
    AS [dbo];

