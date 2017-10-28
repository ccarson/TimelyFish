




create PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_CALCS]
AS
BEGIN

-- The data has been processed from fresh replication into cft_PIG_GROUP_ROLLUP already.
-- this can be run at any time as it does not rely on SolomonApp being available from replication.


--------------------------------------------------------------------------
-- LIVE PIG DAYS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET LivePigDays = LivePigDays.Days

FROM
(SELECT
pg.TaskID AS GroupNumber,
sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1) as Days
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
	ON pg.PigProdPhaseID = p.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPGInvTran as pit
	ON 'PG'+pit.PigGroupID = pg.TaskID
LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
	ON pg.PigGroupID = gStart.PigGroupID
WHERE
pit.acct <> 'pig death' and
pit.trantypeid <> 'ia' and
pit.Reversal <> 1 and pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00'
group by
pg.TaskID) LivePigDays
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(LivePigDays.GroupNumber)

--------------------------------------------------------------------------
-- DEAD PIG DAYS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET DeadPigDays = DeadPigDays.Days

FROM
(SELECT
pg.TaskID AS GroupNumber,
sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1) as Days
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(pg.TaskID)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
	ON pg.PigProdPhaseID = p.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
	ON 'PG'+pit.PigGroupID = pg.TaskID
LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart WITH (NOLOCK)
ON pg.PigGroupID = gStart.PigGroupID
WHERE
--pg.ActStartDate > '1/1/1900' and
pit.acct = 'pig death'
AND pit.trantypeid <> 'ia'
AND pit.Reversal <> 1 and pg.PGStatusID='I'
AND PG.ActCloseDate>='12/28/2008'
--AND pg.PigProdPhaseID in ('FIN','NUR')
AND PG.PigSystemID = '00'
GROUP BY
pg.TaskID) DeadPigDays
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(DeadPigDays.GroupNumber)

--------------------------------------------------------------------------
-- TOTAL PIG DAYS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET TotalPigDays = TotalPigDays.TotalPigDays

FROM
(select
pg.TaskID AS GroupNumber,
sum((cast(pit.Trandate as Int)-(cast(gStart.TranDate as Int)))* Pit.qty * pit.InvEffect * -1) as TotalPigDays
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
ON pg.PigProdPhaseID = p.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPGInvTran as pit
on 'PG'+pit.PigGroupID = pg.TaskID
LEFT OUTER JOIN [$(SolomonApp)].dbo.vCFPigGroupStart AS gStart
ON pg.PigGroupID = gStart.PigGroupID
WHERE
pit.trantypeid <> 'ia' and
pit.Reversal <> 1 and pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00'
group by
pg.TaskID) TotalPigDays
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(TotalPigDays.GroupNumber)


--------------------------------------------------------------------------
-- FEED QTY
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET Feed_Qty = FeedQty.FeedQty

FROM
(SELECT
PG.TaskID,
sum(pjp.act_units) as FeedQty

FROM [$(SolomonApp)].dbo.cftPigGroup PG WITH (NOLOCK)
INNER JOIN [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	ON pjp.pjt_entity = PG.TaskID
WHERE
pjp.acct = 'Pig Feed Issue'
AND PG.PGStatusID='I'
AND PG.ActCloseDate>='12/28/2008'
--AND pg.PigProdPhaseID in ('FIN','NUR')
AND PG.PigSystemID = '00'
GROUP BY
PG.TaskID) FeedQty
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(FeedQty.TaskID)

--------------------------------------------------------------------------
-- INVENTORY
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 
	TransferIn_Qty = inventory.TI_Qty
,	MoveIn_Qty = inventory.MI_Qty
,	MoveOut_Qty = inventory.MO_Qty
,	PigDeath_Qty = inventory.DeathQty
,	TransferOut_Qty = inventory.TO_Qty
,	TransferToTailender_Qty = inventory.TE_Qty
,	Prim_Qty = inventory.Prim_Qty
,	Top_Qty = inventory.Top_Qty
,	Cull_Qty = inventory.Cull_Qty
,	DeadPigsToPacker_Qty = inventory.DP_Qty
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
,	DeadOnTruck_Qty = inventory.DT_Qty
,	DeadInYard_Qty = inventory.DY_Qty
,	Condemned_Qty = inventory.CD_Qty
,	CondemnedByPacker_Qty = inventory.CP_Qty
--
--,	TransportDeath_Qty = inventory.TD_Qty
,	TransportDeath_Qty = inventory.dot_td_Qty			--2013 sripley SLF changes		
,	euthanized_Qty = inventory.euthanized_Qty			--2013 sripley SLF changes
,	Deadb4Grade_Death_Qty = inventory.deadb4grd_Qty		--2013 sripley SLF changes
,	InventoryAdjustment_Qty = inventory.IA_Qty

FROM
(select
pg.TaskID,
isnull(itti.TI_Qty,0) TI_Qty,
isnull(itmi.MI_Qty,0) MI_Qty,
isnull(itmo.MO_Qty,0) MO_Qty,
isnull(itpd.DeathQty,0) DeathQty,
isnull(itto.TO_Qty,0) TO_Qty,
isnull(itte.TE_Qty,0) TE_Qty,
isnull(itps.Prim_Qty,0) Prim_Qty,
isnull(itps.Top_Qty,0) Top_Qty,
isnull(itps.Cull_Qty,0) Cull_Qty,
isnull(itps.DP_Qty,0) DP_Qty,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
isnull(itps.DT_Qty,0) DT_Qty,
isnull(itps.DY_Qty,0) DY_Qty,
isnull(itps.CD_Qty,0) CD_Qty,
isnull(itps.CP_Qty,0) CP_Qty,
--
--isnull(ittd.TD_Qty,0) TD_Qty,				--2013 sripley SLF changes
isnull(ittd.euthanized_Qty,0) euthanized_Qty,				--2013 sripley SLF changes
isnull(ittd.deadb4grd_Qty,0) deadb4grd_Qty,				--2013 sripley SLF changes
isnull(ittd.dot_td_Qty,0) dot_td_Qty,				--2013 sripley SLF changes
isnull(itia.IA_Qty,0) IA_Qty
from [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
left join
(select
pit.PigGroupID,
sum(pit.Qty) DeathQty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct='PIG DEATH'
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itpd
on 'PG'+itpd.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) IA_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct='PIG INV ADJ'
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itia 
on 'PG'+itia.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) MI_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct='PIG MOVE IN'
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itmi 
on 'PG'+itmi.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) MO_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where (pit.acct='PIG MOVE OUT'
and pit.TranSubTypeID not in ('FT'))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itmo
on 'PG'+itmo.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) TI_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct in ('PIG PURCHASE','PIG TRANSFER IN')
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itti
on 'PG'+itti.PigGroupID = pg.TaskID

