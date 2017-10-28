
create procedure PJPROJEX_ULastRevNum @Project varchar (16), @RevID varchar (04), @LupdUser varchar (10), @LupdProg varchar (08) as

DECLARE @intRevID INT
    SET @intRevID = CONVERT(INT,@RevID)

if @intRevID >= (select PM_ID20 from PJPROJEX where project = @Project)
	BEGIN
		Update pjprojex Set
			pm_id20 = @intRevID,
			Lupd_DateTime=GETDATE(),
		    lupd_User =@LupdUser,
			lupd_Prog =@LupdProg
		 where project = @Project
	END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEX_ULastRevNum] TO [MSDSL]
    AS [dbo];

