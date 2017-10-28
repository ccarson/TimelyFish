
/****** Object:  Stored Procedure dbo.pCF514AcctTranTotal    Script Date: 10/19/2004 4:31:09 PM ******/

/****** Object:  Stored Procedure dbo.pCF514AcctTranTotal    Script Date: 9/9/2004 11:27:38 AM ******/

/****** Object:  Stored Procedure dbo.pCF514AcctTranTotal    Script Date: 9/9/2004 8:51:59 AM ******/
CREATE    Proc pCF514AcctTranTotal

as
	Select pt.project, pt.pjt_entity, pt.acct, act_amount as Total
	From PJPTDSUM as pt
	JOIN pjpent pj on pt.pjt_entity=pj.pjt_entity
	JOIN pjacct ac on pt.acct=ac.acct
	WHERE pj.status_pa = 'A' and ac.acct_type='EX'
	Order by pt.project, pt.pjt_entity

