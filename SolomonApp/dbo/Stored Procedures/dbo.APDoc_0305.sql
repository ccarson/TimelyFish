 /****** Object:  Stored Procedure dbo.APDoc_0305    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_0305 @parm1 varchar ( 255), @parm2 varchar ( 10), @parm3 varchar ( 10) as
Select * from APDoc left outer join Vendor on APDoc.VendId = Vendor.VendId
where
APDoc.DocType  in ('AC', 'AD', 'PP','VO')
and APDoc.Status in ('A', @parm1)
and APDoc.CpnyID like @parm2
and APDoc.RefNbr  like  @Parm3
and APDoc.OpenDoc  =  1
and APDoc.Rlsed    =  1
and APDoc.Selected = 0
and COALESCE(Vendor.Status,'A') <> 'H'
Order by APDoc.Opendoc, APDoc.Rlsed, APDoc.Selected, APdoc.Status, APdoc.RefNbr, APDoc.DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_0305] TO [MSDSL]
    AS [dbo];

