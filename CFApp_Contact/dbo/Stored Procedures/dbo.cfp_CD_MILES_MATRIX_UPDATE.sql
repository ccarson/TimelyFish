
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 10/07/2009
-- Description:	Updates address Miles Matrix record
-- Change:  Added Directions  (ddahle) 7/23/2015
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_CD_MILES_MATRIX_UPDATE]
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
	UPDATE [$(CentralData)].dbo.MilesMatrix
	SET OneWayMiles = @OneWayMiles
		,RestrictOneWayMiles = @RestrictOneWayMiles
		,OneWayHours = @OneWayHours
		,RestrictOneWayHours = @RestrictOneWayHours
		,OverRide = @OverRide
		,Directions = @Directions
	WHERE AddressIDFrom = @AddressIDFrom
	AND AddressIDTo = @AddressIDTo
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_MILES_MATRIX_UPDATE] TO [db_sp_exec]
    AS [dbo];

