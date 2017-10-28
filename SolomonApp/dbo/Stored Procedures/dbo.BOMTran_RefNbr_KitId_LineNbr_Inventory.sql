 Create Proc BOMTran_RefNbr_KitId_LineNbr_Inventory @parm1 varchar ( 15), @KitId varchar(30), @SiteId varchar (10), @parm2beg smallint, @parm2end smallint as
   	Select * from BOMTran, Inventory where
		BOMTran.RefNbr = @parm1 and
		BOMTran.KitId = @KitId and
		BOMTran.SiteId = @SiteId and
		BOMTran.BOMLineNbr between @parm2beg and @parm2end and
		Inventory.InvtId = BOMTran.CmpnentId
		order by BOMTran.RefNbr, BOMTran.BOMLineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BOMTran_RefNbr_KitId_LineNbr_Inventory] TO [MSDSL]
    AS [dbo];

