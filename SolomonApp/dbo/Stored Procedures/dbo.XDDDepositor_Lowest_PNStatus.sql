
CREATE PROCEDURE XDDDepositor_Lowest_PNStatus
  	@VendCust		varchar( 1 ),
  	@VendID			varchar( 15 ),
	@VendAcct		varchar( 10 ),
	@VendAcctPNStatus	varchar( 1 )
AS

	Declare @PNStatus	varchar( 1 )
	Declare @LowPNStatus	varchar( 1 )

	SET		@PNStatus = ''

	SELECT	TOP 1	@PNStatus = PNStatus 
	FROM		XDDDepositor (nolock)
	WHERE		VendCust = @VendCust
			and VendID = @VendID
			and VendAcct <> @VendAcct
	ORDER BY	Case PNStatus
				WHEN 'N' THEN 1
				WHEN 'P' Then 2
				WHEN 'A' Then 3
				Else 4
				end

	-- compare the lowest from above to the current one passed in parms
	-- @PNStatus is lowest value other than the current one we're on - might not be saved
	
	SET @LowPNStatus = Case @PNStatus
				When '' Then @VendAcctPNStatus
				When 'N' Then 'N'
				When 'P' Then
					Case @VendAcctPNStatus
					When 'N' Then 'N'
					else @PNStatus
					end
				When 'A' then @VendAcctPNStatus
				else 'A'
				end

	SELECT @LowPNStatus

GO
GRANT CONTROL
    ON OBJECT::[dbo].[XDDDepositor_Lowest_PNStatus] TO [MSDSL]
    AS [dbo];

