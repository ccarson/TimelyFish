 /****** Object:  Stored Procedure dbo.APDoc_Terms_Vend_Class_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
/***** Modified 11/4/98 - CSS Removed Join to Vendor and Terms.   Needed for 03.510 processing *****/
Create Procedure APDoc_Terms_Vend_Class_RefNbr @parm1 smalldatetime, @parm2 varchar ( 10) as
--- Select apdoc.*, Terms.TermsID, Terms.DiscType, Terms.DiscIntrv, Terms.DueType, Terms.DueIntrv, Terms.DiscPct, Vendor.VendID, Vendor.PayDateDflt, Vendor.APAcct, Vendor.APSub from APDoc, Terms, Vendor Where
Select apdoc.*   from APDoc Where
APDoc.DocClass = 'R' and
APDoc.DocDate <= @parm1 and
APDoc.RefNbr like @parm2 and
APDoc.CuryOrigDocAmt = APDoc.CuryDocBal
--- an dAPDoc.Terms *= Terms.TermsId    and
--- APDoc.VendId *= Vendor.VendId
order by APDoc.CuryID, APDoc.DocClass, APDoc.RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Terms_Vend_Class_RefNbr] TO [MSDSL]
    AS [dbo];