left join
(select ps2.PigGroupID,
isnull(sum(ps2.Prim_Qty),0) Prim_Qty,
isnull(sum(ps2.Top_Qty),0) Top_Qty,
isnull(sum(ps2.Cull_Qty),0) Cull_Qty,
isnull(sum(ps2.DP_Qty),0) DP_Qty,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
isnull(sum(ps2.DT_Qty),0) DT_Qty,
isnull(sum(ps2.DY_Qty),0) DY_Qty,
isnull(sum(ps2.CP_Qty),0) CP_Qty,
isnull(sum(ps2.CD_Qty),0) CD_Qty
--
from (
select
pit.PigGroupID,
case when p.PrimaryPacker=1 and psd.DetailTypeID='SS'
then psd.Qty end Prim_Qty,
case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID = '10'
then psd.Qty end Top_Qty,
case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
then psd.Qty
when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
then pit.Qty
end Cull_Qty,
case when (psd.DetailTypeID in ('DT','DY','CP','CD'))
then psd.Qty end DP_Qty,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
case when psd.DetailTypeID = 'DT'
then psd.Qty end DT_Qty,
case when psd.DetailTypeID = 'DY'
then psd.Qty end DY_Qty,
case when psd.DetailTypeID = 'CP'
then psd.Qty end CP_Qty,
case when psd.DetailTypeID = 'CD'
then psd.Qty end CD_Qty
--
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigSale as ps WITH (NOLOCK)
on ps.BatNbr=pit.SourceBatNbr and ps.RefNbr=pit.SourceRefNbr
left join [$(SolomonApp)].dbo.cftPM as pm WITH (NOLOCK)
on pm.PMID=ps.PMLoadID
left join [$(SolomonApp)].dbo.cftPacker as p WITH (NOLOCK)
on p.ContactID=ps.PkrContactID
left join [$(SolomonApp)].dbo.cftPSDetail as psd WITH (NOLOCK)
on psd.BatNbr=ps.BatNbr and psd.RefNbr=ps.RefNbr
where pit.acct in ('PIG SALE','PIG TRANSFER OUT')
and pit.Reversal <> 1) ps2
group by
ps2.PigGroupID)
as itps
on 'PG'+itps.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) TO_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where (pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID not in ('FT','WT','WC','FC'))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itto
on 'PG'+itto.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.Qty) TE_Qty
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where ((pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID in ('FT','WT'))
or (pit.acct = 'PIG MOVE OUT'
and pit.TranSubTypeID in ('FT')))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itte
--on 'PG'+itte.PigGroupID = pg.TaskID
--left join
--(select
--pit.PigGroupID,
--sum(pit.Qty) TD_Qty
--from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
--where pit.acct = 'TRANSPORT DEATH'
--and pit.Reversal <> 1
--group by
--pit.PigGroupID)
--as ittd
--on 'PG'+ittd.PigGroupID = pg.TaskID
--where
--pg.PGStatusID='I'
--and PG.ActCloseDate>='12/28/2008'
----and pg.PigProdPhaseID in ('FIN','NUR')
--and PG.PigSystemID = '00'
--) inventory
on 'PG'+itte.PigGroupID = pg.TaskID
left join
(select sumit.piggroupid, sum(sumit.euthanized_Qty) euthanized_Qty, sum(sumit.deadb4grd_Qty) deadb4grd_Qty, sum(sumit.dot_td_Qty) dot_td_Qty
from
(select
pit.PigGroupID,
--sum(pit.Qty) TD_Qty	,									--2013 sripley SLF changes
case														--2013 sripley SLF changes
	when gd.piggradecattypeid = '03' THEN	sum(pit.Qty) 	--2013 sripley SLF changes
end	euthanized_Qty,											--2013 sripley SLF changes
case														--2013 sripley SLF changes
	when gd.piggradecattypeid = '04' THEN	sum(pit.Qty) 	--2013 sripley SLF changes
end	deadb4grd_Qty,											--2013 sripley SLF changes
case														--2013 sripley SLF changes
	when gd.piggradecattypeid = '05' THEN	sum(pit.Qty) 	--2013 sripley SLF changes
end	dot_td_Qty												--2013 sripley SLF changes
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
inner join [$(SolomonApp)].dbo.cftpmgradeqty gd (nolock)			--2013 sripley SLF changes
	on gd.batchnbr = Pit.batnbr and gd.refnbr = Pit.sourcerefnbr and gd.linenbr = Pit.sourcelinenbr		--2013 sripley SLF changes
where pit.acct in ('transport death','PIG DEATH')			--2013 sripley SLF changes
and pit.Reversal <> 1
group by
pit.PigGroupID ,gd.piggradecattypeid						--2013 sripley SLF changes
) sumit
group by sumit.piggroupid)
as ittd
on 'PG'+ittd.PigGroupID = pg.TaskID
where
pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00'
) inventory
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(inventory.TaskID)

