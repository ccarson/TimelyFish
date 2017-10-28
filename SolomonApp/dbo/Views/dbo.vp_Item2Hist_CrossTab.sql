 

Create View vp_Item2Hist_CrossTab As

	-- PERIOD 01
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '01',
		PTDIRCompletes = PTDIRCompletes00, 
		PTDIRHits = PTDIRHits00,
		PTDQtyAdjd = PTDQtyAdjd00,
		PTDQtyDShpSls = PTDQtyDShpSls00,
		PTDQtyIssd = PTDQtyIssd00,
		PTDQtyRcvd = PTDQtyRcvd00,
		PTDQtySls = PTDQtySls00,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn00,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut00
	FROM Item2Hist

	UNION

	-- PERIOD 02
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '02',
		PTDIRCompletes = PTDIRCompletes01, 
		PTDIRHits = PTDIRHits01,
		PTDQtyAdjd = PTDQtyAdjd01,
		PTDQtyDShpSls = PTDQtyDShpSls01,
		PTDQtyIssd = PTDQtyIssd01,
		PTDQtyRcvd = PTDQtyRcvd01,
		PTDQtySls = PTDQtySls01,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn01,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut01
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 03	
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '03',
		PTDIRCompletes = PTDIRCompletes02, 
		PTDIRHits = PTDIRHits02,
		PTDQtyAdjd = PTDQtyAdjd02,
		PTDQtyDShpSls = PTDQtyDShpSls02,
		PTDQtyIssd = PTDQtyIssd02,
		PTDQtyRcvd = PTDQtyRcvd02,
		PTDQtySls = PTDQtySls02,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn02,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut02
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 04	
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '04',
		PTDIRCompletes = PTDIRCompletes03, 
		PTDIRHits = PTDIRHits03,
		PTDQtyAdjd = PTDQtyAdjd03,
		PTDQtyDShpSls = PTDQtyDShpSls03,
		PTDQtyIssd = PTDQtyIssd03,
		PTDQtyRcvd = PTDQtyRcvd03,
		PTDQtySls = PTDQtySls03,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn03,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut03
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 05		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '05',
		PTDIRCompletes = PTDIRCompletes04, 
		PTDIRHits = PTDIRHits04,
		PTDQtyAdjd = PTDQtyAdjd04,
		PTDQtyDShpSls = PTDQtyDShpSls04,
		PTDQtyIssd = PTDQtyIssd04,
		PTDQtyRcvd = PTDQtyRcvd04,
		PTDQtySls = PTDQtySls04,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn04,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut04
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 06		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '06',
		PTDIRCompletes = PTDIRCompletes05, 
		PTDIRHits = PTDIRHits05,
		PTDQtyAdjd = PTDQtyAdjd05,
		PTDQtyDShpSls = PTDQtyDShpSls05,
		PTDQtyIssd = PTDQtyIssd05,
		PTDQtyRcvd = PTDQtyRcvd05,
		PTDQtySls = PTDQtySls05,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn05,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut05
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 07		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '07',
		PTDIRCompletes = PTDIRCompletes06, 
		PTDIRHits = PTDIRHits06,
		PTDQtyAdjd = PTDQtyAdjd06,
		PTDQtyDShpSls = PTDQtyDShpSls06,
		PTDQtyIssd = PTDQtyIssd06,
		PTDQtyRcvd = PTDQtyRcvd06,
		PTDQtySls = PTDQtySls06,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn06,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut06
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 08		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '08',
		PTDIRCompletes = PTDIRCompletes07, 
		PTDIRHits = PTDIRHits07,
		PTDQtyAdjd = PTDQtyAdjd07,
		PTDQtyDShpSls = PTDQtyDShpSls07,
		PTDQtyIssd = PTDQtyIssd07,
		PTDQtyRcvd = PTDQtyRcvd07,
		PTDQtySls = PTDQtySls07,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn07,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut07
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 09		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '09',
		PTDIRCompletes = PTDIRCompletes08, 
		PTDIRHits = PTDIRHits08,
		PTDQtyAdjd = PTDQtyAdjd08,
		PTDQtyDShpSls = PTDQtyDShpSls08,
		PTDQtyIssd = PTDQtyIssd08,
		PTDQtyRcvd = PTDQtyRcvd08,
		PTDQtySls = PTDQtySls08,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn08,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut08
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 10		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '10',
		PTDIRCompletes = PTDIRCompletes09, 
		PTDIRHits = PTDIRHits09,
		PTDQtyAdjd = PTDQtyAdjd09,
		PTDQtyDShpSls = PTDQtyDShpSls09,
		PTDQtyIssd = PTDQtyIssd09,
		PTDQtyRcvd = PTDQtyRcvd09,
		PTDQtySls = PTDQtySls09,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn09,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut09
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 11			
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '11',
		PTDIRCompletes = PTDIRCompletes10, 
		PTDIRHits = PTDIRHits10,
		PTDQtyAdjd = PTDQtyAdjd10,
		PTDQtyDShpSls = PTDQtyDShpSls10,
		PTDQtyIssd = PTDQtyIssd10,
		PTDQtyRcvd = PTDQtyRcvd10,
		PTDQtySls = PTDQtySls10,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn10,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut10
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 12		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '12',
		PTDIRCompletes = PTDIRCompletes11, 
		PTDIRHits = PTDIRHits11,
		PTDQtyAdjd = PTDQtyAdjd11,
		PTDQtyDShpSls = PTDQtyDShpSls11,
		PTDQtyIssd = PTDQtyIssd11,
		PTDQtyRcvd = PTDQtyRcvd11,
		PTDQtySls = PTDQtySls11,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn11,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut11
	FROM Item2Hist
	
	UNION
	
	-- PERIOD 13		
	SELECT 	InvtID, SiteID, FiscYr, Period = RTrim(FiscYr) + '13',
		PTDIRCompletes = PTDIRCompletes12, 
		PTDIRHits = PTDIRHits12,
		PTDQtyAdjd = PTDQtyAdjd12,
		PTDQtyDShpSls = PTDQtyDShpSls12,
		PTDQtyIssd = PTDQtyIssd12,
		PTDQtyRcvd = PTDQtyRcvd12,
		PTDQtySls = PTDQtySls12,
		PTDQtyTrsfrIn = PTDQtyTrsfrIn12,
		PTDQtyTrsfrOut = PTDQtyTrsfrOut12
	FROM Item2Hist
			


 
