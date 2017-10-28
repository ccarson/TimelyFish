--*************************************************************
--	Purpose:Copy PigMovements		
--	Author: Charity Anderson
--	Date: 2/18/2005
--	Usage: Pig Flow 
--	Parms: New Date, ID
--	      
--*************************************************************
Create Procedure dbo.pXT100CopyPM
	@SpecificDate smalldatetime, @ID as int, @User as varchar(10), @Prog as varchar(8)
AS
	
	Insert into cftPM 
	(ActualQty,ActualWgt,ArrivalDate,ArrivalTime,BoardBackColor,Comment,CpnyID,
	 Crtd_DateTime,Crtd_Prog,Crtd_User,DeleteFlag,DestBarnNbr,DestContactID,
	 DestPigGroupID,DestProject,DestRoomNbr,DestTask,DestTestStatus,DisinfectFlg,
	 EstimatedQty,
	 EstimatedWgt,GiltAge,Highlight,LineNbr,LoadingTime,Lupd_DateTime,
	 Lupd_Prog,Lupd_User,MarketSaleTypeID,MovementDate,NonUSOrigin,OrdNbr,
	 OrigMovementDate,PFEUEligible,PigFlowID,PigGenderTypeID,PigTrailerID,PigTypeID,
	 PkrContactID,PMSystemID,PMTypeID,PONbr,SourceBarnNbr,SourceContactID,
	 SourcePigGroupID,SourceProject,SourceRoomNbr,SourceTask,SourceTestStatus,SuppressFlg, Tailbite,
	 TattooFlag,TrailerWashFlag,TranSubTypeID,TruckerContactID,TrailerWashStatus,WalkThrough,PMID,PMLoadID)

	Select ActualQty,ActualWgt,ArrivalDate,ArrivalTime,BoardBackColor,Comment,CpnyID,
	 GetDAte(),@Prog,@User,DeleteFlag,DestBarnNbr,DestContactID,
	 DestPigGroupID,DestProject,DestRoomNbr,DestTask,DestTestStatus,DisinfectFlg,
	 EstimatedQty,
	 EstimatedWgt,GiltAge,Highlight,LineNbr,LoadingTime,
	 GetDAte(),@Prog,@User,MarketSaleTypeID,@SpecificDate,NonUSOrigin,OrdNbr,
	 @SpecificDate,PFEUEligible,PigFlowID,PigGenderTypeID,PigTrailerID,PigTypeID,
	 PkrContactID,PMSystemID,PMTypeID,PONbr,SourceBarnNbr,SourceContactID,
	 SourcePigGroupID,SourceProject,SourceRoomNbr,SourceTask,SourceTestStatus,SuppressFlg,Tailbite,
	 TattooFlag,TrailerWashFlag,TranSubTypeID,TruckerContactID,TrailerWashStatus,WalkThrough,PMID,PMLoadID
	
	 from cftPM WITH (NOLOCK) where
	ID=@ID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[pXT100CopyPM] TO [SOLOMON]
    AS [dbo];