--------------------------------------------------------------------------
-- WEIGHT
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET
	TransferIn_Wt = weight.TI_Wt
,	MoveIn_Wt = weight.MI_Wt
,	MoveOut_Wt = weight.MO_Wt
,	TransferOut_Wt = weight.TO_Wt
,	TransferToTailender_Wt = weight.TE_Wt
,	Prim_Wt = Weight.Prim_Wt
,	Top_Wt = Weight.Top_Wt
,	Cull_Wt = weight.Cull_Wt
,	DeadPigsToPacker_Wt = weight.DP_Wt
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
,	DeadOnTruck_Wt = weight.DT_Wt
,	DeadInYard_Wt = weight.DY_Wt
,	Condemned_Wt = weight.CD_Wt
,	CondemnedByPacker_Wt = weight.CP_Wt
--
--,	TransportDeath_Wt = weight.TD_Wt	--2013 sripley SLF changes
,	TransportDeath_Wt = weight.dot_td_Wt	--2013 sripley SLF changes
,	[euthanized_Wt] = weight.euthanized_Wt			--2013 sripley SLF changes
,	[Deadb4Grade_Death_Wt] = weight.deadb4grd_Wt	--2013 sripley SLF changes

FROM
(select
pg.TaskID,
isnull(itti.TI_Wt,0) TI_Wt,
isnull(itmi.MI_Wt,0) MI_Wt,
isnull(itmo.MO_Wt,0) MO_Wt,
isnull(itto.TO_Wt,0) TO_Wt,
isnull(itte.TE_Wt,0) TE_Wt,
isnull(itps.Prim_Wt,0) Prim_Wt,
isnull(itps.Top_Wt,0) Top_Wt,
isnull(itps.Cull_Wt,0) Cull_Wt,
isnull(itps.DP_Wt,0) DP_Wt,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
isnull(itps.DT_Wt,0) DT_Wt,
isnull(itps.DY_Wt,0) DY_Wt,
isnull(itps.CD_Wt,0) CD_Wt,
isnull(itps.CP_Wt,0) CP_Wt,
--
--isnull(ittd.TD_Wt,0) TD_Wt		--2013 sripley SLF changes
isnull(ittd.euthanized_Wt,0) euthanized_Wt,				--2013 sripley SLF changes
isnull(ittd.deadb4grd_Wt,0) deadb4grd_Wt,				--2013 sripley SLF changes
isnull(ittd.dot_td_Wt,0) dot_td_Wt				--2013 sripley SLF changes

from [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
left join
(select
pit.PigGroupID,
sum(pit.TotalWgt) MI_Wt
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct='PIG MOVE IN'
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itmi 
on 'PG'+itmi.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.TotalWgt) MO_Wt
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where (pit.acct='PIG MOVE OUT'
and pit.TranSubTypeID not in ('FT'))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itmo
on 'PG'+itmo.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.TotalWgt) TI_Wt
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where pit.acct in ('PIG PURCHASE','PIG TRANSFER IN')
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itti
on 'PG'+itti.PigGroupID = pg.TaskID
left join
(select ps2.PigGroupID,
isnull(sum(ps2.Prim_Wt),0) Prim_Wt,
isnull(sum(ps2.Top_Wt),0) Top_Wt,
isnull(sum(ps2.Cull_Wt),0) Cull_Wt,
isnull(sum(ps2.DP_Wt),0) DP_Wt,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
isnull(sum(ps2.DT_Wt),0) DT_Wt,
isnull(sum(ps2.DY_Wt),0) DY_Wt,
isnull(sum(ps2.CP_Wt),0) CP_Wt,
isnull(sum(ps2.CD_Wt),0) CD_Wt
--
from (
select
pit.PigGroupID,
case when p.PrimaryPacker=1 and psd.DetailTypeID='SS'
then psd.WgtLive end Prim_Wt,
case when p.PrimaryPacker=1 and psd.DetailTypeID='SS' and pm.MarketSaleTypeID = '10'
then psd.WgtLive end Top_Wt,
case when (p.PrimaryPacker=1 and psd.DetailTypeID not in ('SS','DT','DY','CP','CD'))
or (p.PrimaryPacker=0 and psd.DetailTypeID not in ('DT','DY','CP','CD'))
then psd.WgtLive
when (pit.acct = 'PIG TRANSFER OUT' and pit.TranSubTypeID in ('WC','FC'))
then pit.TotalWgt
end Cull_Wt,
case when (psd.DetailTypeID in ('DT','DY','CP','CD'))
then psd.WgtLive end DP_Wt,
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
case when psd.DetailTypeID = 'DT'
then psd.WgtLive end DT_Wt,
case when psd.DetailTypeID = 'DY'
then psd.WgtLive end DY_Wt,
case when psd.DetailTypeID = 'CP'
then psd.WgtLive end CP_Wt,
case when psd.DetailTypeID = 'CD'
then psd.WgtLive end CD_Wt
--
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
left join [$(SolomonApp)].dbo.cftPigSale as ps WITH (NOLOCK)
on ps.BatNbr=pit.SourceBatNbr and ps.RefNbr=pit.SourceRefNbr
left join [$(SolomonApp)].dbo.cftPM as pm WITH (NOLOCK)
on pm.PMID=ps.PMLoadID
left join [$(SolomonApp)].dbo.cftPacker as p WITH (NOLOCK)
on p.ContactID=ps.PkrContactID
left join [$(SolomonApp)].dbo.cftPSDetail as psd WITH (NOLOCK)
on psd.BatNbr=ps.BatNbr and psd.RefNbr=ps.RefNbr
where pit.acct in ('PIG SALE','PIG TRANSFER OUT')
and pit.Reversal <> 1) ps2
group by
ps2.PigGroupID)
as itps
on 'PG'+itps.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.TotalWgt) TO_Wt
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where (pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID not in ('FT','WT','WC','FC'))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itto
on 'PG'+itto.PigGroupID = pg.TaskID
left join
(select
pit.PigGroupID,
sum(pit.TotalWgt) TE_Wt
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
where ((pit.acct = 'PIG TRANSFER OUT'
and pit.TranSubTypeID in ('FT','WT'))
or (pit.acct = 'PIG MOVE OUT'
and pit.TranSubTypeID in ('FT')))
and pit.Reversal <> 1
group by
pit.PigGroupID)
as itte
--on 'PG'+itte.PigGroupID = pg.TaskID
--left join
--(select
--pit.PigGroupID,
--sum(pit.TotalWgt) TD_Wt
--from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
--where pit.acct = 'TRANSPORT DEATH'
--and pit.Reversal <> 1
--group by
--pit.PigGroupID)
--as ittd
--on 'PG'+ittd.PigGroupID = pg.TaskID
--where
--pg.PGStatusID='I'
--and PG.ActCloseDate>='12/28/2008'
----and pg.PigProdPhaseID in ('FIN','NUR')
--and PG.PigSystemID = '00') weight
on 'PG'+itte.PigGroupID = pg.TaskID
left join
(select sumit.piggroupid, sum(sumit.euthanized_Wt) euthanized_Wt, sum(sumit.deadb4grd_Wt) deadb4grd_Wt, sum(sumit.dot_td_Wt) dot_td_Wt
from
(select
pit.PigGroupID,
--sum(pit.TotalWgt) TD_Wt	,						--2013 sripley SLF changes
case		--2013 sripley SLF changes
	when gd.piggradecattypeid = '03' THEN	sum(pit.TotalWgt) 	--2013 sripley SLF changes
end	euthanized_Wt,		--2013 sripley SLF changes
case		--2013 sripley SLF changes
	when gd.piggradecattypeid = '04' THEN	sum(pit.TotalWgt) 	--2013 sripley SLF changes
end	deadb4grd_Wt,	--2013 sripley SLF changes
case		--2013 sripley SLF changes
	when gd.piggradecattypeid = '05' THEN	sum(pit.TotalWgt) 	--2013 sripley SLF changes
end	dot_td_Wt	--2013 sripley SLF changes
from [$(SolomonApp)].dbo.cftPGInvTran as pit WITH (NOLOCK)
inner join [$(SolomonApp)].dbo.cftpmgradeqty gd (nolock)	--2013 sripley SLF changes
	on gd.batchnbr = Pit.batnbr and gd.refnbr = Pit.sourcerefnbr and gd.linenbr = Pit.sourcelinenbr		--2013 sripley SLF changes
where pit.acct in ('TRANSPORT DEATH', 'pig death')
and pit.Reversal <> 1
group by
pit.PigGroupID ,gd.piggradecattypeid
) sumit
group by sumit.piggroupid)
as ittd
on 'PG'+ittd.PigGroupID = pg.TaskID
where
pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00') weight
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(weight.TaskID)

