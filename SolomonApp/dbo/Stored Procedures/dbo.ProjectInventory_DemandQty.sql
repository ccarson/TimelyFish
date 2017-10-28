 CREATE PROC ProjectInventory_DemandQty
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5)

AS

    SELECT s.OrdNbr, s.ProjectID, s.TaskID, i.QtyAllocated
      FROM INPrjAllocation i JOIN SOLine s 
                               ON i.CpnyID = s.CpnyID
                              AND i.SrcNbr = s.OrdNbr
                              AND i.SrcLineRef = s.LineRef
     WHERE i.SrcNbr = @OrdNbr
       AND i.SrcLineREf = @LineRef
       AND i.CpnyID = @CpnyID
       AND i.SrcType = 'SO'

