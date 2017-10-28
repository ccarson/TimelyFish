Create proc QtyConsumedLot @LotSerNbr varchar (25) as
Select Sum(ISNull(L.Quantity,0)) from InprojAllocLot  L (nolock) 
            Inner Join InprojAlloctran I (nolock) ON
                  L.Invtid = I.Invtid AND
                  L.SiteId = I.SiteId AND
                  L.ProjectID = I.ProjectID AND
                  L.TaskID = I.TaskID AND
                  L.WhseLoc = I.WhseLoc AND
                  L.CpnyID = I.CpnyID AND
                  I.UnallocSrcNbr <> ""
             Where L.LotSerNbr = @LotSerNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[QtyConsumedLot] TO [MSDSL]
    AS [dbo];

