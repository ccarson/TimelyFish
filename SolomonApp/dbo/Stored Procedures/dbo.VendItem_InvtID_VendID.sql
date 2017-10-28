 /****** Object:  Stored Procedure dbo.VendItem_InvtID_VendID    Script Date: 4/16/98 7:50:27 PM ******/
Create Procedure VendItem_InvtID_VendID @InvtID varchar ( 30), @SiteID varchar ( 10), @VendID varchar ( 15), @FiscYr varchar ( 4), @AlternateID Varchar (30) As
        Select * from VendItem where
                InvtID = @InvtID And
		SiteID = @SiteID And
                VendID = @VendID And
        	FiscYr = @FiscYr And
		AlternateID = @AlternateID
        Order By InvtID, SiteID, VendID, FiscYr