--------------------------------------------------------------------------
-- MEDICATION COSTS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET MedicationCost = MedCosts.PIG_MEDS_COST

FROM
(select
pg.TaskID,
sum(pjp.act_amount) as PIG_MEDS_COST 
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
ON pg.PigProdPhaseID = p.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.PJPTDSUM pjp WITH (NOLOCK)
on pjp.pjt_entity = pg.TaskID
WHERE
pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00'
and pjp.Acct in ('PIG MEDS CHG','PIG MEDS ISSUE')
group by
pg.TaskID) MedCosts
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(MedCosts.TaskID)

--------------------------------------------------------------------------
-- SITE CLOSEOUT CALCS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET	WeightGained =
		Prim_Wt + Cull_Wt + DeadPigsToPacker_Wt + TransferToTailender_Wt + TransferOut_Wt + TransportDeath_Wt + MoveOut_Wt - MoveIn_Wt - TransferIn_Wt
,	HeadStarted =
		TransferIn_Qty + MoveIn_Qty - MoveOut_Qty
,	TotalHeadProduced =
		Prim_Qty + Cull_Qty + DeadPigsToPacker_Qty + TransferToTailender_Qty + TransferOut_Qty

UPDATE cft_PIG_GROUP_ROLLUP
SET	AverageDailyGain =
		case when isnull(TotalPigDays,0) <> 0
			then isnull(WeightGained,0) / TotalPigDays
			else 0
		end
,	FeedToGain =
		case when isnull(WeightGained,0) <> 0
			then isnull(Feed_Qty,0) / WeightGained
			else 0
		end
,	Mortality =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	AveragePurchase_Wt =
		case when isnull(TransferIn_Qty,0) <> 0
			then isnull(TransferIn_Wt,0) / TransferIn_Qty
			else 0
		end
,	AverageOut_Wt =
		case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
		end
,	AverageDailyFeedIntake =
		case when isnull(TotalPigDays,0) <> 0
			then isnull(Feed_Qty,0) / TotalPigDays
			else 0
		end
