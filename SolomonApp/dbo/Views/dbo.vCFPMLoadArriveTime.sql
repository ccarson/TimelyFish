
--*************************************************************
--	Purpose:Concatenates MovementDate and Load/Arrive Times	
--	Author: Charity Anderson
--	Date: 5/12/2004
--	Usage: cfvTruckWashSchedule
--	Parms: 
--	       
--*************************************************************

CREATE View dbo.vCFPMLoadArriveTime 
	
AS

SELECT     ActualQty, ActualWgt, ArrivalDate, ArrivalTime, BoardBackColor, Comment, CpnyID, Crtd_DateTime, Crtd_Prog, Crtd_User, DeleteFlag, DestBarnNbr, 
                      DestContactID, DestPigGroupID, DestProject, DestRoomNbr, DestTask, DestTestStatus, DisinfectFlg, EstimatedQty, EstimatedWgt, GiltAge, Highlight, 
                      ID, LineNbr, LoadingTime, Lupd_DateTime, Lupd_Prog, Lupd_User, MarketSaleTypeID, MovementDate, NonUSOrigin, OrdNbr, OrigMovementDate, 
                      PFEUEligible, PigFlowID, PigGenderTypeID, PigTrailerID, PigTypeID, PkrContactID, PMID, PMLoadID, PMSystemID, PMTypeID, PONbr, SourceBarnNbr, 
                      SourceContactID, SourcePigGroupID, SourceProject, SourceRoomNbr, SourceTask, SourceTestStatus, SuppressFlg, Tailbite, TattooFlag, 
                      TrailerWashFlag, TrailerWashStatus, TranSubTypeID, TruckerContactID, WalkThrough, 
                      tstamp, CAST(MovementDate + ' ' + ISNULL(CONVERT(Varchar(2), DATEPART(hour, LoadingTime)) + ':' + CONVERT(varchar(2), 
                      DATEPART(minute, LoadingTime)) + ':' + CONVERT(varchar(2), DATEPART(second, LoadingTime)), '00:00:00') AS smalldatetime) AS LoadTime, 
                      CAST(MovementDate + ' ' + ISNULL(CONVERT(Varchar(2), DATEPART(hour, ArrivalTime)) + ':' + CONVERT(varchar(2), DATEPART(minute, ArrivalTime)) 
                      + ':' + CONVERT(varchar(2), DATEPART(second, ArrivalTime)), '00:00:00') AS smalldatetime) AS ArriveTime
FROM         dbo.cftPM AS pm

