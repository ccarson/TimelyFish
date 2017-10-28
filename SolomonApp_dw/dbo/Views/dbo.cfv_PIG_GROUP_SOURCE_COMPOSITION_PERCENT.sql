CREATE VIEW cfv_PIG_GROUP_SOURCE_COMPOSITION_PERCENT
AS
select
NGSUM.CombWTFGroup,
NGSUM.NurGroupAlias,
NGSUM.NurHeadTransferred,
NGSUM.NurWtTransferred,
NGSUM.D1_TotHeadProduced,
NGSUM.D1_TotWtProduced,

cast(NGSUM.NurHeadTransferred as decimal)/cast(NGSUM.D1_TotHeadProduced as decimal) HCPctOfGroup,
cast(NGSUM.NurWtTransferred as decimal)/cast(NGSUM.D1_TotWtProduced as decimal) WtPctOfGroup,
NGSUM.D2_MasterGroup,
NGSUM.D2_PigGroupID
from (
select distinct
'FG'+D1D2.D1_PigGroup+'-'+rtrim(D1D2.D2_PigGroupID) CombWTFGroup,
D1D2.D1_PigGroup+'-'+
D1D2.D1_Description NurGroupAlias,
NG.D1_TotHeadProduced,
NG.D1_TotWtProduced,
sum(D1D2.D2_TI_Qty) NurHeadTransferred,
sum(D1D2.D2_TI_Wt) NurWtTransferred,
rtrim(D1D2.D2_MasterGroup) D2_MasterGroup,
rtrim(D1D2.D2_PigGroupID) D2_PigGroupID
from (
	select
	rtrim(it.SourcePigGroupID) D1_PigGroup,
	rtrim(S1.S1_Descr) D1_Description,
	S1.S1_Phase D1_Phase,
	it.acct D2_Acct,
	sum(it.Qty) D2_TI_Qty,
	sum(it.TotalWgt) D2_TI_Wt,
	rtrim(pg.TaskID) D2_PigGroup,
	rtrim(pg.Description) D2_Description,
	pg.PigProdPhaseID D2_Phase,
	'FG'+pg.CF03 D2_MasterGroup,
	it.PigGroupID D2_PigGroupID
	from [$(SolomonApp)].dbo.cftPGInvTran it WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=it.PigGroupID
	left join (
		select distinct it2.acct S1_Acct,
		pg2.PigGroupID S1_GroupID,
		pg2.Description S1_Descr,
		pg2.PGStatusID S1_Status,
		pg2.PigProdPhaseID S1_Phase,
		it2.BatNbr S1_BatNbr,
		it2.SourceRefNbr S1_RefNbr
		from [$(SolomonApp)].dbo.cftPGInvTran it2 WITH (NOLOCK)
		left join [$(SolomonApp)].dbo.cftPigGroup pg2 WITH (NOLOCK)
		on pg2.PigGroupID=it2.SourcePigGroupID
		where
		it2.Reversal='0'
		--where clause for testing
		--and pg2.PigGroupID=26729
		--where clause for testing
	) S1
	on S1.S1_BatNbr=it.BatNbr and S1.S1_RefNbr=it.SourceRefNbr
	where 
	it.Acct='PIG TRANSFER IN'
	and pg.PigGroupID<>S1.S1_GroupID
	and pg.PigSystemID='00'
	and pg.PigProdPhaseID in ('WTF','FIN')
	and pg.PGStatusID='I'
	and pg.ActCloseDate>='12/30/2007'
	group by
	it.acct,
	pg.TaskID,
	pg.Description,
	pg.PigProdPhaseID,
	pg.CF03,
	it.PigGroupID,
	it.SourcePigGroupID,
	S1.S1_Descr,
	S1.S1_Phase
	) D1D2
left join (
	select
	sum(it.Qty) D1_TotHeadProduced,
	sum(it.TotalWgt) D1_TotWtProduced,
	pg.PigGroupID NurGroupID,
	pg.Description NurGroupDescr
	from [$(SolomonApp)].dbo.cftPGInvTran it WITH (NOLOCK)
	left join [$(SolomonApp)].dbo.cftPigGroup pg WITH (NOLOCK)
	on pg.PigGroupID=it.PigGroupID
	where
	it.Reversal='0'
	and it.acct='PIG TRANSFER OUT'
	and pg.PGStatusID='I'
	group by
	pg.PigGroupID,
	pg.Description
	) NG
on NG.NurGroupID=D1D2.D1_PigGroup

group by
'FG'+D1D2.D1_PigGroup+'-'+rtrim(D1D2.D2_PigGroupID),
D1D2.D1_PigGroup+'-'+
D1D2.D1_Description,
NG.D1_TotHeadProduced,
NG.D1_TotWtProduced,
rtrim(D1D2.D2_MasterGroup),
rtrim(D1D2.D2_PigGroupID)
) NGSUM
