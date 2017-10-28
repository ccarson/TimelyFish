 create proc ProjInv_GetLotsAllocated 	
    @InvtID Varchar(30),
	@SiteID Varchar(10),
    @ProjectID Varchar(16),
    @TaskID Varchar(32),
    @OrdNbr Varchar (15),
    @OrdLineRef Varchar(5)
as

    SELECT QtyAllocated = Sum(i.QtyAllocated) 
      FROM InPrjAllocationLot i
     WHERE SrcType = 'SO'   
       AND InvtID = @InvtID
       AND SiteID = @SiteID
       AND ProjectID = @ProjectID
       AND TaskID = @TaskID
       AND SrcNbr + SrcLineRef <> @Ordnbr + @OrdLineRef
     GROUP BY InvtID, SiteID, ProjectID, TaskID, WhseLoc


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ProjInv_GetLotsAllocated] TO [MSDSL]
    AS [dbo];

