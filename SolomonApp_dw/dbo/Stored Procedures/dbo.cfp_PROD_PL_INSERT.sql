



-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 12/1/2011
-- Description:	Populates table in data warehouse.
-- 20150119 sripley:  set up job to run this proc monthly and changed delete to a truncate.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_PROD_PL_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
--delete from  dbo.cft_PRODUCTION_PL	
truncate table  dbo.cft_PRODUCTION_PL

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_PRODUCTION_PL
(	Sub
	,Division
	,Department
	,Location
	,GroupPeriod
	,AccountRollup
	,AccountRollupID
	,Account
	,Descr
	,TranDesc
	,Amt
	,Qty)

	Select
	GlTran.Sub,
	Case when left(rtrim(GLTran.Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(GlTran.Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(GlTran.Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(GlTran.Sub),4) in (1532,2132) then 'WTF' else '' end as 'Division',
	Case when left(rtrim(GLTran.Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(GLTran.Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(GlTran.Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(GlTran.Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(GlTran.Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(GlTran.Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(GlTran.Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(GlTran.Sub),4) in (2132) then 'Multiplication WTF' else '' end as 'Department',
	Case when GLTran.Sub = '10428458' then 'C058' else Seg.Description end as 'Location', 
	GLTran.PerPost AS 'GroupPeriod', 
	Case when ART.AccountRollupDescription is Null then 'Utilities' else ART.AccountRollupDescription end as 'AccountRollup',
	Case when ART.AccountRollupTypeID is Null then 13 else ART.AccountRollupTypeID end as 'AccountRollupID',
	Account.Acct,
	Account.Descr, 
	GLTran.TranDesc, 
	Sum(GLTran.Amt) as 'Amt',
	Case when GLTran.Acct = 45500 then (Sum(GLTran.Qty)+Sum(Case when APTran.Qty is null then 0 else APTran.Qty end)) 
	when GLTran.Acct in (62100,62105,62200) then Sum(APTran.Qty) else 0 end as 'Qty'
	From (Select Sub, PerPost, TranDesc, Acct, BatNbr, RefNbr, Rlsed, Sum(DrAmt - CrAmt) as Amt, Sum(Qty) as Qty
	from [$(SolomonApp)].dbo.GLTran (nolock) Group by Sub, PerPost, TranDesc, Acct, BatNbr, RefNbr, Rlsed) GLTran

	left join 
	(Select Sub, BatNbr, RefNbr, TranDesc, PerPost, Acct, Sum(TranAmt) TranAmt, Sum(Qty) Qty
	from [$(SolomonApp)].dbo.APTran (nolock)
	where Acct in (45500,62100,62105,62200)
	and PerPost >= 200901
	Group by Sub, BatNbr, RefNbr, TranDesc, PerPost, Acct) APTran
	on GLTran.Sub = APTran.Sub
	and GLTran.BatNbr = APTran.BatNbr
	and GLTran.RefNbr = APTran.RefNbr
	and GLTran.TranDesc = APTran.TranDesc
	and GLTran.PerPost = APTran.PerPost
	and GLTran.Acct = APTran.Acct
	and GLTran.Amt = APTran.TranAmt

	left join [$(SolomonApp)].dbo.Account Account (nolock)
	ON GLTran.Acct = Account.Acct

	left join [$(SolomonApp)].dbo.SubAcct SubAcct (nolock)
	ON GLTran.Sub = SubAcct.Sub

	left join [$(SolomonApp)].dbo.SegDef Seg (nolock)
	on right(rtrim(GLTran.Sub),4) = seg.ID and seg.SegNumber = 3

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP AR (nolock)
	on ar.account = account.acct
	and ar.division+ar.department = left(rtrim(gltran.sub),4)

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP_TYPE ART (nolock)
	on ar.accountrolluptypeid = art.accountrolluptypeid

	Where 
	GLTran.Rlsed =1
	and GLTran.PerPost >= 200901 
	and Account.AcctType in ('3I','3E')
	and Account.Acct not in (90600,81600,40150,40160,40180,90100,73200,90200,40100,40120,41900,40155,41250,40130,40140,40170,40190,40200,40110,41310,41300,41800,41900,41100,41150,41200)
	and left(rtrim(GLTran.Sub),4) in (1040,1041,1042,2040,2041,2042,1530,1531,1532,2130,2131,2132) 

	Group by
	GlTran.Sub, 
	ART.AccountRollupDescription,
	ART.AccountRollupTypeID,
	SubAcct.Descr, 
	Seg.Description,
	Seg.ID, 
	GLTran.PerPost, 
	Account.Acct,
	Account.Descr, 
	GLTran.Acct,
	GLTran.TranDesc
	
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PROD_PL_INSERT] TO [db_sp_exec]
    AS [dbo];

