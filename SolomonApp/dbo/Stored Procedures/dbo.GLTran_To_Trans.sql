
Create proc [dbo].[GLTran_To_Trans]
 @batnbr varchar(10),
 @userid varchar (10)

as 

insert into 
		GLTRAN 
select 
		Acct			=	f.toglacct,				
		AppliedDate		=	'1900-01-01 00:00:00',				
		BalanceType		=	'A',				
		BaseCuryID		=	(select baseCuryId from glsetup),				
		BatNbr			=	c.batnbr,				
		CpnyID			=	f.ToCpnyID,				
		CrAmt			=	case when (e.acct_type IN ('LB', 'RV') and b.amount > 0) OR (e.acct_type IN ('AS', 'EX') and b.amount < 0)
							THEN abs(f.amount) ELSE 0 end,				
		Crtd_DateTime	=	getdate(),				
		Crtd_Prog		=	'PARPT',				
		Crtd_User		=	@userId,				
		CuryCrAmt		=	case when (e.acct_type IN ('LB', 'RV') and b.amount > 0) OR (e.acct_type IN ('AS', 'EX') and b.amount < 0)
							THEN abs(f.curytranamt) ELSE 0 end,
		CuryDrAmt		=	case when (e.acct_type IN ('LB', 'RV') and b.amount < 0) OR (e.acct_type IN ('AS', 'EX') and b.amount > 0)
							THEN abs(f.curytranamt) ELSE 0 end,				
		CuryEffDate		=	b.curyeffdate,				
		CuryId			=	b.curyid,				
		CuryMultDiv		=	b.curymultdiv,				
		CuryRate		=	b.curyrate,				
		CuryRateType	=	b.curyratetype,				
		DrAmt			=	case when (e.acct_type IN ('LB', 'RV') and b.amount < 0) OR (e.acct_type IN ('AS', 'EX') and b.amount > 0)
							THEN abs(f.amount) ELSE 0 end,				
		EmployeeID		=	b.employee,				
		ExtRefNbr		=	b.tr_id02,				
		FiscYr			=	LEFT(c.perpost,4),				
		IC_Distribution	=	0,				
		Id				=	b.vendor_num,				
		JrnlType		=	'TFR',				
		Labor_Class_Cd	=	b.tr_id05,				
		LedgerID		=	c.ledgerid,				
		LineId			=	f.Seqnum + a.lineid,				
		LineNbr			=	f.Seqnum + a.lineid,				
		LineRef			=	cast((f.Seqnum + a.lineid) as char (5)),				
		LUpd_DateTime	=	getdate(),				
		LUpd_Prog		=	'PARPT',				
		LUpd_User		=	@userId,				
		Module			=	'PA',				
		NoteID			=	f.noteid,				
		OrigAcct		=	'',				
		OrigBatNbr		=	'',				
		OrigCpnyID		=	'',				
		OrigSub			=	'',				
		PC_Flag			=	case when b.tr_status = 'N'	THEN b.tr_status ELSE '' end,				
		PC_ID			=	'',				
		PC_Status		=	2,				
		PerEnt			=	c.PerEnt,				
		PerPost			=	c.PerPost,				
		Posted			=	'U',				
		ProjectID		=	f.ToProject,				
		Qty				=	f.units,				
		RefNbr			=	b.voucher_num,				
		RevEntryOption	=	'',				
		Rlsed			=	1,				
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
		Sub			    =	f.ToSubAcct,				
		TaskID			=	f.ToPjt_Entity,				
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
		a.Origdetail_num = b.detail_num and 
		b.crtd_prog <> 'PACHG'
join				
		PJTfrDet f 
on
		a.Origfiscalno = f.Origfiscalno and
		a.Origsystem_cd = f.Origsystem_cd and
		a.Origbatch_id = f.Origbatch_id and
		a.Origdetail_num = f.Origdetail_num 
join				
		Batch c 
on
		a.batch_id = c.batnbr and 
		c.module = 'PA'
join			
		PJAcct e 
on
		b.acct = e.acct and
		e.acct_type IN ('AS', 'EX', 'RV', 'LB')
where			
		c.batnbr = @batnbr and
		c.module = 'PA' and
		b.batch_type <> 'CHRG' and
		b.gl_acct <> '' and 
		b.system_cd <> Case 
                                    when 
                                          (select substring(control_data, 60,1) 
                                          from pjcontrl 
                                          where control_type = 'TM' and 
                                                      control_code = 'setup') = 'N'
                                    Then 'TM'
                                    ELSE ''
                                    End 		

GO
GRANT CONTROL
    ON OBJECT::[dbo].[GLTran_To_Trans] TO [MSDSL]
    AS [dbo];

