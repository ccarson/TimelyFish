
-- ==================================================
-- Author:		<Brian Cesafsky>
-- Create date: <12/19/2007>
-- Description:	<Inserts a Packer Fixed Cost record>
-- ==================================================
CREATE PROCEDURE [dbo].[cfp_PACKER_FIXED_COST_INSERT]
(
	@ContactID						int,
	@PigWeightID					int,
	@FromEffectDate					datetime,
	@ToEffectDate                   datetime,
	@FixedCost						decimal(10, 4),
	@CreatedBy					    varchar(50)
)	
AS
BEGIN

	INSERT INTO dbo.cft_PACKER_FIXED_COST
	(   
		[ContactID],
		[PigWeightID],
		[FromEffectDate],
		[ToEffectDate],
		[FixedCost],
		[CreatedBy]
	)
	VALUES 
	(	
		@ContactID,
		@PigWeightID,
		@FromEffectDate,
		@ToEffectDate,
		@FixedCost,
		@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_FIXED_COST_INSERT] TO [db_sp_exec]
    AS [dbo];

