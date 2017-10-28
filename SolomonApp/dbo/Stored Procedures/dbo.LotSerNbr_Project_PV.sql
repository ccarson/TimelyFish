CREATE Proc LotSerNbr_Project_PV @parm1 varchar ( 30), @parm2 varchar (10), @parm3 varchar (10), @parm4 varchar (16), @parm5 varchar (32), @parm6 varchar (25) as
    Select * from LotSerMst l Inner Join InvProjAllocLot i ON
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
                        AND i.QtyRemaintoIssue > 0 
                    order by ISNull(i.LotSerNbr,''), l.LotSerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[LotSerNbr_Project_PV] TO [MSDSL]
    AS [dbo];

