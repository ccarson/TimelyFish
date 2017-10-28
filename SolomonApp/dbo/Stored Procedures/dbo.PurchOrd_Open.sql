 /****** Object:  Stored Procedure dbo.PurchOrd_Open    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc PurchOrd_Open as
Select * from PurOrdDet, PurchOrd, Vendor, Terms
where purorddet.openline =  1
and purorddet.ponbr = purchord.ponbr
and purchord.vendid = vendor.vendid
and purchord.terms = terms.termsid
Order by purorddet.ponbr, promdate


