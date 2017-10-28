Create Proc ADG_GetQtyAvail_Project_TaskID
    @InvtID		Varchar(30),
    @SiteID		Varchar(10),
    @WhseLoc	Varchar(10),
    @ProjectID  VarChar(16),
    @TaskID     VarChar(32),
    @SrcNbr     VarChar(15),
    @CpnyID     VarChar(10)
   
As
Declare @QtyAvail As DEC(25,9),
        @QtyRemainToIssue As DEC(25,9)


EXEC SumqtyRemainToIssuewhse @InvtID, @ProjectID, @TaskID, @SiteID, @WhseLoc, @CpnyID, @QtyRemainToIssue OUTPUT  
SELECT	QtyAvail = CASE WHEN  @SrcNbr <> ''
                                  THEN QtyAvail + @QtyRemaintoIssue
                                  ELSE QtyAvail END
	FROM	Location (NOLOCK)
	WHERE	InvtID = @InvtID AND SiteID = @SiteID AND WhseLoc = @WhseLoc 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_GetQtyAvail_Project_TaskID] TO [MSDSL]
    AS [dbo];

