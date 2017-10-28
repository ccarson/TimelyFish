
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Creates new address record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_ADDRESS_INSERT
(
	@AddressID		int		OUT,
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
	@CreatedBy		varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_ADDRESS 
	(
		[EmailAddress]
		,[Address1]
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
		,[CreatedBy]
	) 
	VALUES 
	(
		@EmailAddress
		,@Address1
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
		,@CreatedBy
	)
	set @AddressID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ADDRESS_INSERT] TO [db_sp_exec]
    AS [dbo];

