 /****** Object:  Stored Procedure dbo.APDoc_0305    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_0305_InterCpny @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 10) as
--Retrieve the APDocs that have a company ID matching @parm2
--and where the APDoc.CpnyID company has an intercompany relationship with the company with company ID equal to @parm1
Select * from APDoc left outer join Vendor on APDoc.VendId = Vendor.VendId
where
APDoc.CpnyID in (Select ToCompany from vs_intercompany where FromCompany = @parm1 and Module = 'ZZ')
and APDoc.DocType  in ('AC', 'AD', 'PP','VO')
and APDoc.Status in ('A', 'H')
and APDoc.CpnyID like @parm2
and APDoc.RefNbr  like  @parm3
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected = 0
and Vendor.Status <> 'H'
Order by APDoc.Status, APDoc.RefNbr, APDoc.DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_0305_InterCpny] TO [MSDSL]
    AS [dbo];

