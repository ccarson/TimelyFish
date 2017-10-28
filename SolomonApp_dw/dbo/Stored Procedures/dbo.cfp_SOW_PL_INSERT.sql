

-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 12/14/2010
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_SOW_PL_INSERT]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
TRUNCATE TABLE  dbo.cft_SOW_PL

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_SOW_PL
(	Sub
	,Location
	,GroupPeriod
	,AccountRollup
	,AccountRollupID
	,Descr
	,TranDesc
	,Amt
	,Qty)
	
	Select
	GlTran.Sub,
	Case when GLTran.Sub = '10428458' then 'C058' else Seg.Description end as 'Location', 
	GLTran.PerPost AS 'GroupPeriod', 
	Case when ART.AccountRollupDescription is Null then 'Utilities' else ART.AccountRollupDescription end as 'AccountRollup',
	Case when ART.AccountRollupTypeID is Null then 13 else ART.AccountRollupTypeID end as 'AccountRollupID',
	Account.Descr, 
	GLTran.TranDesc, 
	Case when GLTran.PerPost in (200803,200804,200805,200806,200807) and Seg.ID in (8454,8460,8465,8466,8470,8900) then 0
	when GLTran.PerPost in (200808,200809,200810,200811) and seg.ID = 8470 then 0
	when GLTran.PerPost in (200905,200906,200907,200908,200909,200910,200911) and Seg.ID = 9820 then 0
	when GLTran.PerPost in (200802,200803,200804,200805,200911,200912,201001,201002,201003,201004,201011,201012,201101,201102,201103,201104) and Seg.ID = 8455 then 0
	when GLTran.PerPost = 200802 and Seg.ID in (8900,8460,8420,8470) then 0
	when GLTran.PerPost = 200801 and Seg.ID in (9800,8420,8455,8460,8470) then 0
	when GLTran.PerPost = 200808 and Seg.ID = 8454 and GLTran.Acct in (46800,46900,76350) then 0
	else Sum(GLTran.Amt) end As 'Amt',
	Case when GLTran.PerPost in (200803,200804,200805,200806,200807) and Seg.ID in (8454,8460,8465,8466,8470,8900) then 0
	when GLTran.PerPost in (200808,200809,200810,200811) and seg.ID = 8470 then 0
	when GLTran.PerPost in (200905,200906,200907,200908,200909,200910,200911) and Seg.ID = 9820 then 0
	when GLTran.PerPost in (200802,200803,200804,200805,200911,200912,201001,201002,201003,201004,201011,201012,201101,201102,201103,201104) and Seg.ID = 8455 then 0
	when GLTran.PerPost = 200802 and Seg.ID in (8900,8460,8420,8470) then 0
	when GLTran.PerPost = 200801 and Seg.ID = 8470 then 0
	when GLTran.PerPost = 200808 and Seg.ID = 8454 and GLTran.Acct in (46800,46900,76350) then 0
	else (Case when GLTran.Acct = 45500 then (Sum(GLTran.Qty)+Sum(Case when APTran.Qty is null then 0 else APTran.Qty end)) 
	when GLTran.Acct in (62100,62105,62200) then Sum(APTran.Qty) else 0 end) end As 'Qty'
	From (Select Sub, PerPost, TranDesc, Acct, BatNbr, RefNbr, Rlsed, Sum(DrAmt - CrAmt) as Amt, Sum(Qty) as Qty
	from [$(SolomonApp)].dbo.GLTran (nolock) Group by Sub, PerPost, TranDesc, Acct, BatNbr, RefNbr, Rlsed) GLTran

	left join 
	(Select Sub, BatNbr, RefNbr, TranDesc, PerPost, Acct, Sum(TranAmt) TranAmt, Sum(Qty) Qty
	from [$(SolomonApp)].dbo.APTran (nolock)
	where Acct in (45500,62100,62105,62200)
	and PerPost >= 200801
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
	and GLTran.PerPost >= 200801 
	and Account.AcctType in ('3I','3E')
	and Account.Acct not in (90600,81600,40150,40160,40180,90100,73200,90200,40100,40120,41900,40155,41250)
	and left(rtrim(GLTran.Sub),4) in (1040,1041,1042,2040,2041,2042) 

	Group by
	GlTran.Sub, 
	ART.AccountRollupDescription,
	ART.AccountRollupTypeID,
	SubAcct.Descr, 
	Seg.Description,
	Seg.ID, 
	GLTran.PerPost, 
	Account.Descr, 
	GLTran.Acct,
	GLTran.TranDesc
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SOW_PL_INSERT] TO [db_sp_exec]
    AS [dbo];

