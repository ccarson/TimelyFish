 CREATE PROC scm_10990_Status_tables_Balance @InvtID varchar(30), @siteID varchar(10), @AllItems int as

set nocount on

declare @decpl int,
        @decplQty int

SELECT @DecPl = c.DecPl
       FROM GLSetup s (nolock), Currncy c (nolock) WHERE s.BaseCuryID = c.CuryID

Select @decplqty = DecPlQty from insetup (nolock)

Begin tran

delete from #IN10990_ItemSite_Err

if @invtid = '%' and @siteid = '%'
    begin
	insert into #IN10990_ItemSite_Err select s.InvtID, s.SiteID, isnull(max(i.valmthd),''), isnull(max(case when i.serassign = 'R' and i.lotsertrack <> 'NN' then i.lotsertrack else 'NN' end),''),isnull(max(h.fiscYr),''),convert(dec(28,9), round(max(s.TotCost
),@DecPl)),convert(dec(28,9), round(max(s.QtyOnHand),@DecPlQty)),0,0,0,0,0,0, null from
	itemSite s (tablockx)
	inner join Inventory i on s.invtID = i.invtid and i.stkitem = 1
	left join Itemhist h on s.InvtID = h.invtid and s.siteid = h.Siteid
	group by s.InvtID, s.SiteID
    end
else
    begin
    	insert into #IN10990_ItemSite_Err select s.InvtID, s.SiteID, isnull(max(i.valmthd),''), isnull(max(case when i.serassign = 'R' and i.lotsertrack <> 'NN' then i.lotsertrack else 'NN' end),''),isnull(max(h.fiscYr),''),convert(dec(28,9), round(max(s.TotCost),@DecPl)),convert(dec(28,9), round(max(s.QtyOnHand),@DecPlQty)),0,0,0,0,0,0, null from
	itemSite s (tablockx)
	inner join Inventory i on s.invtID = i.invtid and i.stkitem = 1
	left join Itemhist h on s.InvtID = h.invtid and s.siteid = h.Siteid
        where s.Invtid like @invtid and s.Siteid like @siteid
	group by s.InvtID, s.SiteID
    end

--delete from #IN10990_ItemSite_Err where fiscYr = '' and sitebal = 0 and siteqty = 0

Update t set
HistBal = isnull(convert(dec(28,3), round(h.BegBal,@DecPl))
- convert(dec(28,3), round(h.PTDCOGS00,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS01,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS02,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS03,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS04,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS05,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS06,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS07,@DecPl))- convert(dec(28,3), round(h.PTDCOGS08,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS09,@DecPl)) - convert(dec(28,3),
round(h.PTDCOGS10,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS11,@DecPl)) - convert(dec(28,3), round(h.PTDCOGS12,@DecPl))
+ convert(dec(28,3), round(h.PTDCostAdjd00,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd01,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd02,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd03,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd04,@DecPl))+ convert(dec(28,3), round(h.PTDCostAdjd05,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd06,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd07,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd08,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd09,@DecPl))
+ convert(dec(28,3), round(h.PTDCostAdjd10,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd11,@DecPl)) + convert(dec(28,3), round(h.PTDCostAdjd12,@DecPl))
- convert(dec(28,3), round(h.PTDCostIssd00,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd01,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd02,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd03,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd04,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd05,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd06,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd07,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd08,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd09,@DecPl))
- convert(dec(28,3), round(h.PTDCostIssd10,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd11,@DecPl)) - convert(dec(28,3), round(h.PTDCostIssd12,@DecPl))
+ convert(dec(28,3), round(h.PTDCostRcvd00,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd01,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd02,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd03,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd04,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd05,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd06,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd07,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd08,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd09,@DecPl))
+ convert(dec(28,3), round(h.PTDCostRcvd10,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd11,@DecPl)) + convert(dec(28,3), round(h.PTDCostRcvd12,@DecPl))
+ convert(dec(28,3), round(h.PTDCostTrsfrIn00,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn01,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn02,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn03,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn04,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn05,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn06,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn07,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn08,@DecPl)) + convert(dec(28,3),
round(h.PTDCostTrsfrIn09,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn10,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn11,@DecPl)) + convert(dec(28,3), round(h.PTDCostTrsfrIn12,@DecPl))
+ IsNull((Select Sum(convert(dec(28,3), round(PTDDShpSls00,@DecPl)) + convert(dec(28,3), round(PTDDShpSls01,@DecPl)) + convert(dec(28,3), round(PTDDShpSls02,@DecPl)) + convert(dec(28,3), round(PTDDShpSls03,@DecPl)) + convert(dec(28,3), round(PTDDShpSls04,@DecPl)) + convert(dec(28,3), round(PTDDShpSls05,@DecPl)) + convert(dec(28,3), round(PTDDShpSls06,@DecPl)) + convert(dec(28,3), round(PTDDShpSls07,@DecPl)) + convert(dec(28,3), round(PTDDShpSls08,@DecPl)) + convert(dec(28,3), round(PTDDShpSls09,@DecPl))
+ convert(dec(28,3), round(PTDDShpSls10,@DecPl)) + convert(dec(28,3), round(PTDDShpSls11,@DecPl)) + convert(dec(28,3), round(PTDDShpSls12,@DecPl))) From ItemHist Where InvtID = h.invtID and siteid = h.siteid and fiscyr <= h.fiscyr),0)
- convert(dec(28,3), round(h.PTDCostTrsfrOut00,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut01,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut02,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut03,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut04,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut05,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut06,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut07,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut08,@DecPl))
- convert(dec(28,3), round(h.PTDCostTrsfrOut09,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut10,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut11,@DecPl)) - convert(dec(28,3), round(h.PTDCostTrsfrOut12,@DecPl)),0),
HistQty = isnull(convert(dec(28,9), round(h2.BegQty,@DecPlQty))
- convert(dec(28,9), round(h2.PTDQtySls00,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls01,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls02,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls03,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls04,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls05,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls06,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls07,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls08,@DecPlQty)) - convert(dec(28,9),
round(h2.PTDQtySls09,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls10,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls11,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtySls12,@DecPlQty))
+ convert(dec(28,9), round(h2.PTDQtyAdjd00,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd01,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd02,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd03,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd04,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd05,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd06,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd07,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd08,@DecPlQty)) + convert(dec(28,9),
round(h2.PTDQtyAdjd09,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd10,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd11,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyAdjd12,@DecPlQty))
- convert(dec(28,9), round(h2.PTDQtyIssd00,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd01,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd02,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd03,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd04,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd05,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd06,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd07,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd08,@DecPlQty)) - convert(dec(28,9),
round(h2.PTDQtyIssd09,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd10,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd11,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyIssd12,@DecPlQty))
+ convert(dec(28,9), round(h2.PTDQtyRcvd00,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd01,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd02,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd03,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd04,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd05,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd06,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd07,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd08,@DecPlQty)) + convert(dec(28,9),
round(h2.PTDQtyRcvd09,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd10,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd11,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyRcvd12,@DecPlQty))
+ convert(dec(28,9), round(h2.PTDQtyTrsfrIn00,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn01,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn02,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn03,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn04,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn05,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn06,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn07,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn08,@DecPlQty))
+ convert(dec(28,9), round(h2.PTDQtyTrsfrIn09,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn10,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn11,@DecPlQty)) + convert(dec(28,9), round(h2.PTDQtyTrsfrIn12,@DecPlQty))
+ IsNull((Select Sum(convert(dec(28,9), round(PTDQtyDShpSls00,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls01,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls02,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls03,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls04,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls05,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls06,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls07,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls08,@DecPlQty))
+ convert(dec(28,9), round(PTDQtyDShpSls09,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls10,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls11,@DecPlQty)) + convert(dec(28,9), round(PTDQtyDShpSls12,@DecPlQty))) From Item2Hist Where InvtID = h2.invtID and siteid = h2.siteid and fiscyr <= h2.fiscyr),0)
- convert(dec(28,9), round(h2.PTDQtyTrsfrOut00,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut01,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut02,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut03,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut04,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut05,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut06,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut07,@DecPlQty)) - convert(dec(28,9),
round(h2.PTDQtyTrsfrOut08,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut09,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut10,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut11,@DecPlQty)) - convert(dec(28,9), round(h2.PTDQtyTrsfrOut12,@DecPlQty)),0)
from #IN10990_ItemSite_Err t
left join ItemHIst h
on t.InvtID = h.invtID and t.siteid = h.siteid and t.fiscyr = h.fiscyr
left join item2hist h2
on t.InvtID = h2.invtID and t.siteid = h2.siteid and t.fiscyr = h2.fiscyr

