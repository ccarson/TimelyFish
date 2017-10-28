Create Proc LotSerMst_Project_LifoDate @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (16), @parm5 varchar (32), @parm6 varchar (25) as
    Select l.* from LotSerMst l Inner Join InvProjAllocLot i ON
                  i.InvtId = l.invtid
                  and i.SiteId = l.SiteId
                  and i.WhseLoc = l.WhseLoc
                  and i.lotsernbr like l.LotSerNbr
                  and L.status = 'A'
                  Where i.InvtiD = @parm1
                        AND i.SiteId = @Parm2
                        AND i.WhseLoc = @Parm3
                        AND i.ProjectId = @parm4 
                        AND i.TaskID = @parm5
                        AND i.LotSerNbr Like @Parm6
                        AND l.QtyAllocProjIN - l.PrjInQtyAlloc - l.PrjInQtyAllocIN - l.PrjINQtyAllocSO - l.PrjINQtyAllocPORet - l.PrjINQtyShipNotInv > 0 
                    order by l.Invtid,l.LifoDate desc,l.LotSerNbr desc



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerMst_Project_LifoDate] TO [MSDSL]
    AS [dbo];

