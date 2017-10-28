 Create Proc Kit_Kitid_Site_Inv_Std @parm1 varchar ( 30), @parm2 varchar ( 10) as
        Select * from Kit, Inventory where
        	Kit.KitId like @parm1 and
		Kit.SiteId like @parm2 and
        	Kit.Status = 'A' and
		Inventory.InvtId = Kit.KitId and
		Inventory.ValMthd = 'T'
        Order by Kit.Kitid, Kit.Siteid, Kit.Status


