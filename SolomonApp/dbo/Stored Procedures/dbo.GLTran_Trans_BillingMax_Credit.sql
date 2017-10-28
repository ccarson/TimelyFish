
CREATE proc [dbo].[GLTran_Trans_BillingMax_Credit]
 @batnbr varchar(10),
 @userid varchar (10),
 @basecuryid varchar (4),
 @maxgllineid int,
 @minpjdetnum int

as 

insert into 
		GLTRAN 
select 
		Acct			=	CASE
							WHEN b.amount < 0 THEN
								substring(d.tr_id20, charindex(' ', d.tr_id20) + 1, charindex(' ', d.tr_id20, charindex(' ', d.tr_id20, charindex(' ', d.tr_id20) + 1)) - (charindex(' ', d.tr_id20) + 1))
							ELSE
								b.gl_acct
							END,			
		AppliedDate		=	'1900-01-01 00:00:00',			
		BalanceType		=	'A',		
		BaseCuryID		=	@basecuryid,			
		BatNbr			=	c.batnbr,			
		CpnyID			=	b.cpnyid,			
		CrAmt			=	abs(b.amount),			
		Crtd_DateTime	=	getdate(),			
		Crtd_Prog		=	'PARPT',			
		Crtd_User		=	@userId,			
		CuryCrAmt		=	abs(b.amount),			
		CuryDrAmt		=	0,			
		CuryEffDate		=	'1900-01-01 00:00:00',			
		CuryId			=	@basecuryid,			
		CuryMultDiv		=	'M',			
		CuryRate		=	1,			
		CuryRateType	=	'',			
		DrAmt			=	0,			
		EmployeeID		=	b.employee,			
		ExtRefNbr		=	b.tr_id02,			
		FiscYr			=	LEFT(c.perpost,4),			
		IC_Distribution	=	0,			
		Id				=	b.vendor_num,			
		JrnlType		=	'TFR',			
		Labor_Class_Cd	=	b.tr_id05,			
		LedgerID		=	c.ledgerid,			
		LineId			=	@maxgllineid + ((b.detail_num - @minpjdetnum + 1) * 2),			
		LineNbr			=	@maxgllineid + ((b.detail_num - @minpjdetnum + 1) * 2),				
		LineRef			=	cast((@maxgllineid + ((b.detail_num - @minpjdetnum + 1) * 2)) as char (5)),			
		LUpd_DateTime	=	getdate(),			
		LUpd_Prog		=	'PARPT',			
		LUpd_User		=	@userId,			
		Module			=	'PA',			
		NoteID			=	b.noteid,			
		OrigAcct		=	'',			
		OrigBatNbr		=	'',			
		OrigCpnyID		=	'',			
		OrigSub			=	'',			
		PC_Flag			=	'',
		PC_ID			=	'',			
		PC_Status		=	2,			
		PerEnt			=	c.PerEnt,			
		PerPost			=	c.PerPost,			
		Posted			=	0,			
		ProjectID		=	b.project,			
		Qty				=	0,			
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
		S4Future11		=	'C',			
		S4Future12		=	'',			
		ServiceDate		=	'1900-01-01 00:00:00',			
		Sub				=	b.gl_subacct,			
		TaskID			=	b.pjt_entity,			
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
		PJTran b 
join			
		Batch c 
on
		b.batch_id = c.batnbr and
		b.system_cd = c.module and
		c.module = 'PA'
join
		pjtranex d
on
		b.fiscalno = d.fiscalno and
		b.system_cd = d.system_cd and
		b.batch_id = d.batch_id and
		b.detail_num = d.detail_num and
		d.tr_id20 <> ''
where				
		b.tr_status = 'M1' and		
		c.batnbr = @batnbr					
					

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_Trans_BillingMax_Credit] TO [MSDSL]
    AS [dbo];

