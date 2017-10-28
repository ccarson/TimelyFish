
CREATE PROCEDURE XDDDepositor_Set_MVL
	@FormatId		varchar(15)

As

	Declare @EOF		bit
	Declare @VendID		varchar(15)
	Declare @VendAcct	varchar(10)
	Declare @SKFuture	varchar(30)
	Declare @List		varchar(30)
	Declare @VendType	varchar(1)
	Declare @CrDT		smalldatetime
	Declare @LuDT		smalldatetime
	Declare @InclExcl	varchar(1) 		-- 'I'nclude, 'X'clude
	Declare @LastUpdate	smalldatetime
	
	-- PACH A, PWIR W, PCHK C
    -- VACH B, VWIR X, VCHK D

	SET @EOF = 0
	-- Last MVL update (date/time) is stored in XDDSetup.SKFuture07
	SELECT 	@LastUpdate = SKFuture07
	FROM	XDDSetup (nolock)
	
--	SET @VendID = ''
--	SET @VendType = ''
--	SET @CrDT = 0
--	SET @LuDT = 0

--print 'EOF: ' + convert(varchar(1), @EOF)
--print @formatid

--		Select TOP 1  
--				@VendID = VendID,
--				@VendType = left(EntryClass,1),
--				@CrDT = Crtd_DateTime,
--				@LuDT = LUpd_DateTime
--		FROM	XDDDepositor (nolock) 
--		WHERE	VendCust = 'V'
--				and FormatID = 'US-ACH'
--				and SKFuture01 = ''
--		ORDER BY VendID

--	SELECT TOP 1 vendid, SKFuture01, *

--print 'vendid: ' + @vendid
--print 'vendtype: ' + @VendType

	-- Clear the update field...
	UPDATE XDDDepositor SET SKFuture01 = ''

	-- -------------------------------------------
	-- SKFuture01
	-- 	I-include
	-- 	X-exclude
	-- Public vendors that were newly entered
	--		SKFuture01 = I|PUBLIC |			CrDt > LU Parm
	--		SKFuture01 = X|PUBLIC |			CrDt <= LU Parm
	-- Private vendors - recently updated
	-- 		SKFuture01 = I|PRIVATE|x,y.z	LuDt > LU Parm	
	-- 		SKFuture01 = X|PRIVATE|x,y.z	LuDt <= LU Parm	
	-- ------------------------------------------- 

	While (@EOF = 0)
	BEGIN
	
		SET		@VendID = ''
		Select TOP 1  	@VendID = VendID,
				@VendType = left(EntryClass,1),
				@CrDT = Crtd_DateTime,
				@LuDT = LUpd_DateTime,
				@VendAcct = VendAcct
		FROM	XDDDepositor (nolock)
		WHERE	VendCust = 'V'
				and FormatID = @FormatID
				and SKFuture01 = ''
		ORDER BY VendID, VendAcct

		-- Only process further if found vendor
		if @VendID <> ''
		BEGIN
		
	--print 'vendid: ' + @vendid
	--print 'vendtype: ' + @VendType
			
			-- PACH A, PWIR W, PCHK C
	    	-- VACH B, VWIR X, VCHK D
	
			SET		@List = '' 
			
			if @VendType = 'V'   -- priVate
			BEGIN
				-- Private Vendor
				-- create the delimited list using a query
				SELECt @list = @list + eStatus + ',' from xddtxntypedep (nolock)
				WHERE 	eStatus <> '' 
					and selected = 1
					and VendID = @VendID
					and VendAcct = @VendAcct
	
				SET @InclExcl = 'I'
	
				-- Vendor Last Update after Last recorded update?
				-- First check Day difference
				if DateDiff(d, @LuDT, @LastUpdate) < 0 
					SET @InclExcl = 'I'
				else
				BEGIN
					-- If the day is the same, now check seconds
					-- If the day is not the same, then it must be older, so Exclude
					if DateDiff(minute, @LuDT, @LastUpdate) < 0
						SET @InclExcl = 'I'
					else
						SET @InclExcl = 'X'
				END
	--print 'Private: ' + @VendID
	--print @LastUpdate
	--print @LuDT
	--print @InclExcl
	--print DateDiff(minute, @LuDT, @LastUpdate)
				
				UPDATE XDDDepositor 
				SET 	SKFuture01 = @InclExcl + '|PRIVATE|' + @List
				WHERE 	VendID = @VendID
					and VendCust = 'V'
					and VendAcct = @VendAcct
			END
			
			else
			
			BEGIN
				-- Public Vendor
				-- Only newly added vendors - CrDt after Last Update
				if DateDiff(minute, @CrDt, @LastUpdate) < 0 
					SET @InclExcl = 'I'
				else
					SET @InclExcl = 'X'
	
				UPDATE XDDDepositor 
				SET 	SKFuture01 = @InclExcl + '|PUBLIC |'
				WHERE 	VendID = @VendID
					and VendCust = 'V'
					and VendAcct = @VendAcct
	--print 'Public ' + @Vendid
	--print @LastUpdate
	--print @LuDT
	--print @InclExcl
	--print DateDiff(minute, @LuDT, @LastUpdate)
				
			END
			
		END	-- valid vendor - for this format
		
		if Not Exists(Select * 
			FROM	XDDDepositor (nolock)
			WHERE	VendCust = 'V'
				and FormatID = @FormatID
				and SKFuture01 = '')

			SET @EOF = 1

	END		-- Loop thru all vendors
	
	-- Now set LastUpdate
	UPDATE	XDDSetup
	SET	SKFuture07 = GetDate()


GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Set_MVL] TO [MSDSL]
    AS [dbo];

