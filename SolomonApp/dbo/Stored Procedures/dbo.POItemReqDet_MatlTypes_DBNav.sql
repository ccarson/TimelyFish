 /****** Object:  Stored Procedure dbo.POItemReqDet_MatlTypes_DBNav    Script Date: 12/17/97 10:48:25 AM ******/
Create Procedure POItemReqDet_MatlTypes_DBNav @parm1 Varchar(10) as
Select POItemReqDet.*, POItemReqHdr.*, Vendor.Name from POItemReqDet, POItemReqHdr, Vendor where
POItemReqDet.Status = 'AP' And
POItemReqDet.Reqnbr = '' and
POItemReqDet.materialtype = @Parm1 and
POItemReqDet.ItemReqNbr = POItemReqHdr.ItemReqNbr and
POItemReqDet.prefvendor = Vendor.VendID  and
(POItemReqHdr.Status = 'RQ'  OR POItemReqHdr.Status = 'AP')
ORDER BY POItemReqDet.ItemReqNbr, POItemReqDet.LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POItemReqDet_MatlTypes_DBNav] TO [MSDSL]
    AS [dbo];

