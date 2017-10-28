 

CREATE VIEW vr_10630 As
            
	Select	DISTINCT ItemSite.ABCCode, Inventory.ClassId, ItemSite.COGSAcct, ItemSite.COGSSub, Inventory.Descr, 
		ItemSite.InvtAcct, ItemSite.InvtID, ItemSite.InvtSub, Inventory.InvtType, Inventory.Kit,
		Inventory.LotSerTrack, Inventory.SerAssign, Inventory.Source, Inventory.Status, Inventory.StkItem, 
		InventoryADG.WeightUOM, InventoryADG.Volume, InventoryADG.Weight, Inventory.TaxCat, Inventory.User1, 
		Inventory.User2, Inventory.User3, Inventory.User4, Inventory.ValMthd, RptRunTime.RI_ID,
		Site.Name SiteName, Site.CpnyID, Intran.Lineref,
		BMIBegBal = Case When ItemBMIHist.InvtID IS Null
                                 Or SubString(LTRIM(RptRunTime.BegPerNbr),1,4) <> ItemBMIHist.FiscYr              
                                 Or Inventory.ValMthd = 'U'
                                    Then 0
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '01'	
                                    Then ItemBMIHist.BMIBegBal	
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '02'	
                 	            Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00
                                                      + ItemBMIHist.BMIPTDCostAdjd00
                                  	              - ItemBMIHist.BMIPTDCostIssd00
                                                      + ItemBMIHist.BMIPTDCostRcvd00
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '03'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01
                        	                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '04'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '05'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '06'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04
                                          + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '07'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '08'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '09'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06 - ItemBMIHist.BMIPTDCOGS07
                                   + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06 + ItemBMIHist.BMIPTDCostAdjd07
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06 - ItemBMIHist.BMIPTDCostIssd07
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06 + ItemBMIHist.BMIPTDCostRcvd07
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '10'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06 - ItemBMIHist.BMIPTDCOGS07
                                                      - ItemBMIHist.BMIPTDCOGS08
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06 + ItemBMIHist.BMIPTDCostAdjd07
                                                      + ItemBMIHist.BMIPTDCostAdjd08
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06 - ItemBMIHist.BMIPTDCostIssd07
                                                      - ItemBMIHist.BMIPTDCostIssd08
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06 + ItemBMIHist.BMIPTDCostRcvd07
                                                      + ItemBMIHist.BMIPTDCostRcvd08
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '11'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06 - ItemBMIHist.BMIPTDCOGS07
                                                      - ItemBMIHist.BMIPTDCOGS08 - ItemBMIHist.BMIPTDCOGS09
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06 + ItemBMIHist.BMIPTDCostAdjd07
                                                      + ItemBMIHist.BMIPTDCostAdjd08 + ItemBMIHist.BMIPTDCostAdjd09
                                               - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06 - ItemBMIHist.BMIPTDCostIssd07
                                                      - ItemBMIHist.BMIPTDCostIssd08 - ItemBMIHist.BMIPTDCostIssd09
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06 + ItemBMIHist.BMIPTDCostRcvd07
                                                      + ItemBMIHist.BMIPTDCostRcvd08 + ItemBMIHist.BMIPTDCostRcvd09
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '12'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06 - ItemBMIHist.BMIPTDCOGS07
                                                      - ItemBMIHist.BMIPTDCOGS08 - ItemBMIHist.BMIPTDCOGS09 - ItemBMIHist.BMIPTDCOGS10
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06 + ItemBMIHist.BMIPTDCostAdjd07
                                                      + ItemBMIHist.BMIPTDCostAdjd08 + ItemBMIHist.BMIPTDCostAdjd09 + ItemBMIHist.BMIPTDCostAdjd10
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06 - ItemBMIHist.BMIPTDCostIssd07
                                                      - ItemBMIHist.BMIPTDCostIssd08 - ItemBMIHist.BMIPTDCostIssd09 - ItemBMIHist.BMIPTDCostIssd10
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06 + ItemBMIHist.BMIPTDCostRcvd07
                                                      + ItemBMIHist.BMIPTDCostRcvd08 + ItemBMIHist.BMIPTDCostRcvd09 + ItemBMIHist.BMIPTDCostRcvd10
                               When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '13'	                                                     
                                    Then ItemBMIHist.BMIBegBal - ItemBMIHist.BMIPTDCOGS00 - ItemBMIHist.BMIPTDCOGS01 - ItemBMIHist.BMIPTDCOGS02 - ItemBMIHist.BMIPTDCOGS03
                                                      - ItemBMIHist.BMIPTDCOGS04 - ItemBMIHist.BMIPTDCOGS05 - ItemBMIHist.BMIPTDCOGS06 - ItemBMIHist.BMIPTDCOGS07
                                                      - ItemBMIHist.BMIPTDCOGS08 - ItemBMIHist.BMIPTDCOGS09 - ItemBMIHist.BMIPTDCOGS10 - ItemBMIHist.BMIPTDCOGS11
                                                      + ItemBMIHist.BMIPTDCostAdjd00 + ItemBMIHist.BMIPTDCostAdjd01 + ItemBMIHist.BMIPTDCostAdjd02 + ItemBMIHist.BMIPTDCostAdjd03
                                                      + ItemBMIHist.BMIPTDCostAdjd04 + ItemBMIHist.BMIPTDCostAdjd05 + ItemBMIHist.BMIPTDCostAdjd06 + ItemBMIHist.BMIPTDCostAdjd07
                                                      + ItemBMIHist.BMIPTDCostAdjd08 + ItemBMIHist.BMIPTDCostAdjd09 + ItemBMIHist.BMIPTDCostAdjd10 + ItemBMIHist.BMIPTDCostAdjd11
                                                      - ItemBMIHist.BMIPTDCostIssd00 - ItemBMIHist.BMIPTDCostIssd01 - ItemBMIHist.BMIPTDCostIssd02 - ItemBMIHist.BMIPTDCostIssd03
                                                      - ItemBMIHist.BMIPTDCostIssd04 - ItemBMIHist.BMIPTDCostIssd05 - ItemBMIHist.BMIPTDCostIssd06 - ItemBMIHist.BMIPTDCostIssd07
                                                      - ItemBMIHist.BMIPTDCostIssd08 - ItemBMIHist.BMIPTDCostIssd09 - ItemBMIHist.BMIPTDCostIssd10 - ItemBMIHist.BMIPTDCostIssd11
                                                      + ItemBMIHist.BMIPTDCostRcvd00 + ItemBMIHist.BMIPTDCostRcvd01 + ItemBMIHist.BMIPTDCostRcvd02 + ItemBMIHist.BMIPTDCostRcvd03
                                                      + ItemBMIHist.BMIPTDCostRcvd04 + ItemBMIHist.BMIPTDCostRcvd05 + ItemBMIHist.BMIPTDCostRcvd06 + ItemBMIHist.BMIPTDCostRcvd07
                                                      + ItemBMIHist.BMIPTDCostRcvd08 + ItemBMIHist.BMIPTDCostRcvd09 + ItemBMIHist.BMIPTDCostRcvd10 + ItemBMIHist.BMIPTDCostRcvd11
			End,  
              BegBal = Case When ItemHist.InvtID IS Null
                              Or SubString(LTRIM(RptRunTime.BegPerNbr),1,4) <> ItemHist.FiscYr              
                              Or Inventory.ValMthd = 'U'
                                 Then 0
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '01'	                                 
                                 Then ItemHist.BegBal	
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '02'
                	         Then ItemHist.BegBal - ItemHist.PTDCOGS00
	       				       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00
						      Else
							   0 END
                         	               + ItemHist.PTDCostAdjd00
                                  	       - ItemHist.PTDCostIssd00
                                               + ItemHist.PTDCostRcvd00
                                               + ItemHist.PTDCostTrsfrIn00
                                               - ItemHist.PTDCostTrsfrOut00
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '03'                                               
        		         Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01
						      Else
							   0 END
                        	               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01
                                	       - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '04'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '05'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '06'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '07'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '08'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '09'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06 - ItemHist.PTDCOGS07
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06 + ItemHist.PTDDShpSls07
						      Else
							   0 END
                              + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06 + ItemHist.PTDCostAdjd07
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06 - ItemHist.PTDCostIssd07
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06 + ItemHist.PTDCostRcvd07
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06 + ItemHist.PTDCostTrsfrIn07
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06 - ItemHist.PTDCostTrsfrOut07
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '10'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06 - ItemHist.PTDCOGS07
                                               - ItemHist.PTDCOGS08
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06 + ItemHist.PTDDShpSls07
									 + ItemHist.PTDDShpSls08
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06 + ItemHist.PTDCostAdjd07
                                               + ItemHist.PTDCostAdjd08
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06 - ItemHist.PTDCostIssd07
                                               - ItemHist.PTDCostIssd08
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06 + ItemHist.PTDCostRcvd07
                                               + ItemHist.PTDCostRcvd08
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06 + ItemHist.PTDCostTrsfrIn07
                                               + ItemHist.PTDCostTrsfrIn08
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06 - ItemHist.PTDCostTrsfrOut07
                                               - ItemHist.PTDCostTrsfrOut08
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '11'                                               
                                 Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                               - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06 - ItemHist.PTDCOGS07
                                               - ItemHist.PTDCOGS08 - ItemHist.PTDCOGS09
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06 + ItemHist.PTDDShpSls07
									 + ItemHist.PTDDShpSls08 + ItemHist.PTDDShpSls09
						      Else
							   0 END
                                               + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                               + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06 + ItemHist.PTDCostAdjd07
                                               + ItemHist.PTDCostAdjd08 + ItemHist.PTDCostAdjd09
                                               - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                               - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06 - ItemHist.PTDCostIssd07
                                               - ItemHist.PTDCostIssd08 - ItemHist.PTDCostIssd09
                                               + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                               + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06 + ItemHist.PTDCostRcvd07
                                               + ItemHist.PTDCostRcvd08 + ItemHist.PTDCostRcvd09
                                               + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                               + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06 + ItemHist.PTDCostTrsfrIn07
                                               + ItemHist.PTDCostTrsfrIn08 + ItemHist.PTDCostTrsfrIn09
                                               - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                               - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06 - ItemHist.PTDCostTrsfrOut07
                                               - ItemHist.PTDCostTrsfrOut08 - ItemHist.PTDCostTrsfrOut09
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '12'
                                  Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                                - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06 - ItemHist.PTDCOGS07
                                                - ItemHist.PTDCOGS08 - ItemHist.PTDCOGS09 - ItemHist.PTDCOGS10
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06 + ItemHist.PTDDShpSls07
									 + ItemHist.PTDDShpSls08 + ItemHist.PTDDShpSls09 + ItemHist.PTDDShpSls10
						      Else
							   0 END
                                                + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                                + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06 + ItemHist.PTDCostAdjd07
                                                + ItemHist.PTDCostAdjd08 + ItemHist.PTDCostAdjd09 + ItemHist.PTDCostAdjd10
                                                - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                                - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06 - ItemHist.PTDCostIssd07
                                                - ItemHist.PTDCostIssd08 - ItemHist.PTDCostIssd09 - ItemHist.PTDCostIssd10
                                                + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                                + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06 + ItemHist.PTDCostRcvd07
                                                + ItemHist.PTDCostRcvd08 + ItemHist.PTDCostRcvd09 + ItemHist.PTDCostRcvd10
                                                + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                                + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06 + ItemHist.PTDCostTrsfrIn07
                                                + ItemHist.PTDCostTrsfrIn08 + ItemHist.PTDCostTrsfrIn09 + ItemHist.PTDCostTrsfrIn10
                                                - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                                - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06 - ItemHist.PTDCostTrsfrOut07
                                                - ItemHist.PTDCostTrsfrOut08 - ItemHist.PTDCostTrsfrOut09 - ItemHist.PTDCostTrsfrOut10
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '13'                                                
                                  Then ItemHist.BegBal - ItemHist.PTDCOGS00 - ItemHist.PTDCOGS01 - ItemHist.PTDCOGS02 - ItemHist.PTDCOGS03
                                                - ItemHist.PTDCOGS04 - ItemHist.PTDCOGS05 - ItemHist.PTDCOGS06 - ItemHist.PTDCOGS07
                                                - ItemHist.PTDCOGS08 - ItemHist.PTDCOGS09 - ItemHist.PTDCOGS10 - ItemHist.PTDCOGS11
					       + Case When RptRunTime.ShortAnswer00 = 'TRUE'
						           Then ItemHist.PTDDShpSls00 + ItemHist.PTDDShpSls01 + ItemHist.PTDDShpSls02 + ItemHist.PTDDShpSls03
									 + ItemHist.PTDDShpSls04 + ItemHist.PTDDShpSls05 + ItemHist.PTDDShpSls06 + ItemHist.PTDDShpSls07
									 + ItemHist.PTDDShpSls08 + ItemHist.PTDDShpSls09 + ItemHist.PTDDShpSls10 + ItemHist.PTDDShpSls11
						      Else
							   0 END
                                                + ItemHist.PTDCostAdjd00 + ItemHist.PTDCostAdjd01 + ItemHist.PTDCostAdjd02 + ItemHist.PTDCostAdjd03
                                                + ItemHist.PTDCostAdjd04 + ItemHist.PTDCostAdjd05 + ItemHist.PTDCostAdjd06 + ItemHist.PTDCostAdjd07
                                                + ItemHist.PTDCostAdjd08 + ItemHist.PTDCostAdjd09 + ItemHist.PTDCostAdjd10 + ItemHist.PTDCostAdjd11
                                                - ItemHist.PTDCostIssd00 - ItemHist.PTDCostIssd01 - ItemHist.PTDCostIssd02 - ItemHist.PTDCostIssd03
                                                - ItemHist.PTDCostIssd04 - ItemHist.PTDCostIssd05 - ItemHist.PTDCostIssd06 - ItemHist.PTDCostIssd07
                                                - ItemHist.PTDCostIssd08 - ItemHist.PTDCostIssd09 - ItemHist.PTDCostIssd10 - ItemHist.PTDCostIssd11
                                                + ItemHist.PTDCostRcvd00 + ItemHist.PTDCostRcvd01 + ItemHist.PTDCostRcvd02 + ItemHist.PTDCostRcvd03
                                                + ItemHist.PTDCostRcvd04 + ItemHist.PTDCostRcvd05 + ItemHist.PTDCostRcvd06 + ItemHist.PTDCostRcvd07
                                                + ItemHist.PTDCostRcvd08 + ItemHist.PTDCostRcvd09 + ItemHist.PTDCostRcvd10 + ItemHist.PTDCostRcvd11
                                                + ItemHist.PTDCostTrsfrIn00 + ItemHist.PTDCostTrsfrIn01 + ItemHist.PTDCostTrsfrIn02 + ItemHist.PTDCostTrsfrIn03
                                                + ItemHist.PTDCostTrsfrIn04 + ItemHist.PTDCostTrsfrIn05 + ItemHist.PTDCostTrsfrIn06 + ItemHist.PTDCostTrsfrIn07
                                                + ItemHist.PTDCostTrsfrIn08 + ItemHist.PTDCostTrsfrIn09 + ItemHist.PTDCostTrsfrIn10 + ItemHist.PTDCostTrsfrIn11
                                                - ItemHist.PTDCostTrsfrOut00 - ItemHist.PTDCostTrsfrOut01 - ItemHist.PTDCostTrsfrOut02 - ItemHist.PTDCostTrsfrOut03
                                                - ItemHist.PTDCostTrsfrOut04 - ItemHist.PTDCostTrsfrOut05 - ItemHist.PTDCostTrsfrOut06 - ItemHist.PTDCostTrsfrOut07
                                                - ItemHist.PTDCostTrsfrOut08 - ItemHist.PTDCostTrsfrOut09 - ItemHist.PTDCostTrsfrOut10 - ItemHist.PTDCostTrsfrOut11
                       End + Case 	When RptRunTime.ShortAnswer00 = 'TRUE' Then (Select COALESCE(SUM(YTDDShpSls),0) 
					From ItemHist ItemHistTotal
					Where ItemHistTotal.InvtID = ItemHist.InvtID
					And ItemHistTotal.SiteID =  ItemHist.SiteID 
					And  ItemHistTotal.FiscYr < ItemHist.FiscYr)
					Else 0 End,  
              BegQty = Case When Item2Hist.InvtID IS Null
                              Or Left(LTRIM(RptRunTime.BegPerNbr), 4) <> Item2Hist.FiscYr              
                                 Then 0
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '01'                                 
                                 Then Item2Hist.BegQty
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '02'
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00
						  	Else
							    0 END
                                                + Item2Hist.PTDQtyAdjd00
                                                - Item2Hist.PTDQtyIssd00
                                                + Item2Hist.PTDQtyRcvd00
                                                + Item2Hist.PTDQtyTrsfrIn00
                                                - Item2Hist.PTDQtyTrsfrOut00
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '03'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01
						  	Else
							    0 END
                                                + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01
                                                - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01
                                                + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01
                                                + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01
                                                - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '04'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02
						  	Else
							    0 END
                                                + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02
                                                - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02
                                                + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02
                                                + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02
                                                - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '05'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						  	Else
							    0 END
                                                + Item2Hist.PTDQtyAdjd00 + Item2Hist.PTDQtyAdjd01 + Item2Hist.PTDQtyAdjd02 + Item2Hist.PTDQtyAdjd03
                                                - Item2Hist.PTDQtyIssd00 - Item2Hist.PTDQtyIssd01 - Item2Hist.PTDQtyIssd02 - Item2Hist.PTDQtyIssd03
                                                + Item2Hist.PTDQtyRcvd00 + Item2Hist.PTDQtyRcvd01 + Item2Hist.PTDQtyRcvd02 + Item2Hist.PTDQtyRcvd03
                                                + Item2Hist.PTDQtyTrsfrIn00 + Item2Hist.PTDQtyTrsfrIn01 + Item2Hist.PTDQtyTrsfrIn02 + Item2Hist.PTDQtyTrsfrIn03
                                                - Item2Hist.PTDQtyTrsfrOut00 - Item2Hist.PTDQtyTrsfrOut01 - Item2Hist.PTDQtyTrsfrOut02 - Item2Hist.PTDQtyTrsfrOut03
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '06'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '07'      
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '08'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06
						  	Else
							    0 END
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
                          When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '09'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06 + Item2Hist.PTDQtyDShpSls07
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '10'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                                - Item2Hist.PTDQtySls08
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06 + Item2Hist.PTDQtyDShpSls07
						                           + Item2Hist.PTDQtyDShpSls08
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '11'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                                - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06 + Item2Hist.PTDQtyDShpSls07
						                           + Item2Hist.PTDQtyDShpSls08 + Item2Hist.PTDQtyDShpSls09
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '12'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                                - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06 + Item2Hist.PTDQtyDShpSls07
						                           + Item2Hist.PTDQtyDShpSls08 + Item2Hist.PTDQtyDShpSls09 + Item2Hist.PTDQtyDShpSls10
						  	Else
							    0 END
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
                            When RIGHT(RTRIM(RptRunTime.BegPerNbr),2) = '13'                                               
                                 Then Item2Hist.BegQty - Item2Hist.PTDQtySls00 - Item2Hist.PTDQtySls01 - Item2Hist.PTDQtySls02 - Item2Hist.PTDQtySls03
                                                - Item2Hist.PTDQtySls04 - Item2Hist.PTDQtySls05 - Item2Hist.PTDQtySls06 - Item2Hist.PTDQtySls07
                                                - Item2Hist.PTDQtySls08 - Item2Hist.PTDQtySls09 - Item2Hist.PTDQtySls10 - Item2Hist.PTDQtySls11
						+ Case When RptRunTime.ShortAnswer00 = 'TRUE'
						            Then Item2Hist.PTDQtyDShpSls00 + Item2Hist.PTDQtyDShpSls01 + Item2Hist.PTDQtyDShpSls02 + Item2Hist.PTDQtyDShpSls03
						                           + Item2Hist.PTDQtyDShpSls04 + Item2Hist.PTDQtyDShpSls05 + Item2Hist.PTDQtyDShpSls06 + Item2Hist.PTDQtyDShpSls07
						                           + Item2Hist.PTDQtyDShpSls08 + Item2Hist.PTDQtyDShpSls09 + Item2Hist.PTDQtyDShpSls10 + Item2Hist.PTDQtyDShpSls11
						  	Else
							    0 END
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
                       End + 	Case 	When RptRunTime.ShortAnswer00 = 'TRUE' Then (Select COALESCE(SUM(YTDQtyDShpSls),0) 
					From Item2Hist Item2HistTotal
					Where Item2HistTotal.InvtID = Item2Hist.InvtID
					And Item2HistTotal.SiteID =  Item2Hist.SiteID 
					And  Item2HistTotal.FiscYr < Item2Hist.FiscYr)
					Else 0 End,
		FiscYr = 	Case 	When ItemHist.FiscYr Is Null
						Then Left(RptRunTime.BegPerNbr, 4)
					Else ItemHist.FiscYr
				End, 
		SiteID =	Case 	When ItemHist.SiteID Is Null
                                 		Then Case when INTran.SiteID is Null then Site.SiteID Else INTran.SiteID End
                                 	Else ItemHist.SiteID
                       		End, 
		PerPost = 	Case 	When INTran.PerPost Is Null
						Then RptRunTime.BegPerNbr
					Else INTran.PerPost
				End, 
		INTran.Acct, INTran.BMITranAmt, INTran.BMIUnitPrice, INTran.CnvFact, 
		INTran.CostType, INTran.DrCr, INTran.ExtCost INTran_ExtCost, INTran.InvtMult,  INTran.LineID, INTran.Qty INTran_Qty, 
		INTran.RcptNbr, INTran.BatNbr, INTran.RefNbr, INTran.Rlsed, INTran.S4Future04, 
		INTran.SpecificCostId, INTran.Sub, INTran.TranAmt, INTran.TranDate, INTran.TranDesc,
		INTran.TranType, INTran.UnitDesc, INTran.UnitPrice, INTran.UnitMultDiv, INTran.WhseLoc,

		-- The following logic is pulled from the SCM_10990_HistoryData stored procedure.
		Qty = 
			Case	When	INTran.TranType In ('AB', 'AC', 'AJ', 'PI')
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0
							End
				When	INTran.TranType = 'CM' And INTran.S4Future09 = 1 And INTran.Jrnltype = 'OM' And Inventory.StkItem = 1 AND ISNULL(SOShipHeader.DropShip,0) = 0 /*  Scrap  */
						Then	0
				When	INTran.TranType In ('II', 'RI') Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0
							End

				When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0
							End
				When	INTran.TranType In ('CM', 'IN')	or (INTran.TranType = 'DM' and INTran.Jrnltype <> 'OM')				
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0							
							End
				When	INTran.TranType = 'TR' And RTrim(INTran.ToSiteID) = ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0
							End
				When	INTran.TranType = 'TR' And RTrim(INTran.ToSiteID) <> ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, D.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, D.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, D.DecPlQty)
								Else	0
							End
					Else	0
			End,


		ExtCost = 
			Case	When	INTran.TranType In ('AB', 'AC', 'AJ', 'PI')
						Then	Round(INTran.TranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'II'
						Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Round(INTran.TranAmt * INTran.InvtMult, D.BaseDecPl)
					When	INTran.TranType = 'RI'
						Then	Round(INTran.ExtCost * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Round(INTran.TranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType In ('CM', 'DM', 'IN') 
						Then	Round(INTran.ExtCost * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) = ''
						Then	Round(INTran.TranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) <> ''
						Then	Round(INTran.TranAmt * INTran.InvtMult, D.BaseDecPl)
					Else	0
			End,
		BMIExtCost = 
			Case	When	INTran.TranType In ('AB', 'AC', 'AJ', 'PI')
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'II'
						Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, D.BaseDecPl)
					When	INTran.TranType = 'RI'
						Then	Round(INTran.BMIExtCost * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType In ('CM', 'DM', 'IN') 
						Then	Round(INTran.BMIExtCost * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) = ''
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, D.BaseDecPl)
				When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) <> ''
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, D.BaseDecPl)
					Else	0
			End

		From 	Inventory Inner Join RptRunTime
			On RptRunTime.RI_ID = (Select Max(RI_ID) from RptRunTime Where ReportNbr = '10630')
			Inner Join InventoryADG
			On Inventory.InvtID = InventoryADG.InvtID
			Inner Join ItemSite
			On Inventory.InvtID = ItemSite.InvtID
			Inner Join Site
			On ItemSite.SiteID = Site.SiteID
			Left Join ItemHist
			On ItemHist.InvtID = ItemSite.InvtID
			And ItemHist.SiteID = ItemSite.SiteID
			And ItemHist.FiscYr = Left(RptRunTime.BegPerNbr, 4)
			Left Join Item2Hist
			On ItemHist.InvtID = Item2Hist.InvtID
			And ItemHist.SiteID = Item2Hist.SiteID
			And ItemHist.FiscYr = Item2Hist.FiscYr
			Left Join ItemBMIHist
			On ItemHist.InvtID = ItemBMIHist.InvtID
			And ItemHist.SiteID = ItemBMIHist.SiteID
			And ItemHist.FiscYr = ItemBMIHist.FiscYr			
			Left Join INTran
			On ItemSite.InvtID = INTran.InvtID
			And ItemSite.SiteID = INTran.SiteID
			And INTran.PerPost between RptRunTime.BegPerNbr and RptRunTime.EndPerNbr
			And INTran.Rlsed = 1
			And INTran.S4Future05 = 0
			And (INTran.S4FUTURE09 = 0 OR (Inventory.StkItem = 0 AND INTran.S4FUTURE09 = INTran.S4FUTURE09)  
			 OR((INTran.TranType = 'IN' 
			 OR (INTran.TranType = 'CM' AND (SELECT SO2.DropShip
			                                   FROM SOShipHeader SO2
			                                  WHERE SO2.CpnyID = INTran.CpnyID
			                                    AND SO2.ShipperID = INTran.ShipperID) = 1)) 
			And INTran.S4FUTURE09 = 1 AND Inventory.StkItem = 1 AND RptRunTime.ShortAnswer00 <> 'TRUE'))
			And INTran.TranType Not In ('CT', 'CG')
			Join vp_DecPl D on 1 = 1
			LEFT JOIN SOShipHeader
			  ON SOShipHeader.CpnyID = INTran.CpnyID
			 AND SOShipHeader.ShipperID = INTran.ShipperID


 
