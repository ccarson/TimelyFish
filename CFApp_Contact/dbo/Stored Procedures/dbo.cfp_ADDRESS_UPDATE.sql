
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Updates an address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_ADDRESS_UPDATE
(
	@AddressID		int,
	@EmailAddress	varchar(50),
	@Address1		varchar(30),
	@Address2		varchar(30),
	@City			varchar(30),
	@State			varchar(2),
	@Zip			varchar(10),
	@Country		varchar(30),
	@Longitude		float,
	@Latitude		float,
	@County			varchar(30),
	@Township		varchar(30),
	@SectionNbr		varchar(30),
	@Range			varchar(30),
	@UpdatedBy		varchar(50)
)
AS
BEGIN
	UPDATE dbo.cft_ADDRESS
	SET [EmailAddress] = @EmailAddress
		,[Address1] = @Address1
		,[Address2] = @Address2
		,[City] = @City
		,[State] = @State
		,[Zip] = @Zip
		,[Country] = @Country
		,[Longitude] = @Longitude
		,[Latitude] = @Latitude
		,[County] = @County
		,[Township] = @Township
		,[SectionNbr] = @SectionNbr
		,[Range] = @Range
		,[UpdatedBy] = @UpdatedBy

	WHERE 
		[AddressID] = @AddressID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADDRESS_UPDATE] TO [db_sp_exec]
    AS [dbo];

