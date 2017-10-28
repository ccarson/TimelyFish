 create proc WODelete
	@WONbr         	varchar ( 16 ),
	@UserID		varchar ( 10 ),
	@ProgID		varchar ( 8 ),
  	@ErrorCode     	smallint OUTPUT
as
	set nocount on

	DECLARE
	@WOPendingProject	varchar( 16 ),
	@CpnyID			varchar( 10 ),
	@OrdNbr			varchar( 15 ),
	@LineRef		varchar( 5 ),
	@CustID			varchar( 15 ),
	@InvtID			varchar( 30 ),
	@NoteID			int

	SELECT 			@WOPendingProject = WOPendingProject
	FROM			WOSetup (NOLOCK)

   	select   		@ErrorCode = 0

	-- WOHeader
	-- WOBuildTo
	-- WOMatlReq
	-- WORouting
	-- WOEvent
	-- WORequest		n/a - no WO number assigned
	-- WOLotSerT      	is not accessed, as it is only updated in released stage
	-- PJProj
	-- PJProjEx
	-- PJPEnt
	-- PJPEntEx
	-- PJPtdRol
	-- PJPtdSum
	-- PJTranEx			When in Plan mode, no records
	-- PJTran			When in Plan mode, no records
	-- PJProjEM

   -- WOHEADER
	Delete from SNote WHERE SNote.nID =
	(Select NoteID from WOHeader WHERE WONbr = @WONbr)
		Delete from WOHeader WHERE WONbr = @WONbr
	if (@@error = 0)
	 	print 'Delete WOHeader complete'
	else
	 	begin
	 		print 'WOHeader error'
	 		select @ErrorCode = 1
	 		goto FINISH
	 	end

	-- Update the SOLine records for MTO WOBuildTo lines
	-- ProjectID --> WO Pending Project
	-- TaskID    --> blank
	-- BoundToWO --> 0  (BoundToWO)

   DECLARE          WOBuildTo_Cursor CURSOR LOCAL
   FOR
   SELECT           CpnyID, OrdNbr, BuildToLineRef, CustID, InvtID
   FROM             WOBuildTo
   WHERE            WONbr = @WONbr and
                    BuildToType = 'ORD' and
                    QtyRemaining > 0

   if (@@error <> 0) GOTO ABORT

	Open WOBuildTo_Cursor
	Fetch Next From WOBuildTo_Cursor Into @CpnyID, @OrdNbr, @LineRef, @CustID, @InvtID
	While (@@Fetch_Status = 0)
		Begin

			EXEC WOSOLine_Update_Cancel @CpnyID, @OrdNbr, @LineRef, @WOPendingProject, @UserID, @ProgID

			-- WO has added an index to SOSHIPLINE
			UPDATE		SOShipLine
			SET		ProjectID = @WOPendingProject,
					TaskID = ''
			WHERE		CpnyID = @CpnyID and
					OrdNbr = @OrdNbr and
					OrdLineRef = @LineRef

			Fetch Next From WOBuildTo_Cursor Into @CpnyID, @OrdNbr, @LineRef, @CustID, @InvtID
		End
	Close WOBuildTo_Cursor
	Deallocate WOBuildTo_Cursor

  -- WOBUILDTO
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             WOBuildTo
   	WHERE            WONbr = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from WOBuildTo WHERE WONbr = @WONbr
	if (@@error = 0)
	 	print 'Delete WOBuildTo complete'
	 else
	 	begin
	 		print 'WOBuildTo error'
	 		select @ErrorCode = 2
	 		goto FINISH
	 	end

   -- WOMATLREQ
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             WOMatlReq
   	WHERE            WONbr = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from WOMatlReq WHERE WONbr = @WONbr
	if (@@error = 0)
	 	print 'Delete WOMatlReq complete'
	else
	 	begin
	 		print 'WOMatlReq error'
	 		select @ErrorCode = 3
	 		goto FINISH
	 	end

   -- WOROUTING
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             WORouting
   	WHERE            WONbr = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from WORouting WHERE WONbr = @WONbr
	if (@@error = 0)
	 	print 'Delete WORouting complete'
	else
	 	begin
	 		print 'WORouting error'
	 		select @ErrorCode = 4
	 		goto FINISH
	 	end

   -- WOEVENT
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             WOEvent
   	WHERE            WONbr = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from WOEvent WHERE WONbr = @WONbr
	if (@@error = 0)
		print 'Delete WOEvent complete'
	else
		begin
			print 'WOEvent error'
			select @ErrorCode = 5
			goto FINISH
		end

   -- WOLOTSERT
	-- No SNote - no opportunity to add Notes to WOLOTSERT
	Delete from WOLotSerT WHERE WONbr = @WONbr
	if (@@error = 0)
		print 'Delete WOLotSerT complete'
	else
		begin
			print 'WOLotSerT error'
			select @ErrorCode = 6
			goto FINISH
		end

   -- PJPROJ
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             PJProj
   	WHERE            Project = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from PJProj WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJProj complete'
	else
		begin
			print 'PJProj error'
			select @ErrorCode = 7
			goto FINISH
		end

   -- PJPROJEX
	-- No SNote - no opportunity to add Notes to PJPROJEX
	Delete from PJProjEx WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJProjEx complete'
	else
		begin
			print 'PJProjEx error'
			select @ErrorCode = 8
			goto FINISH
		end

   -- PJPENT
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             PJPEnt
   	WHERE            Project = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from PJPEnt WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJPEnt complete'
	else
		begin
			print 'PJPEnt error'
			select @ErrorCode = 9
			goto FINISH
		end

   -- PJPENTEX
	-- No SNote - no opportunity to add Notes to PJPENTEX
	Delete from PJPEntEx WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJPEntEx complete'
	else
		begin
			print 'PJPEntEx error'
			select @ErrorCode = 10
			goto FINISH
		end

   -- PJPTDROL
	-- No SNote - no opportunity to add Notes to PJPTDROL
	Delete from PJPtdRol WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJPtdRol complete'
	else
		begin
			print 'PJPtdRol error'
			select @ErrorCode = 11
			goto FINISH
		end

   -- PJPTDSUM
	-- No SNote - no opportunity to add Notes to PJPTDSUM
	Delete from PJPtdSum WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJPtdSum complete'
	else
		begin
			print 'PJPtdSum error'
			select @ErrorCode = 12
			goto FINISH
		end

   -- PJTRANEX
	-- No SNote - no opportunity to add Notes to PJTranEx
	Delete from PJTranEx Where EXISTS
	(Select * from PJTran Where PJTranEx.fiscalno = PJTran.fiscalno and
			PJTranEx.system_cd = PJTran.system_cd and
			PJTranEx.batch_id = PJTran.batch_id and
			PJTranEx.detail_num = PJTran.detail_num and
			PJTran.Project = @WONbr)
	if (@@error = 0)
		print 'Delete PJTranEx complete'
	else
		begin
			print 'PJTranEx error'
			select @ErrorCode = 13
			goto FINISH
		end

   -- PJTRAN
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             PJTran
   	WHERE            Project = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from PJTRan WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJTran complete'
	else
		begin
			print 'PJTran error'
			select @ErrorCode = 14
			goto FINISH
		end

   -- PJPROJEM
	-- First SNote
   	DECLARE          WO_Cursor CURSOR LOCAL
   	FOR
   	SELECT           NoteID
   	FROM             PJProjEM
   	WHERE            Project = @WONbr
        if (@@error <> 0) GOTO ABORT

	   Open WO_Cursor
 	   Fetch Next From WO_Cursor Into @NoteID
	   While (@@Fetch_Status = 0)
		Begin
			Delete From SNote WHERE SNote.nID = @NoteID
 	   		Fetch Next From WO_Cursor Into @NoteID
		End
	   Close WO_Cursor
	   Deallocate WO_Cursor

	Delete from PJProjEm WHERE Project = @WONbr
	if (@@error = 0)
		print 'Delete PJProjEm complete'
	else
		begin
			print 'PJProjEm error'
			select @ErrorCode = 15
			goto FINISH
		end

ABORT:

FINISH:



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WODelete] TO [MSDSL]
    AS [dbo];

