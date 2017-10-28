

-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 10/01/2009
-- Description:	Creates new address Miles Matrix record
-- Change:  Added Directions (ddahle) 7/23/215
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MILES_MATRIX_INSERT]
(
	@AddressIDFrom			int,
	@AddressIDTo			int,
	@OneWayMiles			float,
	@RestrictOneWayMiles	float,
	@OneWayHours			float,
	@RestrictOneWayHours	float,
	@OverRide				smallint,
	@Directions				Varchar(max)
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.MilesMatrix
	(
		AddressIDFrom
		,AddressIDTo
		,OneWayMiles
		,RestrictOneWayMiles
		,OneWayHours
		,RestrictOneWayHours
		,OverRide
		,Directions
	) 
	VALUES 
	(
		@AddressIDFrom
		,@AddressIDTo
		,@OneWayMiles
		,@RestrictOneWayMiles
		,@OneWayHours
		,@RestrictOneWayHours
		,@OverRide
		,@Directions
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MILES_MATRIX_INSERT] TO [db_sp_exec]
    AS [dbo];

