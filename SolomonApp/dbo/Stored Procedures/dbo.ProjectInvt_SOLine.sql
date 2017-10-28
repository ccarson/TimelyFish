 CREATE PROC ProjectInvt_SOLine
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
    @LineRef    varchar(5)


AS

  SELECT s.InvtID, s.LineRef, s.OrdNbr, s.ProjectID, s.SiteID, s.TaskID, s.AutoPO, s.DropShip, s.Sample, t.Behavior
    FROM SOLine s WITH(NOLOCK) JOIN SOHeader h
                                 ON s.Ordnbr = h.OrdNbr
                                AND s.CpnyID = h.CpnyiD
                               JOIN SOType t WITH(NOLOCK) 
                                 ON h.SOTypeID = t.SOTypeID
                                AND h.CpnyID = t.CpnyID
   WHERE s.CpnyID = @CpnyID
     AND s.OrdNbr = @OrdNbr
     AND s.LineRef = @LineRef

