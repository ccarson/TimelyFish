Create proc dbo.pTruckDriveMilesWeekMarket
		@BegDate smalldatetime
AS
Select @BegDate as SundayDate, TruckingID, ContactName, Sum(Miles) as TotalMiles,
SundayMiles=dbo.GetMarketMiles(@BegDate,t.TruckingID),
MondayMiles=dbo.GetMarketMiles(@BegDate+1,t.TruckingID),
TuesdayMiles=dbo.GetMarketMiles(@BegDate+2,t.TruckingID),
WednesdayMiles=dbo.GetMarketMiles(@BegDate+3,t.TruckingID),
ThursdayMiles=dbo.GetMarketMiles(@BegDate+4,t.TruckingID),
FridayMiles=dbo.GetMarketMiles(@BegDate+5,t.TruckingID),
SaturdayMiles=dbo.GetMarketMiles(@BegDate+6,t.TruckingID)

from vTruckDriveMilesbyDayMarket t Where MovementDate between @BegDate and @BegDate+6
Group by  ContactName,TruckingID 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pTruckDriveMilesWeekMarket] TO [MSDSL]
    AS [dbo];