,	Tailender_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(TransferToTailender_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	DeadPigsToPacker_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(DeadPigsToPacker_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	Cull_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(Cull_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	NoValue_Pct =
		case when isnull(HeadStarted,0) <> 0
			then ((cast(isnull(TransportDeath_Qty,0) as numeric(14,2)) + cast(isnull(DeadPigsToPacker_Qty,0) as numeric(14,2))) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	MedicationCostPerHead =
		case when isnull(TotalHeadProduced,0) <> 0
			then isnull(MedicationCost,0) / TotalHeadProduced
			else 0
		end

-- 20120720 smr added this column as per Mike Z request		
UPDATE cft_PIG_GROUP_ROLLUP
SET	AdjAverageDailyGain =
            case
                  when Phase = 'NUR'
                        then case when isnull(TotalHeadProduced,0) = 0 then 0 
                        else case when (LivePigDays / TotalHeadProduced) <= 43
                        then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) + AverageDailyGain
                        else AverageDailyGain - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((50 - AveragePurchase_Wt) * 0.005)
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end  
                  else AverageDailyGain
            end


UPDATE cft_PIG_GROUP_ROLLUP
SET	AdjFeedToGain =
		case 
			when Phase = 'NUR'
				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
			when Phase = 'FIN'
				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
			when Phase = 'WTF'
				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
			else FeedToGain
		end

--------------------------------------------------------------------------
-- VACCINATION COSTS
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET VaccinationCost = VaccCosts.PIG_VACC_COST

FROM
(select
pg.TaskID,
sum(pjp.act_amount) as PIG_VACC_COST 
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
ON pg.PigProdPhaseID = p.PigProdPhaseID
LEFT OUTER JOIN [$(SolomonApp)].dbo.PJPTDSUM pjp WITH (NOLOCK)
on pjp.pjt_entity = pg.TaskID
WHERE
pg.PGStatusID='I'
and PG.ActCloseDate>='12/28/2008'
--and pg.PigProdPhaseID in ('FIN','NUR')
and PG.PigSystemID = '00'
and pjp.Acct in ('PIG VACC CHG','PIG VACC ISSUE')
group by
pg.TaskID) VaccCosts
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(VaccCosts.TaskID)


--------------------------------------------------------------------------
-- FEED COST
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET FeedCost = FeedCost.FeedCost

FROM
(SELECT
PG.TaskID,
sum(pjp.act_amount) as FeedCost

FROM [$(SolomonApp)].dbo.cftPigGroup PG WITH (NOLOCK)
INNER JOIN [$(SolomonApp)].dbo.PJPTDSUM as pjp WITH (NOLOCK)
	ON pjp.pjt_entity = PG.TaskID
WHERE
pjp.acct in ('PIG FEED ISSUE','PIG FEED DELIV','PIG FEED GRD MIX')
AND PG.PGStatusID='I'
AND PG.ActCloseDate>='12/28/2008'
--AND pg.PigProdPhaseID in ('FIN','NUR')
AND PG.PigSystemID = '00'
GROUP BY
PG.TaskID) FeedCost
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(FeedCost.TaskID)


--------------------------------------------------------------------------
-- HEAD CAPACITY
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET HeadCapacity = HdCapacity.HeadCapacity

FROM
(select
pg.TaskID AS GroupNumber,
[$(SolomonApp)].dbo.PGGetMaxCapacity(right(rtrim(pg.TaskID),5)) AS HeadCapacity
FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
WHERE pg.ActCloseDate>='12/28/2008'
and pg.PigSystemID = '00') HdCapacity
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(HdCapacity.GroupNumber)

--------------------------------------------------------------------------
-- PIG START DATE
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET PigStartDate = PigStartDate.PigStartDate

FROM
(SELECT
'PG'+rtrim(ps.PigGroupID) AS GroupNumber,
ps.TranDate AS PigStartDate
FROM [$(SolomonApp)].dbo.vCFPigGroupStart AS ps WITH (NOLOCK)
) PigStartDate
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(PigStartDate.GroupNumber)

--------------------------------------------------------------------------
-- PIG END DATE
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET PigEndDate = PigEndDate.PigEndDate

FROM
(SELECT
'PG'+rtrim(pe.PigGroupID) AS GroupNumber,
pe.TranDate AS PigEndDate
FROM [$(SolomonApp)].dbo.vCFPigGroupEnd AS pe WITH (NOLOCK)
) PigEndDate
JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(PigEndDate.GroupNumber)

--------------------------------------------------------------------------
-- Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET HeadSold = Prim_Qty + Cull_Qty + DeadPigsToPacker_Qty + TransferOut_Qty
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Average Market Weight
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	AverageMarket_Wt = 
		CASE WHEN HeadSold = 0
			THEN 0
			ELSE (Prim_Wt + Cull_Wt + DeadPigsToPacker_Wt + TransferToTailender_Wt + TransferOut_Wt) / HeadSold
		END
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Days in Group
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET	DaysInGroup = DateDiff(d,PigStartDate, PigEndDate)
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Pig Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET	PigCapacityDays = DaysInGroup * HeadCapacity
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Empty Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET	EmptyDays = DateDiff(d,ActStartDate +1, PigStartDate)
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Empty Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	EmptyCapacityDays = EmptyDays * HeadCapacity
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	CapacityDays = EmptyDays + DaysInGroup
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Total Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	TotalCapacityDays = CapacityDays * HeadCapacity
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Average Days In Group
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	AverageDaysInGroup = 
	CASE WHEN HeadCapacity = 0
		THEN 0
		ELSE PigCapacityDays / HeadCapacity
	END
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Average Empty Days
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	AverageEmptyDays = 
	CASE WHEN HeadCapacity = 0
		THEN 0
		ELSE EmptyCapacityDays / HeadCapacity
	END
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Utilization
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	Utilization = 
	CASE WHEN TotalCapacityDays = 0
		THEN 0
		ELSE CAST(CAST(TotalPigDays AS NUMERIC(14,2)) / CAST(TotalCapacityDays AS NUMERIC(14,2)) * 100 AS NUMERIC(14,2))
	END
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Medication Cost Per Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	MedicationCostPerHeadSold = 
	ISNULL(CASE WHEN HeadSold = 0
		THEN 0
		ELSE MedicationCost / HeadSold
	END,0)
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Vaccination Cost Per Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	VaccinationCostPerHeadSold = 
	ISNULL(CASE WHEN HeadSold = 0
		THEN 0
		ELSE VaccinationCost / HeadSold
	END,0)
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Feed Cost Per Hundred Pounds Gained
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET 	FeedCostPerHundredGain = 
	ISNULL(CASE WHEN WeightGained = 0
		THEN 0
		ELSE FeedCost / WeightGained * 100
	END,0)
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)






--------------------------------------------------------------------------
-- CREATE MASTER GROUP DATA
--------------------------------------------------------------------------
truncate table dbo.cft_PIG_MASTER_GROUP_ROLLUP

INSERT INTO cft_PIG_MASTER_GROUP_ROLLUP (MasterGroup)
SELECT DISTINCT cft_PIG_GROUP_ROLLUP.MasterGroup FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE EXISTS (SELECT * FROM dbo.cfv_PIG_MASTER_GROUP_ELIGIBLE WHERE MasterGroup = cft_PIG_GROUP_ROLLUP.MasterGroup)

UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET	ActCloseDate = MasterRollup.ActCloseDate
,	ActStartDate = MasterRollup.ActStartDate
,	BarnNbr = NULL
,	Description = 'Site'
,	PodDescription = NULL
,	Phase = MasterRollup.Phase
,	LivePigDays = MasterRollup.LivePigDays
,	DeadPigDays = MasterRollup.DeadPigDays
,	TotalPigDays = MasterRollup.TotalPigDays
,	Feed_Qty = MasterRollup.Feed_Qty
,	TransferIn_Qty = MasterRollup.TransferIn_Qty
,	MoveIn_Qty = MasterRollup.MoveIn_Qty
,	MoveOut_Qty = MasterRollup.MoveOut_Qty
,	PigDeath_Qty = MasterRollup.PigDeath_Qty
,	TransferOut_Qty = MasterRollup.TransferOut_Qty
,	TransferToTailender_Qty = MasterRollup.TransferToTailender_Qty
,	Prim_Qty = MasterRollup.Prim_Qty
,	Top_Qty = MasterRollup.Top_Qty
,	Cull_Qty = MasterRollup.Cull_Qty
,	DeadPigsToPacker_Qty = MasterRollup.DeadPigsToPacker_Qty
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
,	DeadOnTruck_Qty = MasterRollup.DeadOnTruck_Qty
,	DeadInYard_Qty = MasterRollup.DeadInYard_Qty
,	Condemned_Qty = MasterRollup.Condemned_Qty
,	CondemnedByPacker_Qty = MasterRollup.CondemnedByPacker_Qty
--
--,	TransportDeath_Qty = MasterRollup.TransportDeath_Qty
,	TransportDeath_Qty = MasterRollup.TransportDeath_Qty			--2013 sripley SLF changes		
,	euthanized_Qty = MasterRollup.euthanized_Qty			--2013 sripley SLF changes
,	Deadb4Grade_Death_Qty = MasterRollup.Deadb4Grade_Death_qty		--2013 sripley SLF changes
,	InventoryAdjustment_Qty = MasterRollup.InventoryAdjustment_Qty
,	TransferIn_Wt = MasterRollup.TransferIn_Wt
,	MoveIn_Wt = MasterRollup.MoveIn_Wt
,	MoveOut_Wt = MasterRollup.MoveOut_Wt
,	TransferOut_Wt = MasterRollup.TransferOut_Wt
,	TransferToTailender_Wt = MasterRollup.TransferToTailender_Wt
,	Prim_Wt = MasterRollup.Prim_Wt
,	Top_Wt = MasterRollup.Top_Wt
,	Cull_Wt = MasterRollup.Cull_Wt
,	DeadpigsToPacker_Wt = MasterRollup.DeadPigsToPacker_Wt
--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
,	DeadOnTruck_Wt = MasterRollup.DeadOnTruck_Wt
,	DeadInYard_Wt = MasterRollup.DeadInYard_Wt
,	Condemned_Wt = MasterRollup.Condemned_Wt
,	CondemnedByPacker_Wt = MasterRollup.CondemnedByPacker_Wt
--
--,	TransportDeath_Wt = MasterRollup.TransportDeath_Wt	--2013 sripley SLF changes
,	TransportDeath_Wt = MasterRollup.TransportDeath_Wt	--2013 sripley SLF changes
,	[euthanized_Wt] = MasterRollup.euthanized_Wt			--2013 sripley SLF changes
,	[Deadb4Grade_Death_Wt] = MasterRollup.Deadb4Grade_Death_wt	--2013 sripley SLF changes
,	MedicationCost = MasterRollup.MedicationCost
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT	MasterGroup, Phase
			,	MAX(cft_PIG_GROUP_ROLLUP.ActCloseDate) ActCloseDate
			,	MIN(cft_PIG_GROUP_ROLLUP.ActStartDate) ActStartDate
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.LivePigDays),0) LivePigDays
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadPigDays),0) DeadPigDays
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TotalPigDays),0) TotalPigDays
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Feed_Qty),0) Feed_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferIn_Qty),0) TransferIn_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.MoveIn_Qty),0) MoveIn_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.MoveOut_Qty),0) MoveOut_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.PigDeath_Qty),0) PigDeath_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferOut_Qty),0) TransferOut_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferToTailender_Qty),0) TransferToTailender_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Prim_Qty),0) Prim_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Top_Qty),0) Top_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Cull_Qty),0) Cull_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Qty),0) DeadPigsToPacker_Qty
			--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadOnTruck_Qty),0) DeadOnTruck_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadInYard_Qty),0) DeadInYard_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Condemned_Qty),0) Condemned_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.CondemnedByPacker_Qty),0) CondemnedByPacker_Qty
			--			
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransportDeath_Qty),0) TransportDeath_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.euthanized_Qty),0) euthanized_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Deadb4Grade_Death_Qty),0) Deadb4Grade_Death_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.InventoryAdjustment_Qty),0) InventoryAdjustment_Qty
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferIn_Wt),0) TransferIn_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.MoveIn_Wt),0) MoveIn_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.MoveOut_Wt),0) MoveOut_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferOut_Wt),0) TransferOut_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransferToTailender_Wt),0) TransferToTailender_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Prim_Wt),0) Prim_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Top_Wt),0) Top_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Cull_Wt),0) Cull_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Wt),0) DeadpigsToPacker_Wt
			--Broke apart DeadPigsToPacker into DeadOnTruck, DeadInYard, Condemned, ComdemnedbyPacker
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadOnTruck_Wt),0) DeadOnTruck_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.DeadInYard_Wt),0) DeadInYard_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Condemned_Wt),0) Condemned_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.CondemnedByPacker_Wt),0) CondemnedByPacker_Wt
			--			
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.TransportDeath_Wt),0) TransportDeath_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.euthanized_Wt),0) euthanized_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.Deadb4Grade_Death_Wt),0) Deadb4Grade_Death_Wt
			,	ISNULL(SUM(cft_PIG_GROUP_ROLLUP.MedicationCost),0) MedicationCost
FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
GROUP BY MasterGroup, Phase) MasterRollup
	ON MasterRollup.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup


--------------------------------------------------------------------------
-- MASTER GROUP SITE CLOSEOUT CALCS
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET	WeightGained =
		Prim_Wt + Cull_Wt + DeadPigsToPacker_Wt + TransferToTailender_Wt + TransferOut_Wt + TransportDeath_Wt + MoveOut_Wt - MoveIn_Wt - TransferIn_Wt
,	HeadStarted =
		TransferIn_Qty + MoveIn_Qty - MoveOut_Qty
,	TotalHeadProduced =
		Prim_Qty + Cull_Qty + DeadPigsToPacker_Qty + TransferToTailender_Qty + TransferOut_Qty

UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET	AverageDailyGain =
		case when isnull(TotalPigDays,0) <> 0
			then isnull(WeightGained,0) / TotalPigDays
			else 0
		end
,	FeedToGain =
		case when isnull(WeightGained,0) <> 0
			then isnull(Feed_Qty,0) / WeightGained
			else 0
		end
,	Mortality =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	AveragePurchase_Wt =
		case when isnull(TransferIn_Qty,0) <> 0
			then isnull(TransferIn_Wt,0) / TransferIn_Qty
			else 0
		end
,	AverageOut_Wt =
		case when (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0)) <> 0
			then (isnull(Prim_Wt,0) + isnull(Cull_Wt,0) + isnull(DeadPigsToPacker_Wt,0) + isnull(TransferToTailender_Wt,0) + isnull(TransferOut_Wt,0) + isnull(TransportDeath_Wt,0)) / (isnull(TotalHeadProduced,0) + isnull(TransportDeath_Qty,0))
			else 0
		end
