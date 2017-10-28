--*************************************************************
--	Purpose:Copy PigMovements		
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Flow 
--	Parms: New Date, ID
--	      
--*************************************************************
Create Procedure dbo.pCF100CopyPM
	@SpecificDate smalldatetime, @ID as int
AS
	
	Insert into cftPM 
	(ActualQty,ActualWgt,ArrivalDate,ArrivalTime,BoardBackColor,CpnyID,
	 Crtd_DateTime,Crtd_Prog,Crtd_User,DeleteFlag,DestBarnNbr,DestContactID,
	 DestPigGroupID,DestProject,DestRoomNbr,DestTask,DestTestStatus,EstimatedQty,
	 EstimatedWgt,GiltAge,Highlight,LineNbr,LoadingTime,Lupd_DateTime,
	 Lupd_Prog,Lupd_User,MarketSaleTypeID,MovementDate,NonUSOrigin,OrdNbr,
	 OrigMovementDate,PFEUEligible,PigFlowID,PigGenderTypeID,PigTrailerID,PigTypeID,
	 PkrContactID,PMID,PMLoadID,PMSystemID,PMTypeID,PONbr,SourceBarnNbr,SourceContactID,
	 SourcePigGroupID,SourceProject,SourceRoomNbr,SourceTask,SourceTestStatus,Tailbite,
	 TattooFlag,TrailerWashFlag,TranSubTypeID,TruckerContactID,WalkThrough)
	Select ActualQty,ActualWgt,ArrivalDate,ArrivalTime,BoardBackColor,CpnyID,
	 Crtd_DateTime,Crtd_Prog,Crtd_User,DeleteFlag,DestBarnNbr,DestContactID,
	 DestPigGroupID,DestProject,DestRoomNbr,DestTask,DestTestStatus,EstimatedQty,
	 EstimatedWgt,GiltAge,Highlight,LineNbr,LoadingTime,Lupd_DateTime,
	 Lupd_Prog,Lupd_User,MarketSaleTypeID,@SpecificDate,NonUSOrigin,OrdNbr,
	 @SpecificDate,PFEUEligible,PigFlowID,PigGenderTypeID,PigTrailerID,PigTypeID,
	 PkrContactID,PMID,PMLoadID,PMSystemID,PMTypeID,PONbr,SourceBarnNbr,SourceContactID,
	 SourcePigGroupID,SourceProject,SourceRoomNbr,SourceTask,SourceTestStatus,Tailbite,
	 TattooFlag,TrailerWashFlag,TranSubTypeID,TruckerContactID,WalkThrough
	 from cftPM where
	ID=@ID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100CopyPM] TO [MSDSL]
    AS [dbo];

