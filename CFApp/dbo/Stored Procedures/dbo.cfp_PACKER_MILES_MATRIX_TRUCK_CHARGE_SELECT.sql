-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 12/10/2007
-- Description:	Returns Miles Matrix information
-- =============================================
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-04-11  Doran Dahle Changed how the Truck Charge is calculated.
						

===============================================================================
*/

CREATE PROCEDURE [dbo].[cfp_PACKER_MILES_MATRIX_TRUCK_CHARGE_SELECT]
(
	@MovementStartDate Datetime,
	@MovementEndDate Datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	select --distinct
            cftPM.PMLoadID,
            cft_PACKER_CONTRACT.ContactID,
            cftMilesMatrix.OneWayMiles,
            TruckCharge =  round([$(SolomonApp)].dbo.cff_getBaseRate(cftMilesMatrix.OneWayMiles,w.WeekOfDate),0) 
      from [$(SolomonApp)].dbo.cftPM cftPM (NOLOCK)
      left join [$(SolomonApp)].dbo.cftContact SourceContact (NOLOCK)
            on cftPM.SourceContactID=SourceContact.ContactID
      left join [$(SolomonApp)].dbo.cftContact DestContact (NOLOCK)
            on cftPM.DestContactID=DestContact.ContactID
      left join [$(SolomonApp)].dbo.cftContactAddress SourceContactAddress (NOLOCK)
            on SourceContactAddress.ContactID = cftPM.SourceContactID
            and SourceContactAddress.AddressTypeID = '01'

      cross join cft_PACKER_CONTRACT cft_PACKER_CONTRACT (NOLOCK)
      left join [$(SolomonApp)].dbo.cftContactAddress PackerContactAddress (NOLOCK)
            on PackerContactAddress.ContactID = cft_PACKER_CONTRACT.ContactID
            and PackerContactAddress.AddressTypeID = '01'

      left join [$(SolomonApp)].dbo.cftMilesMatrix cftMilesMatrix (NOLOCK)
            on cftMilesMatrix.AddressIDFrom=SourceContactAddress.AddressID
            and cftMilesMatrix.AddressIDTo=PackerContactAddress.AddressID
     
      LEFT JOIN [$(SolomonApp)].dbo.cftWeekDefinition w on cftPM.MovementDate between w.WeekOfDate and w.WeekEndDate
      where cftPM.MovementDate between @MovementStartDate and @MovementEndDate
            and right(TranSubTypeID,1)='M'
            and cftPM.PigTypeID='04'
            and (cftPM.Highlight <> 255 and cftPM.Highlight <> -65536)
      order by
            cftPM.MovementDate,
            cftPM.PMLoadID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PACKER_MILES_MATRIX_TRUCK_CHARGE_SELECT] TO [db_sp_exec]
    AS [dbo];