,	AverageDailyFeedIntake =
		case when isnull(TotalPigDays,0) <> 0
			then isnull(Feed_Qty,0) / TotalPigDays
			else 0
		end
,	Tailender_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(TransferToTailender_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	DeadPigsToPacker_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(DeadPigsToPacker_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	Cull_Pct =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(Cull_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	NoValue_Pct =
		case when isnull(HeadStarted,0) <> 0
			then ((cast(isnull(TransportDeath_Qty,0) as numeric(14,2)) + cast(isnull(DeadPigsToPacker_Qty,0) as numeric(14,2))) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	MedicationCostPerHead =
		case when isnull(TotalHeadProduced,0) <> 0
			then isnull(MedicationCost,0) / TotalHeadProduced
			else 0
		end	

UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET	AdjAverageDailyGain =
            case
                  when Phase = 'NUR'
                        then case when isnull(TotalHeadProduced,0) = 0 then 0 
                        else case when (LivePigDays / TotalHeadProduced) <= 43
                        then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) + AverageDailyGain
                        else AverageDailyGain - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((50 - AveragePurchase_Wt) * 0.005)
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end  
                  else AverageDailyGain
            end

UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET	AdjFeedToGain =
		case 
			when Phase = 'NUR'
				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
			when Phase = 'FIN'
				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
			when Phase = 'WTF'
				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
			else FeedToGain
		end
		

--------------------------------------------------------------------------
-- HEAD CAPACITY
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET HeadCapacity = master.HeadCapacity
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(HeadCapacity) HeadCapacity FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- VACCINATION COSTS
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET VaccinationCost = master.VaccinationCost
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(VaccinationCost) VaccinationCost FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- FEED COST
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET FeedCost = master.FeedCost
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(FeedCost) FeedCost FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup


----------------------------------------------------------------------------
---- PIG START DATE
---- not needed (jmaas)
----------------------------------------------------------------------------
--UPDATE cft_PIG_GROUP_ROLLUP
--SET PigStartDate = PigStartDate.PigStartDate
--
--FROM
--(SELECT
--'PG'+rtrim(ps.PigGroupID) AS GroupNumber,
--ps.TranDate AS PigStartDate
--FROM [$(SolomonApp)].dbo.vCFPigGroupStart AS ps WITH (NOLOCK)
--) PigStartDate
--JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
--	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(PigStartDate.GroupNumber)
--
----------------------------------------------------------------------------
---- PIG END DATE
---- not needed (jmaas)
----------------------------------------------------------------------------
--UPDATE cft_PIG_GROUP_ROLLUP
--SET PigEndDate = PigEndDate.PigEndDate
--
--FROM
--(SELECT
--'PG'+rtrim(pe.PigGroupID) AS GroupNumber,
--pe.TranDate AS PigEndDate
--FROM [$(SolomonApp)].dbo.vCFPigGroupEnd AS pe WITH (NOLOCK)
--) PigEndDate
--JOIN  dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP
--	ON RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) = RTRIM(PigEndDate.GroupNumber)
--
--------------------------------------------------------------------------
-- Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET HeadSold = master.HeadSold
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(HeadSold) HeadSold FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Average Market Weight
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	AverageMarket_Wt = 
		CASE WHEN HeadSold = 0
			THEN 0
			ELSE (Prim_Wt + Cull_Wt + DeadPigsToPacker_Wt + TransferToTailender_Wt + TransferOut_Wt) / HeadSold
		END
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

----------------------------------------------------------------------------
---- Days in Group
---- not needed covered by Avg EmptyDays (jmaas)
----------------------------------------------------------------------------
--UPDATE cft_PIG_GROUP_ROLLUP
--SET	DaysInGroup = DateDiff(d,PigStartDate, PigEndDate)
--FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--
--------------------------------------------------------------------------
-- Pig Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET PigCapacityDays = master.PigCapacityDays
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(PigCapacityDays) PigCapacityDays FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Empty Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET EmptyDays = master.EmptyDays
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(EmptyDays) EmptyDays FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Empty Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET EmptyCapacityDays = master.EmptyCapacityDays
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(EmptyCapacityDays) EmptyCapacityDays FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET CapacityDays = master.CapacityDays
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(CapacityDays) CapacityDays FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Total Capacity Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET TotalCapacityDays = master.TotalCapacityDays
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, SUM(TotalCapacityDays) TotalCapacityDays FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup

--------------------------------------------------------------------------
-- Average Days In Group
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	AverageDaysInGroup = 
	CASE WHEN HeadCapacity = 0
		THEN 0
		ELSE PigCapacityDays / HeadCapacity
	END
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Average Empty Days
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	AverageEmptyDays = 
	CASE WHEN HeadCapacity = 0
		THEN 0
		ELSE EmptyCapacityDays / HeadCapacity
	END
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Utilization
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	Utilization = 
	CASE WHEN TotalCapacityDays = 0
		THEN 0
		ELSE CAST(CAST(TotalPigDays AS NUMERIC(14,2)) / CAST(TotalCapacityDays AS NUMERIC(14,2)) * 100 AS NUMERIC(14,2))
	END
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Medication Cost Per Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	MedicationCostPerHeadSold = 
	ISNULL(CASE WHEN HeadSold = 0
		THEN 0
		ELSE MedicationCost / HeadSold
	END,0)
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Vaccination Cost Per Head Sold
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	VaccinationCostPerHeadSold = 
	ISNULL(CASE WHEN HeadSold = 0
		THEN 0
		ELSE VaccinationCost / HeadSold
	END,0)
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)

--------------------------------------------------------------------------
-- Feed Cost Per Hundred Pounds Gained
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET 	FeedCostPerHundredGain = 
	ISNULL(CASE WHEN WeightGained = 0
		THEN 0
		ELSE FeedCost / WeightGained * 100
	END,0)
FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)





