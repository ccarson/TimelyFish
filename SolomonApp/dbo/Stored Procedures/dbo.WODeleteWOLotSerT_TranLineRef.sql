 Create Proc WODeleteWOLotSerT_TranLineRef
   @WONbr           varchar (16),
   @TaskID          varchar (32),
   @TranSDType      varchar (2),
   @TranLineRef     varchar (5),
   @TranType        varchar (5),
   @PJTK_Key        varchar (24)

AS

   SET NOCOUNT ON

   DECLARE          @LotSerNbr                 varchar(25)
   DECLARE          @InvtID                    varchar(30)
   DECLARE          @SiteID                    varchar(10)
   DECLARE          @WhseLoc                   varchar(10)
   DECLARE          @SerAssign                 varchar(1)
   DECLARE          @LSMStatus                 varchar(1)
   DECLARE          @FETCH_WOLotSerT_Status    int

   -- Cycle thru all WOLotSerT's, check what we need to do with LotSerMst
   -- Only delete if Status is 'A'
   DECLARE          WOLotSerT_Cursor CURSOR LOCAL
   FOR
   SELECT           L.LotSerNbr, L.InvtID, L.SiteID, L.WhseLoc,
			L.TranType, I.SerAssign, M.Status
   FROM             WOLotSerT L LEFT JOIN LotSerMst M
                    ON L.InvtID = M.InvtID and
                       L.LotSerNbr = M.LotSerNbr and
                       L.SiteID = M.SiteID and
                       L.WhseLoc = M.WhseLoc
                    LEFT JOIN Inventory I
                    ON L.InvtID = I.InvtID
   WHERE            L.WONbr = @WONbr and
                    L.TaskID = @TaskID and
                    L.TranSDType = @TranSDType and
                    L.TranLineRef = @TranLineRef and
                    L.TranType = @TranType and
                    L.PJTK_Key = @PJTK_Key and
                    L.Status = 'A'
   ORDER BY         L.LotSerNbr
   if (@@error <> 0) GOTO ABORT

   OPEN WOLotSerT_CURSOR
   FETCH NEXT FROM WOLotSerT_CURSOR INTO
       @LotSerNbr, @InvtID, @SiteID, @WhseLoc, @TranType,
       @SerAssign, @LSMStatus
   if (@@error <> 0) GOTO ABORT

   SELECT @FETCH_WOLotSerT_Status = @@Fetch_Status

   -- Cycle thru WOLotSerT records
	WHILE @FETCH_WOLotSerT_Status = 0
   BEGIN

     -- Since L.Status = 'A', then no LotSerT records will have been created yet
     -- Since this is an 'MR' specific delete none of these tran types are here
     -- However, I think the logic should include TranType = II, when SerAssign = U
     -- If (bLotSerT.TranType = 'RC' Or bLotSerT.TranType = 'TR' Or bLotSerT.TranType = 'AJ') And bLotSerMst.Status = 'H' Then
     if @TranType = 'II' and @SerAssign = 'U' and @LSMStatus = 'H'
        DELETE LotSerMst Where InvtID = @InvtID and
                               LotSerNbr = @LotSerNbr and
                               SiteID = @SiteID and
                               WhseLoc = @WhseLoc

     -- Remove the current WOLotSerT record
     DELETE FROM WOLotSerT WHERE CURRENT OF WOLotSerT_CURSOR

     -- Get next WOLotSerT record
     FETCH NEXT FROM WOLotSerT_CURSOR INTO
	       @LotSerNbr, @InvtID, @SiteID, @WhseLoc, @TranType,
	       @SerAssign, @LSMStatus
     SELECT @FETCH_WOLotSerT_Status = @@Fetch_Status

   END

   CLOSE WOLotSerT_CURSOR
   DEALLOCATE WOLotSerT_CURSOR
   GOTO FINISH

ABORT:

FINISH:

-- Copyright 1998, 1999 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WODeleteWOLotSerT_TranLineRef] TO [MSDSL]
    AS [dbo];

