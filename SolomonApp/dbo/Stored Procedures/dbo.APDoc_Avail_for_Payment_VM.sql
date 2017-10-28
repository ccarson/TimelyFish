 /****** Object:  Stored Procedure dbo.APDoc_Avail_for_Payment_VM    Script Date: 11/18/98 8:29:23 AM ******/
Create Procedure APDoc_Avail_for_Payment_VM @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'as
--Retrieve the APDocs that have a company ID matching @parm2
--and where the APDoc.CpnyID company has an intercompany relationship with the company with company ID equal to @parm1
Select apdoc.*, vendor.vendid, vendor.status, vendor.multichk, vendor.classid  from APDoc, Vendor
where
APDoc.CpnyID in (Select ToCompany from vs_intercompany where FromCompany = @parm1 and Module = 'ZZ')
and APDoc.DocType  in ('AC','AD','PP','VO', 'VM')
and APDoc.Status = 'A'
and APDoc.CpnyID like @parm2
and APDoc.RefNbr  like  @parm3
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected = 0
and APDoc.S4Future11 <> 'VM'
and APDoc.VendId   =  Vendor.VendId
and Vendor.Status <> 'H'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Avail_for_Payment_VM] TO [MSDSL]
    AS [dbo];

