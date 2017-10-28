
-- This proc inserts into pjqueue for the Windows service to process.
create procedure PJQueueMSP_Insert 
	@Company			nvarchar(10),
	@Crtd_Prog			varchar(8),
	@Crtd_User			varchar(47),
	@Type				nvarchar(10),
	@Message			nvarchar(max),
	@UserID				nvarchar(47),
	@MSPKeyValue		nvarchar(36),
	@SLKeyValue			nvarchar(16),
	@JobUID				nvarchar(36)
as	
	DECLARE @KeyUID		uniqueidentifier
	--if guid exists in xref, key will be present; otherwise (e.g. on an insert guid will be blank.
	If (@MSPKeyValue = '' or @MSPKeyValue = ' ')
		Begin		
			SELECT @KeyUID = NULL
		end
	Else	
		begin		
			SELECT @KeyUID = Convert(uniqueidentifier, @MSPKeyValue)
		end

	INSERT INTO PJQueueMSP 
		(CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, JobUID,
			Lupd_DateTime, Lupd_Prog, Lupd_User, KeyUID, SLKeyValue, Status, Type, Message)
		VALUES
		(@Company, getdate(), @Crtd_Prog, @Crtd_User, @JobUID,
			getdate(), @Crtd_Prog, @Crtd_User, @KeyUID,	@SLKeyValue, ' ' ,@Type, @Message)
			

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJQueueMSP_Insert] TO [MSDSL]
    AS [dbo];

