 CREATE PROC [dbo].[comp_whereused] @part_name VARCHAR (30),@Status varchar (1),@SiteId varchar (10),
	                 @ParentCount int = 0 , /* Defaults only the first time  */
                         @LevelCount int = -1 , /* Default only the first time   */
                         @OutCount int = 0 OutPut
                         AS
Set NoCount ON
/* This is a recursive proc.  When ChildCount = RntCount that level of recursive call did not find any records.
   No more children to this part(Component).  For Example:   The component you entered is Rs302if and it returned
   two records with KitId's(Kit01 and Kit02).  Each Kit is a component within another kit(s).
   Parent (Component - Kit01)  User1 = 0000000000 and User2 = 0000000010
       Child  (KitA)    User1 = 0000000010 and User2 = 0000000020
       Child  (KitB)    User1 = 0000000010 and User2 = 0000000030
   Parent (Component - Kit02)  User1 = 0000000030 and User2 = 0000000040
       Child  (KitC)    User1 = 0000000040 and User2 = 0000000050
*/
Declare C1 Cursor Static Local for
     select KitID,Status,Siteid,KitSiteId, KitStatus, LineNbr
       FROM Component
      WHERE CmpnentID = @part_name
            and Siteid like @SiteID
            and status like @status
            Order by cmpnentid, status,kitid


Declare @KitID VarChar(30)
Declare @Site varchar (10)
Declare @ThisProc Varchar(25)
Declare @kitsiteid Varchar (10)
Declare @kitstatus Varchar (1)
Declare @LineNbr int
Declare @ChildCount int
Declare @isParent int
Declare @RtnCount int
Select @LevelCount = @LevelCount + 1
Select  @ChildCount = @ParentCount
set @thisproc = 'Comp_WhereUsed'
IF @LevelCount = 0 /* Number of recursions */
BEGIN
     Create Table #TempExploder (IsParent int, tLineID int, tUser1 Char(30),
                                 tUser2 Char(30), tCmpnentID char(30),
                                 tKitID Char(30),tKitSiteID char(10), tKitStatus Char(1),
                                 tLineNbr int, tLevelCount int)
END

OPEN C1
FETCH C1 into @KitID,@Status,@Site,@KitSiteId, @KitStatus, @LineNbr
While @@Fetch_status = 0
BEGIN
   	Select @ChildCount = @ChildCount + 10
   	Exec @thisproc @KitID, @kitStatus, @Site, @ChildCount,@LevelCount,@RtnCount OutPut
	IF @childCount = @rtnCount
	BEGIN
            Insert into #TempExploder
	        Values (0, @ChildCount,
		       Convert(Char(30),Right('00000000000000000000' + convert(varchar(30),@ParentCount),20)),
		       Convert(Char(30),Right('00000000000000000000' + convert(varchar(30),@ChildCount),20)),
	               @part_name,
	               @KitID,
	               @KitSiteId,
	               @KitStatus,
	               @LineNbr,
                       @LevelCount)
	END
	Else
	BEGIN
            Insert into #TempExploder
	        Values (1, @ChildCount,
		       Convert(Char(30),Right('00000000000000000000' + convert(varchar(30),@ParentCount),20)),
		       Convert(Char(30),Right('00000000000000000000' + convert(varchar(30),@ChildCount),20)),
	               @part_name,
	               @KitID,
	               @KitSiteId,
	               @KitStatus,
	               @LineNbr,
                       @LevelCount)
	END
	Set @ChildCount=@RtnCount

	FETCH C1 into @KitID,@Status,@Site,@KitSiteId, @KitStatus, @LineNbr
END

Close C1
Deallocate C1
If @LevelCount = 0
Begin
	/*select CmpnentID, KitId, KitSiteId, KitStatus, LineNbr from #tempExploder join component on
							component.CmpnentID = tCmpnentID
							AND KitId = tKitID
	                      AND KitSiteId = #tempExploder.tKitSiteId
	                      AND KitStatus = tKitStatus
	                      AND LineNbr = tLineNbr*/
	Select  BomUsage, CmpnentId, CmpnentQty, CpnyID, Crtd_DateTime,
		     Crtd_Prog, Crtd_User, Deviation, EngrChgOrder, ExplodeFlg,
		     KitId, KitSiteId, KitStatus,
	             LineID = tLineID,
	             LineNbr,
		     LineRef, LUpd_DateTime, LUpd_Prog, LUpd_User, NoteID,
		     RtgStep, S4Future01, S4Future02, S4Future03, S4Future04,
		     S4Future05, S4Future06, S4Future07, S4Future08, S4Future09 = isparent,
		     S4Future10, S4Future11, S4Future12, ScrapPct, Sequence,
		     SiteId, StartDate, Status, StdQty, StockUsage,
		     StopDate, SubKitStatus, SupersededBy, Supersedes,
	             User1 = tUser1,
		     User2 = tUser2,
	             User3, User4, User5, User6,
		     User7, User8, UTEFlag, WONbr,tstamp,tlevelcount
	 From #tempExploder Join component
                               on CmpnentID = tCmpnentID
             	              AND KitId = tKitID
	                      AND KitSiteId = tKitSiteId
	                      AND KitStatus = tKitStatus
	                      AND LineNbr = tLineNbr
         Order by tLineID


End
set @OutCount = @childCount



GO
GRANT CONTROL
    ON OBJECT::[dbo].[comp_whereused] TO [MSDSL]
    AS [dbo];

