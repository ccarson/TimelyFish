
-- =============================================
-- Author:	mdawson
-- Create date: 03/17/2009
-- Description:	Select data for IRR Report.
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_IRR]
	@SiteID char(10),
	@PerPost char(6),
	@PerRollup char(6)
AS
BEGIN
	SET NOCOUNT ON;

create table #irr
(	SiteName char(30)
,	ClassID char(6)
,	InvtID char(30)
,	ItemDesc char(60)
,	BegPhysical numeric(18,2)
,	Receipts numeric(18,2)
,	Adjustments numeric(18,2)
,	SiteID char(10)
,	BegPeriod char(6)
,	EndPeriod char(6)
,	EndPhysical numeric(18,2)
,	RationOrIngred varchar(20)
,	UnitCost numeric(18,2))

insert into #irr
SELECT 
	Site.Name, 
	inv.ClassID, 
	inv.InvtID, 
	inv.descr as ItemDesc, 
--	isnull(cast(beginv.physqty as numeric(18,2)),0) 'BegPhysical', 
      BegPhysical = Case When Item2Hist.InvtID IS Null
                      Or Left(LTRIM(@PerRollup), 4) <> Item2Hist.FiscYr              
                         Then 0
                    When RIGHT(RTRIM(@PerRollup),2) = '01'                                 
                         Then Item2Hist.BegQty
                    When RIGHT(RTRIM(@PerRollup),2) = '02'
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00
                                        + Item2Hist.PTDQtyAdjd00
                                        - Item2Hist.PTDQtyIssd00
                                        + Item2Hist.PTDQtyRcvd00
                                        + Item2Hist.PTDQtyTrsfrIn00
                                        - Item2Hist.PTDQtyTrsfrOut00
                    When RIGHT(RTRIM(@PerRollup),2) = '03'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01
                    When RIGHT(RTRIM(@PerRollup),2) = '04'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02
                    When RIGHT(RTRIM(@PerRollup),2) = '05'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                    When RIGHT(RTRIM(@PerRollup),2) = '06'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04
                    When RIGHT(RTRIM(@PerRollup),2) = '07'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05
                    When RIGHT(RTRIM(@PerRollup),2) = '08'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06
                    When RIGHT(RTRIM(@PerRollup),2) = '09'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                    When RIGHT(RTRIM(@PerRollup),2) = '10'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08
                    When RIGHT(RTRIM(@PerRollup),2) = '11'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09
                    When RIGHT(RTRIM(@PerRollup),2) = '12'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10
                    When RIGHT(RTRIM(@PerRollup),2) = '13'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10 - Item2Hist.PTDQtySls11
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10 + Item2Hist.PTDQtyAdjd11
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10 - Item2Hist.PTDQtyIssd11
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10 + Item2Hist.PTDQtyRcvd11
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10 + Item2Hist.PTDQtyTrsfrIn11
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10 - Item2Hist.PTDQtyTrsfrOut11
               End,

	isnull(cast(ir.Receipts as numeric(18,2)),0) 'Receipts', 
	isnull(cast(ir.Adjustments as numeric(18,2)),0) 'Adjustments', 
	ir.SiteID, 
	@PerPost as BegPeriod, 
	@PerRollup as EndPeriod, 
	isnull(cast(endinv.physqty as numeric(18,2)),0) 'EndPhysical',
	CASE WHEN rtrim(inv.ClassID) = 'ration' THEN 'Ration' ELSE 'Ingredient' END RationOrIngred,
    isnull(cast(ir.UnitCost as numeric(18,4)),0) 'UnitCost'
FROM	dbo.cfv_Inventory_Recon ir (NOLOCK)
JOIN	[$(SolomonApp)].dbo.Inventory inv (NOLOCK)
	ON inv. InvtID = ir.InvtID
JOIN	[$(SolomonApp)].dbo.Site Site (NOLOCK)
	ON ir.SiteID = Site.SiteID
Left Join [$(SolomonApp)].dbo.Item2Hist Item2Hist (NOLOCK)
	On ir.InvtID = Item2Hist.InvtID
	And ir.SiteID = Item2Hist.SiteID
	And Left(LTRIM(@PerRollup), 4) = Item2Hist.FiscYr
LEFT OUTER JOIN	[$(SolomonApp)].dbo.PIDetail beginv (NOLOCK)
	ON beginv.SiteID = ir.SiteID
	AND ir.InvtID = beginv.InvtID
	AND beginv.PerClosed = @PerPost
LEFT OUTER JOIN	[$(SolomonApp)].dbo.PIDetail endinv (NOLOCK)
	ON endinv.SiteID = ir.SiteID
	AND ir.InvtID = endinv.InvtID
	AND endinv.PerClosed = ''
WHERE ir.SiteID = @SiteID
and ir.PerPost = @PerRollup

