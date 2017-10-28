CREATE PROCEDURE XDDDepositor_Cnt_Update_Vouchers
	@Mode			varchar( 1 ),	-- C-count, U-update eConfirm&eStatus, E-update eConfirm only
	@VendID			varchar( 15 ),
	@VendAcct		varchar( 10 ),
	@Upd_Prog       	varchar( 8 ),
	@Upd_User       	varchar( 10 )

AS

	Declare @VOCnt		int
	Declare @VMCnt		int	-- Distributed liability
	Declare @RCCnt		int	-- Recurring voucher
	Declare @eStatus	varchar( 1 )
	
if @Mode = 'C'
BEGIN

	-- Regular
	SET @VOCnt = (Select coalesce(count(*),0) FROM APDoc (nolock)
			WHERE VendID = @VendID
				and DocType IN ('VO', 'AD', 'AC') -- , 'VT')
				and Selected = 0	-- not selected
				and OpenDoc = 1
				and eStatus = '')

	-- Distributed Liability - Not released
	SET @VMCnt = (Select coalesce(count(*),0) FROM APDoc (nolock)
			WHERE VendID = @VendID
				and DocType IN ('VM')
				and Selected = 0	-- not selected
				and OpenDoc = 1
				and Rlsed = 0		-- not released only
				and eStatus = '')

	-- Recurring
	SET @RCCnt = (Select coalesce(count(*),0) FROM APDoc (nolock)
			WHERE VendID = @VendID
				and DocType IN ('RC')
				and Selected = 0	-- not selected
				-- and OpenDoc = 1
				and eStatus = '')

	SELECT @VOCnt, @VMCnt, @RCCnt
END

else

BEGIN

	if @Mode = 'U'
	BEGIN
		SET	@eStatus = ''

		-- Get eStatus from XDDTxnType
		SELECT 	@eStatus = coalesce(TT.eStatus, '')
		FROM	XDDDepositor D (nolock) LEFT OUTER JOIN XDDTxnType TT (nolock)
			ON D.FormatID = TT.FormatID and D.EntryClass = TT.EntryClass
		WHERE	D.VendID = @VendID
			and D.VendAcct = @VendAcct
			and D.VendCust = 'V'

		-- Regular vouchers
		Update APDoc
		SET 	eStatus = @eStatus,
			eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('VO', 'AD', 'AC') -- , 'VT')
			and Selected = 0	-- not selected
			and OpenDoc = 1		-- OpenDoc
			and eStatus = ''

		-- Distributed Liability - Unreleased only
		Update APDoc
		SET 	eStatus = @eStatus,
			eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('VM')
			and Selected = 0	-- not selected
			and OpenDoc = 1		-- OpenDoc
			and Rlsed = 0
			and eStatus = ''

		-- Recurring vouchers
		Update APDoc
		SET 	eStatus = @eStatus,
			eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('RC')
			and Selected = 0	-- not selected
			and eStatus = ''
	END
	
	else

	BEGIN
	-- Mode = 'E' - eConfirm update only ... for all open vouchers

		-- Regular vouchers
		Update APDoc
		SET 	eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('VO', 'AD', 'AC', 'VT')
			and Selected = 0	-- not selected
			and OpenDoc = 1		-- OpenDoc

		-- Distributed Liability - Unreleased only
		Update APDoc
		SET 	eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('VM')
			and Selected = 0	-- not selected
			and OpenDoc = 1		-- OpenDoc
			and Rlsed = 0

		-- Recurring vouchers
		Update APDoc
		SET 	eConfirm = @VendAcct,
			LUpd_Prog = @Upd_Prog,
			LUpd_DateTime = GetDate(),
			LUpd_User = @Upd_User
		WHERE 	VendID = @VendID
			and DocType IN ('RC')
			and Selected = 0	-- not selected

	END

END

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Cnt_Update_Vouchers] TO [MSDSL]
    AS [dbo];

