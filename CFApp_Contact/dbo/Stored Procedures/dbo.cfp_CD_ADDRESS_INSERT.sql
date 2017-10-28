
-- ============================================================================
-- Author:	Brian Cesafsky
-- Create date: 09/28/2009
-- Description:	CENTRAL DATA - Creates new address record and returns it's ID.
-- ============================================================================
CREATE PROCEDURE dbo.cfp_CD_ADDRESS_INSERT
(
	@AddressID		int		OUT,
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
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.Address
	(
		[Address1]
		,[Address2]
		,[City]
		,[State]
		,[Zip]
		,[Country]
		,[Longitude]
		,[Latitude]
		,[County]
		,[Township]
		,[SectionNbr]
		,[Range]
	) 
	VALUES 
	(
		@Address1
		,@Address2
		,@City
		,@State
		,@Zip
		,@Country
		,@Longitude
		,@Latitude
		,@County
		,@Township
		,@SectionNbr
		,@Range
	)
	set @AddressID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ADDRESS_INSERT] TO [db_sp_exec]
    AS [dbo];

