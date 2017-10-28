 /****** Object:  Stored Procedure dbo.APDoc_Terms_Vendor_Class    Script Date: 4/7/98 12:19:54 PM ******/
/***** Modified 11/4/98 - CSS Removed join to Terms and Vendor.  Needed for 03.510 processing *****/
Create Procedure APDoc_Terms_Vendor_Class @parm1 smalldatetime as
--- Select apdoc.*, Terms.TermsID, Terms.DiscType, Terms.DiscIntrv, Terms.DueType, Terms.DueIntrv, Terms.DiscPct, Vendor.VendID, Vendor.PayDateDflt, Vendor.APAcct, Vendor.APSub from APDoc, Terms, Vendor Where
Select apdoc.*  from APDoc Where
APDoc.DocClass = 'R' and
APDoc.DocDate <= @parm1 and
APDoc.CuryOrigDocAmt = APDoc.CuryDocBal
--- and APDoc.Terms *= Terms.TermsId    and
--- APDoc.VendId *= Vendor.VendId
order by APDoc.CuryID, APDoc.DocClass, APDoc.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Terms_Vendor_Class] TO [MSDSL]
    AS [dbo];

