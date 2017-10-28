
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 06/30/2008
-- Description:	Creates new Barn Health record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_BARN_HEALTH_INSERT
(
	@BarnHealthID				int		OUT,
	@SiteHealthID				int,
	@BarnID						int,
	@PigGroupID					int,
	@NumberOfDead				int,
	@NumberOfInjections			int,
	@MedicationID				int,
	@MedicationReasonID			int,
	@MedicationStartDate		smalldatetime,
	@Comment					varchar(2000),
	@CreatedBy					varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT dbo.cft_BARN_HEALTH
	(
		[SiteHealthID]
		,[BarnID]
		,[PigGroupID]
		,[NumberOfDead]
		,[NumberOfInjections]
		,[MedicationID]
		,[MedicationReasonID]
		,[MedicationStartDate]
		,[Comment]
		,[CreatedBy]
	) 
	VALUES 
	(
		@SiteHealthID
		,@BarnID
		,@PigGroupID
		,@NumberOfDead
		,@NumberOfInjections
		,@MedicationID
		,@MedicationReasonID
		,@MedicationStartDate
		,@Comment
		,@CreatedBy
	)
	set @BarnHealthID = @@identity
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_BARN_HEALTH_INSERT] TO [db_sp_exec]
    AS [dbo];