--items that don't have current inventory transactions, but do have beg/end physical inventory
union all
SELECT 
	Site.Name, 
	inv.ClassID, 
	inv.InvtID, 
	inv.descr as ItemDesc, 
--	isnull(cast(beginv.physqty as numeric(18,2)),0) 'BegPhysical', 
      BegPhysical = Case When Item2Hist.InvtID IS Null
                      Or Left(LTRIM(@PerRollup), 4) <> Item2Hist.FiscYr              
                         Then 0
                    When RIGHT(RTRIM(@PerRollup),2) = '01'                                 
                         Then Item2Hist.BegQty
                    When RIGHT(RTRIM(@PerRollup),2) = '02'
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00
                                        + Item2Hist.PTDQtyAdjd00
                                        - Item2Hist.PTDQtyIssd00
                                        + Item2Hist.PTDQtyRcvd00
                                        + Item2Hist.PTDQtyTrsfrIn00
                                        - Item2Hist.PTDQtyTrsfrOut00
                    When RIGHT(RTRIM(@PerRollup),2) = '03'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01
                    When RIGHT(RTRIM(@PerRollup),2) = '04'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02
                    When RIGHT(RTRIM(@PerRollup),2) = '05'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                    When RIGHT(RTRIM(@PerRollup),2) = '06'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04
                    When RIGHT(RTRIM(@PerRollup),2) = '07'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05
                    When RIGHT(RTRIM(@PerRollup),2) = '08'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06
                    When RIGHT(RTRIM(@PerRollup),2) = '09'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                    When RIGHT(RTRIM(@PerRollup),2) = '10'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08
                    When RIGHT(RTRIM(@PerRollup),2) = '11'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09
                    When RIGHT(RTRIM(@PerRollup),2) = '12'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10
                    When RIGHT(RTRIM(@PerRollup),2) = '13'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10 - Item2Hist.PTDQtySls11
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10 + Item2Hist.PTDQtyAdjd11
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10 - Item2Hist.PTDQtyIssd11
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10 + Item2Hist.PTDQtyRcvd11
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10 + Item2Hist.PTDQtyTrsfrIn11
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10 - Item2Hist.PTDQtyTrsfrOut11
               End,

	0 'Receipts', 
	0 'Adjustments', 
	pd.SiteID, 
	@PerPost as BegPeriod, 
	@PerRollup as EndPeriod, 
	isnull(cast(pd.physqty as numeric(18,2)),0) 'EndPhysical',
	CASE WHEN rtrim(inv.ClassID) = 'ration' THEN 'Ration' ELSE 'Ingredient' END RationOrIngred,
	0 'UnitCost'
FROM	[$(SolomonApp)].dbo.PIDetail pd (NOLOCK)
JOIN	[$(SolomonApp)].dbo.Inventory inv (NOLOCK)
	ON inv. InvtID = pd.InvtID
JOIN	[$(SolomonApp)].dbo.Site Site (NOLOCK)
	ON pd.SiteID = Site.SiteID
Left Join [$(SolomonApp)].dbo.Item2Hist Item2Hist (NOLOCK)
	On pd.InvtID = Item2Hist.InvtID
	And pd.SiteID = Item2Hist.SiteID
	And Left(LTRIM(@PerRollup), 4) = Item2Hist.FiscYr
LEFT OUTER JOIN	[$(SolomonApp)].dbo.PIDetail beginv (NOLOCK)
	ON beginv.SiteID = pd.SiteID
	AND pd.InvtID = beginv.InvtID
	AND beginv.PerClosed = @PerPost
WHERE pd.SiteID = @SiteID
and pd.PerClosed = ''
and not exists (select * from dbo.cfv_Inventory_Recon (NOLOCK) where SiteID = pd.SiteID and InvtID = pd.InvtID and PerPost = @PerRollup)


insert into #irr
SELECT 
	Site.Name, 
	inv.ClassID, 
	inv.InvtID, 
	inv.descr as ItemDesc, 
