 




CREATE VIEW vp_25540HRU_COGS AS 


Select Inventory.COGSAcct, Inventory.COGSSub, ItemHist.FiscYr, 
	PTDCOGSSUM00 = (itemhist.PTDCOGS00),
		

	PTDCOGSSUM01 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01),
		

	PTDCOGSSUM02 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02),
		
	
	PTDCOGSSUM03 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03),
		
	
	PTDCOGSSUM04 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04),
		
	
	PTDCOGSSUM05 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05),
		
	PTDCOGSSUM06 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06),
		
	PTDCOGSSUM07 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07),
		
	PTDCOGSSUM08 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08),
		
	PTDCOGSSUM09 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09),
		
	PTDCOGSSUM10 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10),
		
	PTDCOGSSUM11 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10 + itemhist.PTDCOGS11),
		
	PTDCOGSSUM12 = (itemhist.PTDCOGS00 + itemhist.PTDCOGS01 + itemhist.PTDCOGS02 + itemhist.PTDCOGS03 + itemhist.PTDCOGS04 
				+ itemhist.PTDCOGS05 + itemhist.PTDCOGS06 + itemhist.PTDCOGS07 + itemhist.PTDCOGS08 + itemhist.PTDCOGS09 + itemhist.PTDCOGS10 + itemhist.PTDCOGS11 + itemhist.PTDCOGS12),

	BMIPTDCOGSSUM00 = (itembmihist.BMIPTDCOGS00),
		

	BMIPTDCOGSSUM01 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01),
		

	BMIPTDCOGSSUM02 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02),
		
	
	BMIPTDCOGSSUM03 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03),
		
	
	BMIPTDCOGSSUM04 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04),
		
	
	BMIPTDCOGSSUM05 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05),
		
	BMIPTDCOGSSUM06 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06),
		
	BMIPTDCOGSSUM07 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07),
		
	BMIPTDCOGSSUM08 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08),
		
	BMIPTDCOGSSUM09 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09),
		
	BMIPTDCOGSSUM10 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10),
		
	BMIPTDCOGSSUM11 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10 + itembmihist.BMIPTDCOGS11),
		
	BMIPTDCOGSSUM12 = (itembmihist.BMIPTDCOGS00 + itembmihist.BMIPTDCOGS01 + itembmihist.BMIPTDCOGS02 + itembmihist.BMIPTDCOGS03 + itembmihist.BMIPTDCOGS04 
				+ itembmihist.BMIPTDCOGS05 + itembmihist.BMIPTDCOGS06 + itembmihist.BMIPTDCOGS07 + itembmihist.BMIPTDCOGS08 + itembmihist.BMIPTDCOGS09 + itembmihist.BMIPTDCOGS10 + itembmihist.BMIPTDCOGS11 + itembmihist.BMIPTDCOGS12)
		

FROM Inventory, ItemHist, ItemBMIHist
WHERE ItemHist.InvtId = Inventory.InvtID
AND ItemBMIHist.InvtID = Inventory.InvtID
and ItemBMIHist.FiscYr = ItemHist.FiscYr
and ItemBMIHist.SiteID = ItemHist.SiteID


 
