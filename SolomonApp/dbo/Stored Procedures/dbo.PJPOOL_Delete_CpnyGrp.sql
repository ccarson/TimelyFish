create proc PJPOOL_Delete_CpnyGrp
	@CpnyID			varchar(10),
	@Period			varchar(6)
as
	BEGIN TRANSACTION

	declare @GrpId	varchar(6)

	declare		PJPoolCursor	cursor
	for
	select		GrpId
	from		PJPoolH
	where		CpnyID = @CpnyID
	  and		Period = @Period

	open PJPoolCursor

		fetch next from PJPoolCursor into @GrpId

		while (@@fetch_status = 0)
		begin
			exec PJPOOLS_DELETE @GrpId, @Period
			IF @@ERROR < > 0 GOTO ABORT
			exec PJPOOLB_DELETE @GrpId, @Period
			IF @@ERROR < > 0 GOTO ABORT

			fetch next from PJPoolCursor into @GrpId
		end

		exec PJPOOLH_DELETE @CpnyID, @Period
		IF @@ERROR < > 0 GOTO ABORT

	close PJPoolCursor
	deallocate PJPoolCursor

COMMIT TRANSACTION

GOTO FINISH

ABORT:
ROLLBACK TRANSACTION

FINISH:


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOL_Delete_CpnyGrp] TO [MSDSL]
    AS [dbo];

