Create proc dbo.pTruckDriveMilesWeek
		@BegDate smalldatetime
AS
Select @BegDate as SundayDate, TruckerID, ContactName, Sum(Miles) as TotalMiles,
SundayMiles=dbo.GetMiles(@BegDate,t.TruckerID),
MondayMiles=dbo.GetMiles(@BegDate+1,t.TruckerID),
TuesdayMiles=dbo.GetMiles(@BegDate+2,t.TruckerID),
WednesdayMiles=dbo.GetMiles(@BegDate+3,t.TruckerID),
ThursdayMiles=dbo.GetMiles(@BegDate+4,t.TruckerID),
FridayMiles=dbo.GetMiles(@BegDate+5,t.TruckerID),
SaturdayMiles=dbo.GetMiles(@BegDate+6,t.TruckerID)

from vTruckDriveMilesbyDay t Where MovementDate between @BegDate and @BegDate+6
Group by  ContactName,TruckerID 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pTruckDriveMilesWeek] TO [MSDSL]
    AS [dbo];

