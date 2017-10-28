 create proc SCM_ItemHist_BegBalCostRcvd
	@InvtID			varchar(30),
	@SiteID			varchar(10),
	@BeginPeriod 		varchar(6)
	as
	Select	BegBal +
		CASE Right(@BeginPeriod, 2)
	WHEN '01' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00

	WHEN '02' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01

	WHEN '03' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02

	WHEN '04' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03

	WHEN '05' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04

	WHEN '06' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05

	WHEN '07' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06

	WHEN '08' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07

	WHEN '09' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07
			+ PTDCostRcvd08 + PTDCostAdjd08 + PTDCostTrsfrIn08 - PTDCOGS08 - PTDCostIssd08 - PTDCostTrsfrOut08

	WHEN '10' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07
			+ PTDCostRcvd08 + PTDCostAdjd08 + PTDCostTrsfrIn08 - PTDCOGS08 - PTDCostIssd08 - PTDCostTrsfrOut08
			+ PTDCostRcvd09 + PTDCostAdjd09 + PTDCostTrsfrIn09 - PTDCOGS09 - PTDCostIssd09 - PTDCostTrsfrOut09

	WHEN '11' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07
			+ PTDCostRcvd08 + PTDCostAdjd08 + PTDCostTrsfrIn08 - PTDCOGS08 - PTDCostIssd08 - PTDCostTrsfrOut08
			+ PTDCostRcvd09 + PTDCostAdjd09 + PTDCostTrsfrIn09 - PTDCOGS09 - PTDCostIssd09 - PTDCostTrsfrOut09
			+ PTDCostRcvd10 + PTDCostAdjd10 + PTDCostTrsfrIn10 - PTDCOGS10 - PTDCostIssd10 - PTDCostTrsfrOut10

	WHEN '12' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07
			+ PTDCostRcvd08 + PTDCostAdjd08 + PTDCostTrsfrIn08 - PTDCOGS08 - PTDCostIssd08 - PTDCostTrsfrOut08
			+ PTDCostRcvd09 + PTDCostAdjd09 + PTDCostTrsfrIn09 - PTDCOGS09 - PTDCostIssd09 - PTDCostTrsfrOut09
			+ PTDCostRcvd10 + PTDCostAdjd10 + PTDCostTrsfrIn10 - PTDCOGS10 - PTDCostIssd10 - PTDCostTrsfrOut10
			+ PTDCostRcvd11 + PTDCostAdjd11 + PTDCostTrsfrIn11 - PTDCOGS11 - PTDCostIssd11 - PTDCostTrsfrOut11

	WHEN '13' THEN
			  PTDCostRcvd00 + PTDCostAdjd00 + PTDCostTrsfrIn00 - PTDCOGS00 - PTDCostIssd00 - PTDCostTrsfrOut00
			+ PTDCostRcvd01 + PTDCostAdjd01 + PTDCostTrsfrIn01 - PTDCOGS01 - PTDCostIssd01 - PTDCostTrsfrOut01
			+ PTDCostRcvd02 + PTDCostAdjd02 + PTDCostTrsfrIn02 - PTDCOGS02 - PTDCostIssd02 - PTDCostTrsfrOut02
			+ PTDCostRcvd03 + PTDCostAdjd03 + PTDCostTrsfrIn03 - PTDCOGS03 - PTDCostIssd03 - PTDCostTrsfrOut03
			+ PTDCostRcvd04 + PTDCostAdjd04 + PTDCostTrsfrIn04 - PTDCOGS04 - PTDCostIssd04 - PTDCostTrsfrOut04
			+ PTDCostRcvd05 + PTDCostAdjd05 + PTDCostTrsfrIn05 - PTDCOGS05 - PTDCostIssd05 - PTDCostTrsfrOut05
			+ PTDCostRcvd06 + PTDCostAdjd06 + PTDCostTrsfrIn06 - PTDCOGS06 - PTDCostIssd06 - PTDCostTrsfrOut06
			+ PTDCostRcvd07 + PTDCostAdjd07 + PTDCostTrsfrIn07 - PTDCOGS07 - PTDCostIssd07 - PTDCostTrsfrOut07
			+ PTDCostRcvd08 + PTDCostAdjd08 + PTDCostTrsfrIn08 - PTDCOGS08 - PTDCostIssd08 - PTDCostTrsfrOut08
			+ PTDCostRcvd09 + PTDCostAdjd09 + PTDCostTrsfrIn09 - PTDCOGS09 - PTDCostIssd09 - PTDCostTrsfrOut09
			+ PTDCostRcvd10 + PTDCostAdjd10 + PTDCostTrsfrIn10 - PTDCOGS10 - PTDCostIssd10 - PTDCostTrsfrOut10
			+ PTDCostRcvd11 + PTDCostAdjd11 + PTDCostTrsfrIn11 - PTDCOGS11 - PTDCostIssd11 - PTDCostTrsfrOut11
			+ PTDCostRcvd12 + PTDCostAdjd12 + PTDCostTrsfrIn12 - PTDCOGS12 - PTDCostIssd12 - PTDCostTrsfrOut12

		END
	From 	ItemHist
	Where 	InvtID = @InvtID
	  and	SiteID = @SiteID
	  and	FiscYr = Left(@BeginPeriod, 4)