Update t set costQty = v.costqty, costBal = v.costbal
from #IN10990_ItemSite_Err t inner join
(Select InvtID, SiteID,
CostBal = Sum(convert(dec(28,3),round(totcost,@DecPl))),
CostQty = Sum(convert(dec(28,9),round(Qty,@DecPlQty)))
from Itemcost group by InvtID, SiteID) v
on t.INvtID = v.InvtID and t.siteid = v.siteid

Update t set locQty = v.locQty
from #IN10990_ItemSite_Err t inner join
(Select InvtID, SiteID,
locQty = Sum(convert(dec(28,9),round(QtyOnHand,@DecPlQty)))
from Location group by InvtID, SiteID) v
on t.INvtID = v.InvtID and t.siteid = v.siteid

Update t set lotQty = v.lotQty
from #IN10990_ItemSite_Err t inner join
(Select InvtID, SiteID,
lotQty = Sum(convert(dec(28,9),round(QtyOnHand,@DecPlQty)))
from Lotsermst group by InvtID, SiteID) v
on t.INvtID = v.InvtID and t.siteid = v.siteid

if @allitems = 0 begin
	delete from #IN10990_ItemSite_Err where
	abs(convert(dec(28,9),round(HistQty,@DecPlQty)) - convert(dec(28,9),round(SiteQty,@DecPlQty))) = 0
	and
        (valmthd in ('U') or (valmthd in ('F','L','S','A','T') and abs(convert(dec(28,3),round(HistBal,@DecPl)) - convert(dec(28,3),round(SiteBal,@DecPl))) = 0))
	And
	abs(convert(dec(28,9),round(SiteQty,@DecPlQty)) - convert(dec(28,9),round(locQty,@DecPlQty))) = 0
	And
	(valmthd in ('U','A','T') or (valmthd in ('F','L','S') and abs(convert(dec(28,3),round(siteBal,@DecPl)) - convert(dec(28,3),round(costBal,@DecPl))) = 0 and abs(convert(dec(28,9),round(siteQty,@DecPlQty)) - convert(dec(28,9),round(costQty,@DecPlQty))) = 0
))
	AND
        (lotsertrack in ('NN') or (lotsertrack in ('LI','SI') and abs(convert(dec(28,9),round(SiteQty,@DecPlQty)) - convert(dec(28,9),round(lotQty,@DecPlQty))) = 0))
end
Commit tran

Select * from #IN10990_ItemSite_Err order by InvtID, SiteID


