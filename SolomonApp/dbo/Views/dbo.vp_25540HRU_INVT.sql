 




CREATE VIEW vp_25540HRU_INVT AS 


Select Inventory.COGSAcct, Inventory.COGSSub, Inventory.InvtAcct, Inventory.InvtSub, ItemHist.FiscYr,
	PTDCOGSSUM00 = (itemhist.begbal) + (itemhist.PtdCostRcvd00) - (itemhist.PtdCostIssd00) + (itemhist.PtdCostAdjd00) - (itemhist.PTDCOGS00),
		

	PTDCOGSSUM01 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01) - (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01) - (itemhist.PTDCOGS00 + itemhist.PTDCOGS01),
		

	PTDCOGSSUM02 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02) 
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02) 
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02) 
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02),
		
	
	PTDCOGSSUM03 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03) 
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03),
		
	
	PTDCOGSSUM04 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04) 
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04),
		
	
	PTDCOGSSUM05 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 + itemhist.PtdCostRcvd05)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 + itemhist.PtdCostIssd05)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 + itemhist.PtdCostAdjd05)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 + itemhist.PTDCOGS05),
		
	PTDCOGSSUM06 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06) 
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06) 
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06),
		
	PTDCOGSSUM07 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07),
		
	PTDCOGSSUM08 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07 + itemhist.PtdCostRcvd08)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07 + itemhist.PtdCostIssd08)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07 + itemhist.PtdCostAdjd08)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08),
		
	PTDCOGSSUM09 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07 + itemhist.PtdCostRcvd08 + itemhist.PtdCostRcvd09)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07 + itemhist.PtdCostIssd08 + itemhist.PtdCostIssd09)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07 + itemhist.PtdCostAdjd08 + itemhist.PtdCostAdjd09)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09),
		
	PTDCOGSSUM10 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07 + itemhist.PtdCostRcvd08 + itemhist.PtdCostRcvd09 + itemhist.PtdCostRcvd10)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07 + itemhist.PtdCostIssd08 + itemhist.PtdCostIssd09 + itemhist.PtdCostIssd10)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07 + itemhist.PtdCostAdjd08 + itemhist.PtdCostAdjd09 + itemhist.PtdCostAdjd10)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10),
		
	PTDCOGSSUM11 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07 + itemhist.PtdCostRcvd08 + itemhist.PtdCostRcvd09 + itemhist.PtdCostRcvd10 + itemhist.PtdCostRcvd11)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07 + itemhist.PtdCostIssd08 + itemhist.PtdCostIssd09 + itemhist.PtdCostIssd10 + itemhist.PtdCostIssd11)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07 + itemhist.PtdCostAdjd08 + itemhist.PtdCostAdjd09 + itemhist.PtdCostAdjd10 + itemhist.PtdCostAdjd11)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10 + itemhist.PTDCOGS11),
		
	PTDCOGSSUM12 = (itemhist.begbal) + (itemhist.PtdCostRcvd00 + itemhist.PtdCostRcvd01 + itemhist.PtdCostRcvd02 + itemhist.PtdCostRcvd03 + itemhist.PtdCostRcvd04 
				+ itemhist.PtdCostRcvd05 + itemhist.PtdCostRcvd06 + itemhist.PtdCostRcvd07 + itemhist.PtdCostRcvd08 + itemhist.PtdCostRcvd09 + itemhist.PtdCostRcvd10 + itemhist.PtdCostRcvd11 + itemhist.PtdCostRcvd12)
				- (itemhist.PtdCostIssd00 + itemhist.PtdCostIssd01 + itemhist.PtdCostIssd02 + itemhist.PtdCostIssd03 + itemhist.PtdCostIssd04 
				+ itemhist.PtdCostIssd05 + itemhist.PtdCostIssd06 + itemhist.PtdCostIssd07 + itemhist.PtdCostIssd08 + itemhist.PtdCostIssd09 + itemhist.PtdCostIssd10 + itemhist.PtdCostIssd11 + itemhist.PtdCostIssd12)
				+ (itemhist.PtdCostAdjd00 + itemhist.PtdCostAdjd01 + itemhist.PtdCostAdjd02 + itemhist.PtdCostAdjd03 + itemhist.PtdCostAdjd04 
				+ itemhist.PtdCostAdjd05 + itemhist.PtdCostAdjd06 + itemhist.PtdCostAdjd07 + itemhist.PtdCostAdjd08 + itemhist.PtdCostAdjd09 + itemhist.PtdCostAdjd10 + itemhist.PtdCostAdjd11 + itemhist.PtdCostAdjd12)
				- (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10 + itemhist.PTDCOGS11 + itemhist.PTDCOGS12),


	BMIPTDCOGSSUM00 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00) - (itembmihist.BMIPtdCostIssd00) + (itembmihist.BMIPtdCostAdjd00) - (itembmihist.BMIPTDCOGS00),
		

	BMIPTDCOGSSUM01 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01) - (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01) - (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01),
		

	BMIPTDCOGSSUM02 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02) 
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02) 
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02) 
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02),
		
	
	BMIPTDCOGSSUM03 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03) 
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03),
		
	
	BMIPTDCOGSSUM04 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04) 
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04),
		
	
	BMIPTDCOGSSUM05 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 + itembmihist.BMIPtdCostRcvd05)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 + itembmihist.BMIPtdCostIssd05)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 + itembmihist.BMIPtdCostAdjd05)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 + itembmihist.BMIPTDCOGS05),
		
	BMIPTDCOGSSUM06 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06) 
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06) 
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06),
		
	BMIPTDCOGSSUM07 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07),
		
	BMIPTDCOGSSUM08 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07 + itembmihist.BMIPtdCostRcvd08)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07 + itembmihist.BMIPtdCostIssd08)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07 + itembmihist.BMIPtdCostAdjd08)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08),
		
	BMIPTDCOGSSUM09 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07 + itembmihist.BMIPtdCostRcvd08 + itembmihist.BMIPtdCostRcvd09)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07 + itembmihist.BMIPtdCostIssd08 + itembmihist.BMIPtdCostIssd09)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07 + itembmihist.BMIPtdCostAdjd08 + itembmihist.BMIPtdCostAdjd09)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09),
		
	BMIPTDCOGSSUM10 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07 + itembmihist.BMIPtdCostRcvd08 + itembmihist.BMIPtdCostRcvd09 + itembmihist.BMIPtdCostRcvd10)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07 + itembmihist.BMIPtdCostIssd08 + itembmihist.BMIPtdCostIssd09 + itembmihist.BMIPtdCostIssd10)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07 + itembmihist.BMIPtdCostAdjd08 + itembmihist.BMIPtdCostAdjd09 + itembmihist.BMIPtdCostAdjd10)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10),
		
	BMIPTDCOGSSUM11 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07 + itembmihist.BMIPtdCostRcvd08 + itembmihist.BMIPtdCostRcvd09 + itembmihist.BMIPtdCostRcvd10 + itembmihist.BMIPtdCostRcvd11)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07 + itembmihist.BMIPtdCostIssd08 + itembmihist.BMIPtdCostIssd09 + itembmihist.BMIPtdCostIssd10 + itembmihist.BMIPtdCostIssd11)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07 + itembmihist.BMIPtdCostAdjd08 + itembmihist.BMIPtdCostAdjd09 + itembmihist.BMIPtdCostAdjd10 + itembmihist.BMIPtdCostAdjd11)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10 + itembmihist.BMIPTDCOGS11),
		
	BMIPTDCOGSSUM12 = (itembmihist.BMIbegbal) + (itembmihist.BMIPtdCostRcvd00 + itembmihist.BMIPtdCostRcvd01 + itembmihist.BMIPtdCostRcvd02 + itembmihist.BMIPtdCostRcvd03 + itembmihist.BMIPtdCostRcvd04 
				+ itembmihist.BMIPtdCostRcvd05 + itembmihist.BMIPtdCostRcvd06 + itembmihist.BMIPtdCostRcvd07 + itembmihist.BMIPtdCostRcvd08 + itembmihist.BMIPtdCostRcvd09 + itembmihist.BMIPtdCostRcvd10 + itembmihist.BMIPtdCostRcvd11 + itembmihist.BMIPtdCostRcvd12)
				- (itembmihist.BMIPtdCostIssd00 + itembmihist.BMIPtdCostIssd01 + itembmihist.BMIPtdCostIssd02 + itembmihist.BMIPtdCostIssd03 + itembmihist.BMIPtdCostIssd04 
				+ itembmihist.BMIPtdCostIssd05 + itembmihist.BMIPtdCostIssd06 + itembmihist.BMIPtdCostIssd07 + itembmihist.BMIPtdCostIssd08 + itembmihist.BMIPtdCostIssd09 + itembmihist.BMIPtdCostIssd10 + itembmihist.BMIPtdCostIssd11 + itembmihist.BMIPtdCostIssd12)
				+ (itembmihist.BMIPtdCostAdjd00 + itembmihist.BMIPtdCostAdjd01 + itembmihist.BMIPtdCostAdjd02 + itembmihist.BMIPtdCostAdjd03 + itembmihist.BMIPtdCostAdjd04 
				+ itembmihist.BMIPtdCostAdjd05 + itembmihist.BMIPtdCostAdjd06 + itembmihist.BMIPtdCostAdjd07 + itembmihist.BMIPtdCostAdjd08 + itembmihist.BMIPtdCostAdjd09 + itembmihist.BMIPtdCostAdjd10 + itembmihist.BMIPtdCostAdjd11 + itembmihist.BMIPtdCostAdjd12)
				- (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10 + itembmihist.BMIPTDCOGS11 + itembmihist.BMIPTDCOGS12)


FROM Inventory, ItemHist, ItemBMIHist
WHERE ItemHist.InvtId = Inventory.InvtID
AND ItemBMIHist.InvtID = Inventory.InvtID
and ItemBMIHist.FiscYr = ItemHist.FiscYr
and ItemBMIHist.SiteID = ItemHist.SiteID


 
