 create proc SCM_WORequest_Insert
	@CpnyID		varchar( 10 ),
	@OrdNbr		varchar( 15 ),
	@LineRef	varchar( 5 ),
	@CustID		varchar( 15 ),
	@InvtID		varchar( 30 ),
	@UserID		varchar( 10 ),
	@ProgID		varchar( 8 )
	AS
	IF Not Exists ( SELECT 		CpnyID
			FROM 		WORequest (NOLOCK)
			WHERE		CpnyID = @CpnyID and
					OrdNbr = @OrdNbr and
					LineRef = @LineRef )
	INSERT INTO	WORequest
	(		CpnyID,
			Crtd_DateTime,
			Crtd_Prog,
			Crtd_Time,
			Crtd_User,
			CustID,
			InvtID,
			LineRef,
			LUpd_DateTime,
			LUpd_Prog,
			LUPd_Time,
			LUpd_User,
			OrdNbr)
	VALUES
	(		@CpnyID,
			GetDate(),
			@ProgID,
			GetDate(),
			@UserID,
			@CustID,
			@InvtID,
			@LineRef,
			GetDate(),
			@ProgID,
			GetDate(),
			@UserID,
			@OrdNbr)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_WORequest_Insert] TO [MSDSL]
    AS [dbo];

