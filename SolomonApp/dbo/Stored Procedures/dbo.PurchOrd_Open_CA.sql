 /****** Object:  Stored Procedure dbo.PurchOrd_Open_CA    Script Date: 4/7/98 12:49:20 PM ******/
Create Proc PurchOrd_Open_CA as
Select purorddet.ponbr, purorddet.PromDate, PurchOrd.CuryPOAmt, PurchOrd.POAmt, PurchOrd.Terms, Vendor.PayDateDflt, Terms.DiscIntrv, Terms.disctype, Terms.DueIntrv, Terms.duetype
from PurOrdDet, PurchOrd, Vendor, Terms
where purorddet.openline =  1
and purorddet.ponbr = purchord.ponbr
and purchord.vendid = vendor.vendid
and purchord.terms = terms.termsid
Order by purorddet.ponbr, purorddet.promdate


