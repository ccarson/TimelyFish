
CREATE PROCEDURE WS_PJQUEUEMSP_INSERT 
	@PjqueueMsp_PK INT,          @CpnyID        NVARCHAR(10),     @Crtd_DateTime SMALLDATETIME, @Crtd_Prog     NVARCHAR(8),
    @Crtd_User     NVARCHAR(47), @JobUID        UNIQUEIDENTIFIER, @LUpd_DateTime SMALLDATETIME, @LUpd_Prog     CHAR(8),
    @Lupd_User     NVARCHAR(47), @KeyUID        UNIQUEIDENTIFIER, @SLKeyValue    NVARCHAR(16),  @Status        CHAR(1),
    @Type          NVARCHAR(10), @Message       NVARCHAR(max)
AS
  BEGIN
      INSERT INTO [PJQUEUEMSP]
		([PjqueueMsp_PK], [CpnyID], [Crtd_DateTime], [Crtd_Prog],
         [Crtd_User],     [JobUID], [LUpd_DateTime], [LUpd_Prog],
         [Lupd_User],     [KeyUID], [SLKeyValue],    [Status],
         [Type],          [Message])
      VALUES      
		(@PjqueueMsp_PK, @CpnyID, @Crtd_DateTime, @Crtd_Prog,
         @Crtd_User,     @JobUID, @LUpd_DateTime, @LUpd_Prog,
         @Lupd_User,     @KeyUID, @SLKeyValue,    @Status,
         @Type,          @Message);
  END 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_PJQUEUEMSP_INSERT] TO [MSDSL]
    AS [dbo];

