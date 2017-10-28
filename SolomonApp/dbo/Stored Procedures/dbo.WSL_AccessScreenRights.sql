
CREATE procedure WSL_AccessScreenRights
  
  @page  int
 ,@size  int
 ,@sort   nvarchar(200),
@CpnyID varchar(10), 
@UserID varchar(47),  
@ScreenID varchar(7),
@WinUser varchar(85) as 

if (@UserID = '') Begin  set @UserID = (SELECT userID FROM vs_USERREC WHERE RecType = 'U' AND [WindowsUserAcct] = @WinUser AND defaultuser = 1) end

select CompanyId, max(ViewRights) as [View], max(UpdateRights) as [Update], max(InsertRights) as [Insert], max(DeleteRights) as [Delete], max(InitRights) as Initialization
from  
( 	
	--RecType='U', CompanyID<>"[ALL]":
	select b.CompanyID, b.InitRights, b.ViewRights, b.UpdateRights, b.InsertRights, b.DeleteRights
	from vs_accessdetrights b
	where b.RecType='U' and b.ScreenNumber=@ScreenID and b.UserID=@UserID and b.CompanyID<>'[ALL]' 
		and b.InitRights+b.ViewRights+b.UpdateRights+b.InsertRights+b.DeleteRights > 0 
	
	union all

	--RecType='U', CompanyID="[ALL]":
	select a.CpnyID, b.InitRights, b.ViewRights, b.UpdateRights, b.InsertRights, b.DeleteRights
	from vs_company a, vs_accessdetrights b
	where b.RecType='U' and b.ScreenNumber=@ScreenID and b.UserID=@UserID and b.CompanyID='[ALL]' 
		and b.InitRights+b.ViewRights+b.UpdateRights+b.InsertRights+b.DeleteRights > 0	

	union all

	--RecType='G', CompanyID<>"[ALL]":
	select b.CompanyID, b.InitRights, b.ViewRights, b.UpdateRights, b.InsertRights, b.DeleteRights
	from vs_accessdetrights b
	where b.RecType='G' and b.ScreenNumber=@ScreenID and 
		b.UserID in ( select GroupID from vs_usergrp where UserID=@UserID) 
		and b.CompanyID<>'[ALL]' 
		and b.InitRights+b.ViewRights+b.UpdateRights+b.InsertRights+b.DeleteRights > 0	

	union all

	--RecType='G', CompanyID="[ALL]":
	select a.CpnyID, b.InitRights, b.ViewRights, b.UpdateRights, b.InsertRights, b.DeleteRights
	from vs_company a, vs_accessdetrights b
	where b.RecType='G' and b.ScreenNumber=@ScreenID and 
		b.UserID in ( select GroupID from vs_usergrp where UserID=@UserID) 
		and b.CompanyID='[ALL]' 
		and b.InitRights+b.ViewRights+b.UpdateRights+b.InsertRights+b.DeleteRights > 0	

	union all

	select @CpnyID, 1, 1, 1, 1, 1 from vs_usergrp where  GroupID = 'ADMINISTRATORS' and UserID = @UserID 

) vt where CompanyID = @CpnyID
group by CompanyId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WSL_AccessScreenRights] TO [MSDSL]
    AS [dbo];

