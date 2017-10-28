


-- ===================================================================
-- Author:	Mike Zimanski
-- Create date: 1/10/2011
-- Description:	Populates table in data warehouse.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_PROD_PL_INSERT_2]
AS
BEGIN

-------------------------------------------------------------------------------------------------------
-- this is dependent on replication finishing, so should be run directly after log shipping completes
-------------------------------------------------------------------------------------------------------
--clear table for new data
delete from  dbo.cft_PRODUCTION_PL_2

--------------------------------------------------------------------------
-- BASE INFO
--------------------------------------------------------------------------
INSERT INTO  dbo.cft_PRODUCTION_PL_2
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
	Case When Sub like '[12]04[012]____' then LEFT(rtrim(Sub), 2) 
    + '40' + RIGHT(rtrim(Sub), 4) else Sub end as 'Sub',
	Division,
	Department,
	Location,
	GroupPeriod,
	AccountRollup,
	AccountRollupID,
	Account,
	Descr,
	TranDesc,
	Amt,
	Qty
	
	From  dbo.cft_PRODUCTION_PL
	
	union
	
	Select 
	Case When BA.Sub like '[12]04[012]____' then LEFT(rtrim(BA.Sub), 2) 
    + '40' + RIGHT(rtrim(BA.Sub), 4) else BA.Sub end as 'Sub',
	BA.Division,
	BA.Department,
	BA.Location,
	BA.GroupPeriod,
	BA.AccountRollup,
	BA.AccountRollupID,
	BA.Account,
	BA.Descr,
	BA.TranDesc,
	BA.Amt,
	BA.Qty
	from (
	
	Select
	Case When FB.Sub like '[12]04[012]____' then LEFT(rtrim(FB.Sub), 2) 
    + '40' + RIGHT(rtrim(FB.Sub), 4) else FB.Sub end as 'Sub',
	Case when left(rtrim(FB.Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(FB.Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(FB.Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(FB.Sub),4) in (1532,2132) then 'WTF' else '' end as 'Division',
	Case when left(rtrim(FB.Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(FB.Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(FB.Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(FB.Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(FB.Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(FB.Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(FB.Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(FB.Sub),4) in (2132) then 'Multiplication WTF' else '' end as 'Department',
	Case when FB.Sub = '10408458' then 'C058' else Seg.Description end as 'Location', 
	'2012'+RIGHT(rtrim(FB.Period),2) AS 'GroupPeriod', 
	Case when ART.AccountRollupDescription is Null then 'Utilities' else ART.AccountRollupDescription end as 'AccountRollup',
	Case when ART.AccountRollupTypeID is Null then 13 else ART.AccountRollupTypeID end as 'AccountRollupID',
	Account.Acct as 'Account',
	Account.Descr, 
	'' as TranDesc, 
	'' as 'Amt',
	'' as 'Qty'
	From (
	
	Select 
	RIGHT(rtrim(Division),2)+RIGHT(rtrim(Department),2)+
	Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then '8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then '8122' else RIGHT(rtrim(Location),4) end as 'Sub',
	RIGHT(rtrim(Time),2) as 'Period',
	RIGHT(rtrim(Account),5) as 'Account',
	SUM(Total) as 'Amt'
	from  dbo.cft_PRODUCTION_PL_BUDGET
	--Where RIGHT(rtrim(Location),4) <> '8450'
	group by
	RIGHT(rtrim(Division),2)+RIGHT(rtrim(Department),2)+
	Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then '8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then '8122' else RIGHT(rtrim(Location),4) end,
	RIGHT(rtrim(Time),2),
	RIGHT(rtrim(Account),5)) FB

	left join [$(SolomonApp)].dbo.Account Account (nolock)
	ON FB.Account = Account.Acct

	left join [$(SolomonApp)].dbo.SubAcct SubAcct (nolock)
	ON FB.Sub = SubAcct.Sub

	left join [$(SolomonApp)].dbo.SegDef Seg (nolock)
	on right(rtrim(FB.Sub),4) = seg.ID and seg.SegNumber = 3

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP AR (nolock)
	on ar.account = account.acct
	and ar.division+ar.department = left(rtrim(FB.sub),4)

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP_TYPE ART (nolock)
	on ar.accountrolluptypeid = art.accountrolluptypeid

	Where 
	Account.AcctType in ('3I','3E')
	and Account.Acct not in (90600,81600,40150,40160,40180,90100,73200,90200,40100,40120,41900,40155,41250,40130,40140,40170,40190,40200,40110,41310,41300,41800,41900,41100,41150,41200)
	and left(rtrim(FB.Sub),4) in (1040,1041,1042,2040,2041,2042,1530,1531,1532,2130,2131,2132) 
	--and RIGHT(rtrim(FB.Sub),4) <> '0000'
	
	Group by
	FB.Sub, 
	ART.AccountRollupDescription,
	ART.AccountRollupTypeID,
	SubAcct.Descr, 
	Seg.Description,
	Seg.ID, 
	FB.Period, 
	Account.Acct,
	Account.Descr, 
	FB.Account) BA
	left join (Select Distinct Case When Sub like '[12]04[012]____' then LEFT(rtrim(Sub), 2) 
    + '40' + RIGHT(rtrim(Sub), 4) else Sub end as 'Sub', GroupPeriod, Account 
	from  dbo.cft_PRODUCTION_PL where GroupPeriod >= 201001) PL
	on left(rtrim(BA.Sub),4) = left(rtrim(PL.Sub),4)
	and BA.GroupPeriod = PL.GroupPeriod
	and BA.Account = PL.Account
	Where PL.Sub is null
	
	union
	
	Select 
	Case When BA.Sub like '[12]04[012]____' then LEFT(rtrim(BA.Sub), 2) 
    + '40' + RIGHT(rtrim(BA.Sub), 4) else BA.Sub end as 'Sub',
	BA.Division,
	BA.Department,
	BA.Location,
	BA.GroupPeriod,
	BA.AccountRollup,
	BA.AccountRollupID,
	BA.Account,
	BA.Descr,
	BA.TranDesc,
	BA.Amt,
	BA.Qty
	from (
	
	Select
	Case When FB.Sub like '[12]04[012]____' then LEFT(rtrim(FB.Sub), 2) 
    + '40' + RIGHT(rtrim(FB.Sub), 4) else FB.Sub end as 'Sub',
	Case when left(rtrim(FB.Sub),4) in (1040,1041,1042,2040,2041,2042) then 'Farrowing'
	when left(rtrim(FB.Sub),4) in (1530,2130) then 'Nursery'
	when left(rtrim(FB.Sub),4) in (1531,2131) then 'Finish'
	when left(rtrim(FB.Sub),4) in (1532,2132) then 'WTF' else '' end as 'Division',
	Case when left(rtrim(FB.Sub),4) in (1040,1041,1042) then 'Commercial Farrowing'
	when left(rtrim(FB.Sub),4) in (2040,2041,2042) then 'Multiplication Farrowing'
	when left(rtrim(FB.Sub),4) in (1530) then 'Commercial Nursery'
	when left(rtrim(FB.Sub),4) in (2130) then 'Multiplication Nursery'
	when left(rtrim(FB.Sub),4) in (1531) then 'Commercial Finish'
	when left(rtrim(FB.Sub),4) in (2131) then 'Multiplication Finish'
	when left(rtrim(FB.Sub),4) in (1532) then 'Commercial WTF'
	when left(rtrim(FB.Sub),4) in (2132) then 'Multiplication WTF' else '' end as 'Department',
	Case when FB.Sub = '10408458' then 'C058' else Seg.Description end as 'Location', 
	'2012'+RIGHT(rtrim(FB.Period),2) AS 'GroupPeriod', 
	Case when ART.AccountRollupDescription is Null then 'Utilities' else ART.AccountRollupDescription end as 'AccountRollup',
	Case when ART.AccountRollupTypeID is Null then 13 else ART.AccountRollupTypeID end as 'AccountRollupID',
	Account.Acct as 'Account',
	Account.Descr, 
	'' as TranDesc, 
	'' as 'Amt',
	'' as 'Qty'
	From (
	
	Select 
	RIGHT(rtrim(Division),2)+RIGHT(rtrim(Department),2)+
	Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then '8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then '8122' else RIGHT(rtrim(Location),4) end as 'Sub',
	RIGHT(rtrim(Time),2) as 'Period',
	RIGHT(rtrim(Account),5) as 'Account',
	SUM(Total) as 'Amt'
	from  dbo.cft_PRODUCTION_PL_BUDGET
	--Where RIGHT(rtrim(Location),4) <> '8450'
	group by
	RIGHT(rtrim(Division),2)+RIGHT(rtrim(Department),2)+
	Case when RIGHT(rtrim(Location),4) in ('8100','8120','8140') then '8121' 
	when RIGHT(rtrim(Location),4) in ('8150','8170','8190') then '8122' else RIGHT(rtrim(Location),4) end,
	RIGHT(rtrim(Time),2),
	RIGHT(rtrim(Account),5)) FB

	left join [$(SolomonApp)].dbo.Account Account (nolock)
	ON FB.Account = Account.Acct

	left join [$(SolomonApp)].dbo.SubAcct SubAcct (nolock)
	ON FB.Sub = SubAcct.Sub

	left join [$(SolomonApp)].dbo.SegDef Seg (nolock)
	on right(rtrim(FB.Sub),4) = seg.ID and seg.SegNumber = 3

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP AR (nolock)
	on ar.account = account.acct
	and ar.division+ar.department = left(rtrim(FB.sub),4)

	left join [$(SolomonApp)].dbo.cft_ACCOUNT_ROLLUP_TYPE ART (nolock)
	on ar.accountrolluptypeid = art.accountrolluptypeid

	Where 
	Account.AcctType in ('3I','3E')
	and Account.Acct not in (90600,81600,40150,40160,40180,90100,73200,90200,40100,40120,41900,40155,41250,40130,40140,40170,40190,40200,40110,41310,41300,41800,41900,41100,41150,41200)
	and left(rtrim(FB.Sub),4) in (1040,1041,1042,2040,2041,2042,1530,1531,1532,2130,2131,2132) 
	and RIGHT(rtrim(FB.Sub),4) <> '0000'
	
	Group by
	FB.Sub, 
	ART.AccountRollupDescription,
	ART.AccountRollupTypeID,
	SubAcct.Descr, 
	Seg.Description,
	Seg.ID, 
	FB.Period, 
	Account.Acct,
	Account.Descr, 
	FB.Account) BA
	left join (Select Distinct Case When Sub like '[12]04[012]____' then LEFT(rtrim(Sub), 2) 
    + '40' + RIGHT(rtrim(Sub), 4) else Sub end as 'Sub', GroupPeriod, Account 
	from  dbo.cft_PRODUCTION_PL where GroupPeriod >= 200901) PL
	on BA.Sub = PL.Sub
	and BA.GroupPeriod = PL.GroupPeriod
	and BA.Account = PL.Account
	Where PL.Sub is null
	
END




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PROD_PL_INSERT_2] TO [db_sp_exec]
    AS [dbo];

