
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Updates an address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_ADDRESS_UPDATE
(
	@AddressID		int,
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
	@Range			varchar(30)
)
AS
BEGIN
	UPDATE [$(CentralData)].dbo.Address
	SET [Address1] = @Address1
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
	WHERE 
		[AddressID] = @AddressID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ADDRESS_UPDATE] TO [db_sp_exec]
    AS [dbo];

