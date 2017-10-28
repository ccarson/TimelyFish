-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/16/2008
-- Description:	Updates a record in cfp_AUGER_UPDATE
-- ============================================================
CREATE PROCEDURE dbo.cfp_AUGER_UPDATE
(
		@AugerID					int
		,@Size						varchar(25)
		,@Active					bit
		,@UpdatedBy					varchar(50)
)
AS
BEGIN


IF @Active = 0 BEGIN

  DECLARE @IsActive bit

  SELECT @IsActive = Active
  FROM dbo.cft_AUGER 
  WHERE [AugerID] = @AugerID

  IF @IsActive = 1 AND EXISTS(SELECT 1 
                              FROM dbo.cft_CORN_PRODUCER_FARM CPF 
                              INNER JOIN dbo.cft_STORAGE S ON S.ContactID = CPF.ContactID   
                              WHERE CPF.Active = 1 AND S.AugerID = @AugerID AND S.Active = 1) 
  BEGIN

    RAISERROR('An auger can NOT be marked inactive if it exists in an active Corn Producer Farm record',16,1)
    RETURN

  END 

END

UPDATE dbo.cft_AUGER
   SET [Size] = @Size
		,[Active] = @Active
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[AugerID] = @AugerID



END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_AUGER_UPDATE] TO [db_sp_exec]
    AS [dbo];

