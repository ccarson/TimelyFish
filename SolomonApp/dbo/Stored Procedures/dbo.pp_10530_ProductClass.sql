 Create Proc pp_10530_ProductClass
            @UserAddress VARCHAR (21),
            @ProgName VARCHAR (8),
            @UserName VARCHAR (10),
            @AllItems VARCHAR (1),
            @Process_Flag VARCHAR(1),
            @ErrorFlag VARCHAR(1) AS

    SET NOCOUNT ON

--  Process Product Class Updates
    IF @AllItems <> '0' -- All Items
        Begin
            Update ProductClass
                 Set CFOvhMatlRate = PFOvhMatlRate,
                     CVOvhMatlRate = PVOvhMatlRate,
                     PFOvhMatlRate = 0,
                     PVOvhMatlRate = 0,
                     LUpd_DateTime = GetDate(),
                     LUpd_Prog = @ProgName,
                     LUpd_User = @UserName
                From ProductClass
               Where PFOvhMatlRate <> 0
                  OR PVOvhMatlRate <> 0
            IF @@ROWCOUNT <> 0 SELECT @Process_Flag = '1'
            IF @@ERROR <> 0 GOTO ABORT
        END
    ELSE     -- Selected Items
        Begin
            Update ProductClass
                 Set CFOvhMatlRate = PFOvhMatlRate,
                     CVOvhMatlRate = PVOvhMatlRate,
                     PFOvhMatlRate = 0,
                     PVOvhMatlRate = 0,
                     LUpd_DateTime = GetDate(),
                     LUpd_Prog = @ProgName,
                     LUpd_User = @UserName
                From ProductClass, IN10530_Wrk
               Where PFOvhMatlRate <> 0
                  OR PVOvhMatlRate <> 0
                 And @UserAddress = IN10530_Wrk.ComputerName
                 And ProductClass.ClassId = IN10530_Wrk.ClassId

            IF @@ROWCOUNT <> 0 SELECT @Process_Flag = '1'
            IF @@ERROR <> 0 GOTO ABORT
        END

    Goto Finish

ABORT:
    SELECT @ErrorFlag = 'Y'

Finish:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10530_ProductClass] TO [MSDSL]
    AS [dbo];