--	isnull(cast(beginv.physqty as numeric(18,2)),0) 'BegPhysical', 
      BegPhysical = Case When Item2Hist.InvtID IS Null
                      Or Left(LTRIM(@PerRollup), 4) <> Item2Hist.FiscYr              
                         Then 0
                    When RIGHT(RTRIM(@PerRollup),2) = '01'                                 
                         Then Item2Hist.BegQty
                    When RIGHT(RTRIM(@PerRollup),2) = '02'
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00
                                        + Item2Hist.PTDQtyAdjd00
                                        - Item2Hist.PTDQtyIssd00
                                        + Item2Hist.PTDQtyRcvd00
                                        + Item2Hist.PTDQtyTrsfrIn00
                                        - Item2Hist.PTDQtyTrsfrOut00
                    When RIGHT(RTRIM(@PerRollup),2) = '03'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01
                    When RIGHT(RTRIM(@PerRollup),2) = '04'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02
                    When RIGHT(RTRIM(@PerRollup),2) = '05'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                    When RIGHT(RTRIM(@PerRollup),2) = '06'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04
                    When RIGHT(RTRIM(@PerRollup),2) = '07'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05
                    When RIGHT(RTRIM(@PerRollup),2) = '08'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06
                    When RIGHT(RTRIM(@PerRollup),2) = '09'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                    When RIGHT(RTRIM(@PerRollup),2) = '10'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08
                    When RIGHT(RTRIM(@PerRollup),2) = '11'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09
                    When RIGHT(RTRIM(@PerRollup),2) = '12'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10
                    When RIGHT(RTRIM(@PerRollup),2) = '13'                                               
                         Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                        - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                        - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10 - Item2Hist.PTDQtySls11
                                        + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                        + Item2Hist.PTDQtyAdjd04 + Item2Hist.PTDQtyAdjd05 + Item2Hist.PTDQtyAdjd06 + Item2Hist.PTDQtyAdjd07
                                        + Item2Hist.PTDQtyAdjd08 + Item2Hist.PTDQtyAdjd09 + Item2Hist.PTDQtyAdjd10 + Item2Hist.PTDQtyAdjd11
                                        - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                        - Item2Hist.PTDQtyIssd04 - Item2Hist.PTDQtyIssd05 - Item2Hist.PTDQtyIssd06 - Item2Hist.PTDQtyIssd07
                                        - Item2Hist.PTDQtyIssd08 - Item2Hist.PTDQtyIssd09 - Item2Hist.PTDQtyIssd10 - Item2Hist.PTDQtyIssd11
                                        + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                        + Item2Hist.PTDQtyRcvd04 + Item2Hist.PTDQtyRcvd05 + Item2Hist.PTDQtyRcvd06 + Item2Hist.PTDQtyRcvd07
                                        + Item2Hist.PTDQtyRcvd08 + Item2Hist.PTDQtyRcvd09 + Item2Hist.PTDQtyRcvd10 + Item2Hist.PTDQtyRcvd11
                                        + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                        + Item2Hist.PTDQtyTrsfrIn04 + Item2Hist.PTDQtyTrsfrIn05 + Item2Hist.PTDQtyTrsfrIn06 + Item2Hist.PTDQtyTrsfrIn07
                                        + Item2Hist.PTDQtyTrsfrIn08 + Item2Hist.PTDQtyTrsfrIn09 + Item2Hist.PTDQtyTrsfrIn10 + Item2Hist.PTDQtyTrsfrIn11
                                        - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                                        - Item2Hist.PTDQtyTrsfrOut04 - Item2Hist.PTDQtyTrsfrOut05 - Item2Hist.PTDQtyTrsfrOut06 - Item2Hist.PTDQtyTrsfrOut07
                                        - Item2Hist.PTDQtyTrsfrOut08 - Item2Hist.PTDQtyTrsfrOut09 - Item2Hist.PTDQtyTrsfrOut10 - Item2Hist.PTDQtyTrsfrOut11
               End,

	0 'Receipts', 
	0 'Adjustments', 
	pd.SiteID, 
	@PerPost as BegPeriod, 
	@PerRollup as EndPeriod, 
	isnull(cast(pd.physqty as numeric(18,2)),0) 'EndPhysical',
	CASE WHEN rtrim(inv.ClassID) = 'ration' THEN 'Ration' ELSE 'Ingredient' END RationOrIngred,
	0 'UnitCost'
FROM	[$(SolomonApp)].dbo.PIDetail pd (NOLOCK)
JOIN	[$(SolomonApp)].dbo.Inventory inv (NOLOCK)
	ON inv. InvtID = pd.InvtID
JOIN	[$(SolomonApp)].dbo.Site Site (NOLOCK)
	ON pd.SiteID = Site.SiteID
Left Join [$(SolomonApp)].dbo.Item2Hist Item2Hist (NOLOCK)
	On pd.InvtID = Item2Hist.InvtID
	And pd.SiteID = Item2Hist.SiteID
	And Left(LTRIM(@PerRollup), 4) = Item2Hist.FiscYr
LEFT OUTER JOIN	[$(SolomonApp)].dbo.PIDetail beginv (NOLOCK)
	ON beginv.SiteID = pd.SiteID
	AND pd.InvtID = beginv.InvtID
	AND beginv.PerClosed = @PerPost
WHERE pd.SiteID = @SiteID
and pd.PerClosed = @PerPost
and not exists (select * from dbo.cfv_Inventory_Recon (NOLOCK) where SiteID = pd.SiteID and InvtID = pd.InvtID and PerPost = @PerRollup)
and not exists (select * from #irr where siteid = pd.SiteID and invtid = pd.InvtId)


select * from #irr
ORDER BY RationOrIngred, InvtID

drop table #irr

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_IRR] TO [db_sp_exec]
    AS [dbo];