--------------------------------------------------------------------------
-- MASTER GROUP SITE CONTACT ID'S
--------------------------------------------------------------------------
UPDATE cft_PIG_MASTER_GROUP_ROLLUP
SET SiteContactID = cft_PIG_GROUP_ROLLUP.SiteContactID
FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
LEFT JOIN cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
	ON cft_PIG_GROUP_ROLLUP.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup
	AND RIGHT(RTRIM(cft_PIG_GROUP_ROLLUP.TaskID),5) = RIGHT(RTRIM(cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup),5)

--------------------------------------------------------------------------
-- MASTER ACT DATES DATE
--------------------------------------------------------------------------
UPDATE cft_PIG_GROUP_ROLLUP
SET MasterActCloseDate = master.MasterActCloseDate
FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, MAX(ActCloseDate) MasterActCloseDate FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_GROUP_ROLLUP.MasterGroup

UPDATE cft_PIG_GROUP_ROLLUP
SET MasterActStartDate = master.MasterActStartDate
FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
JOIN (SELECT MasterGroup, MIN(ActStartDate) MasterActStartDate FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK) GROUP BY MasterGroup) master
	ON master.MasterGroup = cft_PIG_GROUP_ROLLUP.MasterGroup


--------------------------------------------------------------------------
-- MASTER SRSVCMGR AND SVCMGR
--------------------------------------------------------------------------
UPDATE	cft_PIG_GROUP_ROLLUP
SET	MasterSvcManager = MasterMgrs.SvcManager
,	MasterSrSvcManager = MasterMgrs.SrSvcManager
FROM cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (NOLOCK)
JOIN
	(SELECT	DISTINCT
		cft_PIG_GROUP_ROLLUP.MasterGroup,
		cft_PIG_GROUP_ROLLUP.SvcManager,
		cft_PIG_GROUP_ROLLUP.SrSvcManager
	FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP (nolock)
	LEFT JOIN	(SELECT	MasterGroup, 
			MIN(ActCloseDate) MinActCloseDate
	FROM dbo.cft_PIG_GROUP_ROLLUP (nolock)
	GROUP BY MasterGroup, SiteContactID) x
		on x.MasterGroup = cft_PIG_GROUP_ROLLUP.MasterGroup
		and x.MinActCloseDate = cft_PIG_GROUP_ROLLUP.ActCloseDate) MasterMgrs
	ON MasterMgrs.MasterGroup = cft_PIG_GROUP_ROLLUP.MasterGroup

UPDATE	cft_PIG_MASTER_GROUP_ROLLUP
SET	SvcManager = masters.MasterSvcManager
,	SrSvcManager = masters.MasterSrSvcManager
FROM	dbo.cft_PIG_MASTER_GROUP_ROLLUP cft_PIG_MASTER_GROUP_ROLLUP (nolock)
JOIN	(SELECT DISTINCT MasterGroup, MasterSvcManager, MasterSrSvcManager FROM dbo.cft_PIG_GROUP_ROLLUP (nolock)) masters
	on masters.MasterGroup = cft_PIG_MASTER_GROUP_ROLLUP.MasterGroup


END



