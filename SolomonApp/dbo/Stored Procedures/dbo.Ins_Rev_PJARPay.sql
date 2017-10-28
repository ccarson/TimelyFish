 Create Procedure Ins_Rev_PJARPay @parmuser varchar (21), @parmCustid varchar (15), @parmPADocType varchar (2),
@parmPARefnbr varchar (10) as

insert PJARPay (applied_amt, check_refnbr, crtd_datetime, crtd_prog, crtd_user, CustId, discount_amt,
doctype, invoice_refnbr, invoice_type, lupd_datetime, lupd_prog, lupd_user, pjt_entity, Project, status)

select -v.adjamt, v.adjgrefnbr, GETDATE(), "08240", @parmuser, v.custid, -v.AdjDiscAmt, v.AdjgDocType,
        v.AdjdRefNbr, v.AdjdDocType, GETDATE(), "08240", @parmuser, "", "", "1"

from vp_08400GetReversedAdjs v, ardoc i

where v.custid = @parmCustid and v.adjgdoctype = @parmPADocType and v.adjgrefnbr = @parmPARefnbr and
i.custid = v.custid and i.doctype = v.adjddoctype and i.refnbr = v.adjdrefnbr and i.status = "1"



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ins_Rev_PJARPay] TO [MSDSL]
    AS [dbo];

