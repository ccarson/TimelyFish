
 CREATE PROCEDURE pp_APReleasePosting @APBatNbr VARCHAR(10), @UserAddress VARCHAR(21), 
                                   @SolUser Varchar(10), @ReleaseRights INT, @PostingRights INT
AS

SET NOCOUNT ON
SET DEADLOCK_PRIORITY LOW

-- @APBatNbr -- AP Batch Number
-- @UserAddress  -- Last 21 characters of 36 Characters from the WebServiceAccess Guid
-- @SolUser -- First 10 Characters of 47 of the Login User.
-- @ReleaseRights  --Does SLUser have rights to release AP Batchs  (Has to be 2 or higher)
-- @PostingRights  --Does SLUser have posting rights.

  SET NOCOUNT ON
  SET DEADLOCK_PRIORITY LOW

  --BATCH VARIABLES
  DECLARE @PerPost VARCHAR(6)
  DECLARE @EditScrnNbr VARCHAR(5)
  DECLARE @ProgID VARCHAR(8)
  DECLARE @Status VARCHAR(1)
  DECLARE @Batnbr VARCHAR(10)
  DECLARE @Rlsed INT

  --GLSETUP VARIABLES
  DECLARE @AutoPost VARCHAR(1)
  DECLARE @PerNbr VARCHAR(6)
  DECLARE @LastClosePerNbr VARCHAR(6)
  DECLARE @GLSetupID VARCHAR(2)
  DECLARE @BaseCuryID VARCHAR(4)

  --APSETUP VARIABLES
  DECLARE @CurrPerNbr VARCHAR(6)
  DECLARE @APSetupID VARCHAR(2)

  --LOCAL VARIABLES
  DECLARE @Msgid  INT
  DECLARE @MsgType VARCHAR(4)

  SELECT @CurrPerNbr = CurrPerNbr, @APSetupID = ISNULL(SetupId, '')
    FROM APSetup WITH(NOLOCK)

  IF @APSetupID = ''
  BEGIN
      INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
      SELECT @APBatNbr, 'AP', 36, @useraddress
      GOTO FINISH
  END

  IF @ReleaseRights < 2 
  BEGIN
      INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
      SELECT @APBatNbr, 'AP', 6812, @useraddress
      GOTO FINISH
  END    

  SELECT @AutoPost = ISNULL(AutoPost,''), @PerNbr = PerNbr, @LastClosePerNbr = LastClosePerNbr, @GLSetupID = SetupId
    FROM GLSetup WITH(NOLOCK)
   WHERE setupid = 'GL'
  IF @@ERROR <> 0  GOTO FINISH 
 
  SELECT @PerPost = PerPost, @ProgID = LUpd_Prog, @EditScrnNbr = EditScrnNbr, @Status = ISNULL(batch.Status, ''),
         @Batnbr = BatNbr, @Rlsed = Rlsed
    FROM Batch With(NOLOCK)
   WHERE BatNbr = @APBatNbr AND Module = 'AP'
  IF @@ERROR <> 0  GOTO FINISH 
 
  BEGIN TRANSACTION

    IF @Status <> 'I'
    BEGIN

        EXEC pp_CleanWrkRelease @UserAddress, 'AP'
        If @@ERROR <> 0 GOTO ABORT
	
        EXEC pp_CleanWrkRelease_PO @UserAddress
        If @@ERROR <> 0 GOTO ABORT
	
        EXEC pp_WrkReleaseRec @Batnbr, 'AP', @UserAddress, 1
        If @@ERROR <> 0 GOTO ABORT
	
        EXEC pp_WrkRelease_PORec @Batnbr, 'AP', @UserAddress
        If @@ERROR <> 0 GOTO ABORT
	
        /**  AP RELEASE  **/
        EXEC pp_03400 @UserAddress, @SolUser	
        IF @@ERROR <> 0
        BEGIN
            SELECT @Msgid = Msgid
              FROM Wrkreleasebad
             WHERE useraddress = @useraddress AND Module = 'AP'
             SET @MsgType = 'REL'
            GOTO ABORT
        END
 
        --Check for WrkReleaseBad Errors
        IF EXISTS (SELECT * FROM WrkReleaseBad WHERE UserAddress = @UserAddress AND Module = 'AP')
        BEGIN
            SELECT @Msgid = Msgid
              FROM Wrkreleasebad
             WHERE useraddress = @useraddress AND Module = 'AP'
             SET @MsgType = 'REL'
            GOTO ABORT
        END 
  
        /** CONTINUE -- NO WRKRELEASEBAD ERRORS **/
        IF (SELECT COUNT(*) FROM Batch WITH (NOLOCK)
             WHERE BatNbr  = @BatNbr AND Module = 'AP' AND Rlsed = 1) > 0
        BEGIN
  
            IF @AutoPost = 'A' AND @PerPost <= @PerNbr AND @EditScrnNbr <> '03060'
            BEGIN
                /**  Post Transactions 0152000  **/            
                If @PostingRights < 2 
                BEGIN
                    INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
                    SELECT @BatNbr, 'AP', '6660', @UserAddress
                    COMMIT TRANSACTION            
                    GOTO FINISH
                END
                 
                /** GLSETUP has to be setup to Post **/
                /** LastClosePeriod cannot be equal to Current Fiscal Period, otherwise a Closing Process has been initiated **/
                If @GLSetupID <> '' AND  @LastClosePerNbr <> @PerNbr
                BEGIN

                    EXEC pp_CleanWrkPost @UserAddress	
                    If @@ERROR <> 0 GOTO FINISH
		       
    		        EXEC pp_SharePostRec @APBatnbr, 'AP', @UserAddress, 1
	    	        If @@ERROR <> 0 GOTO FINISH
		       
		            EXEC pp_01520 @UserAddress, @SolUser
		            If @@ERROR <> 0
                    BEGIN
                        SET @MsgType = 'POST'
                        SELECT @Msgid = Situation
                          FROM WrkPostBad
                         WHERE useraddress = @useraddress AND Module = 'AP'
		                GOTO FINISH
		            END
		        
    		        --Check for WrkPostBad Errors
                    IF EXISTS (SELECT * FROM WrkReleaseBad WHERE UserAddress = @UserAddress AND Module = 'AP')
                    BEGIN
                        SELECT @Msgid = Msgid
                          FROM Wrkreleasebad
                         WHERE useraddress = @useraddress AND Module = 'AP'
                           SET @MsgType = 'POST'
                        GOTO FINISH
                    END 
                END
                ELSE
                BEGIN
                    --NO GLSETUP Record or @LastClosePerNbr <> @PerNbr
                    If @GLSetupID = ''
                    BEGIN 
                        INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
                        SELECT @BatNbr, 'AP', '36', @UserAddress
                    END
                    ELSE
                    BEGIN
                        INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
                        SELECT @BatNbr, 'AP', '6048', @UserAddress                
                    END
                    GOTO FINISH              
                END
            END --@AutoPost
        END  --Batch Released
    END  --Status <>  'I'
    ELSE
    BEGIN
        If @Rlsed	= 0 
        BEGIN
        --  Only want to void the batch if the batch hasn't been released already.
            UPDATE APDoc SET Status = 'V' 
             WHERE BatNbr = @Batnbr AND Status <> 'V' AND Rlsed = 0
       
            DELETE aptran FROM APTran 
             WHERE BatNbr = @Batnbr AND Rlsed = 0
      
            UPDATE Batch
               SET AutoRev = 0, AutoRevCopy = 0, BatType = '', CrTot = 0, CtrlTot = 0,
                   Cycle = 0, Descr = '', DrTot = 0, EditScrnNbr = '', GLPostOpt = '',
                   JrnlType = '', Module = 'AP', NbrCycle = 0, PerEnt = '',
                   PerPost = @CurrPerNbr, Rlsed = 1, Status = 'V'
             WHERE BatNbr = @BatNbr AND Module = 'AP' AND Rlsed = 0
        END
    END 

  COMMIT TRANSACTION
  
 GOTO FINISH

 ABORT:
  ROLLBACK TRANSACTION

  --IF @MsgType = 'REL'
  --BEGIN
  --    INSERT WrkReleaseBad (batnbr, module, msgid, useraddress)
  --    SELECT @APBatNbr, 'AP', @msgid, @useraddress
  --END
  --IF @MsgType = 'POST'
  --BEGIN
  --    INSERT WrkPostBad (BatNbr, Module, Situation, UserAddress)
  --    SELECT @APBatNbr, 'AP', CAST(@msgid AS VARCHAR(10)), @UserAddress
  --END
    
 FINISH:

DELETE FROM WrkRelease WHERE UserAddress = @UserAddress And Module = 'AP'
DELETE FROM WrkRelease WHERE UserAddress = @UserAddress And Module = 'AP'

DELETE FROM WrkPost WHERE UserAddress = @UserAddress
DELETE FROM WrkPostBad Where UserAddress = @UserAddress

