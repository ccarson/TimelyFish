-- ===============================================================
-- Author:		Brian Cesafsky
-- Create date: 02/26/2009
-- Description:	CENTRAL DATA - Updates a barn by barnID 
-- ===============================================================
CREATE PROCEDURE dbo.cfp_CD_BARN_UPDATE
(
		@BarnID							int
		,@StdPenWidth					float
		,@StdPenLength					float
		,@NbrStdPens 					float
		,@NbrStdPenSpace 				float
		,@FloorType						smallint
		,@FeederType					smallint
		,@FeederWidth					float
		,@FeedersPerPen					float
		,@WatererType					smallint
		,@WaterersPerPen				float
		,@SupplHeatSource				varchar(50)
		,@SupplHeatAvailable			varchar(50)
		,@SupplHeat						varchar(50)
		,@CenterToLoadoutDist			float
		,@NbrOfLoadouts					float
		,@NurAvailable					bit
		,@BigPen						bit
		,@PaymentSpaces					float
		,@WFCapable						bit
		,@WFCapableOverride				bit
		,@ContractType					smallint
		,@NonPigSpace					float
		,@UpdatedBy						varchar(50)
)
AS
BEGIN

Declare @updateCheck int
Select @updateCheck = count(*) from [$(CentralData)].dbo.BarnChar (NOLOCK) where BarnID = @BarnID

IF @updateCheck = 1
BEGIN
--update
	UPDATE [$(CentralData)].dbo.BarnChar
		SET	 StdPenWidth = @StdPenWidth
			,StdPenLength = @StdPenLength
			,NbrStdPens = @NbrStdPens				
			,NbrStdPenSpace = @NbrStdPenSpace 				
			,FloorType = @FloorType						
			,FeederType = @FeederType					
			,FeederWidth = @FeederWidth					
			,FeedersPerPen = @FeedersPerPen					
			,WatererType = @WatererType					
			,WaterersPerPen = @WaterersPerPen				
			,SupplHeatSource = @SupplHeatSource				
			,SupplHeatAvailable = @SupplHeatAvailable
			,SupplHeat = @SupplHeat			
			,CenterToLoadoutDist = @CenterToLoadoutDist			
			,NbrOfLoadouts = @NbrOfLoadouts					
			,NurAvailable = @NurAvailable					
			,BigPen = @BigPen						
			,PaymentSpaces = @PaymentSpaces		
			,WFCapable = @WFCapable
			,WFCapableOverride = @WFCapableOverride
			,ContractType = @ContractType
			,NonPigSpace = @NonPigSpace	
			,UpdatedBy = @UpdatedBy
			,UpdatedDateTime = GetDate()
	WHERE [BarnID] = @BarnID
END
ELSE
BEGIN
--insert
	INSERT [$(CentralData)].dbo.BarnChar
	(
		BarnID
		,StdPenWidth
		,StdPenLength
		,NbrStdPens		
		,NbrStdPenSpace				
		,FloorType					
		,FeederType				
		,FeederWidth				
		,FeedersPerPen				
		,WatererType				
		,WaterersPerPen			
		,SupplHeatSource		
		,SupplHeatAvailable		
		,SupplHeat
		,CenterToLoadoutDist	
		,NbrOfLoadouts		
		,NurAvailable				
		,BigPen				
		,PaymentSpaces	
		,WFCapable
		,WFCapableOverride
		,ContractType
		,NonPigSpace	
		,UpdatedBy
		,UpdatedDateTime
	) 
	VALUES 
	(
		@BarnID
		,@StdPenWidth
		,@StdPenLength
		,@NbrStdPens				
		,@NbrStdPenSpace 				
		,@FloorType						
		,@FeederType					
		,@FeederWidth					
		,@FeedersPerPen					
		,@WatererType					
		,@WaterersPerPen				
		,@SupplHeatSource				
		,@SupplHeatAvailable	
		,@SupplHeat		
		,@CenterToLoadoutDist			
		,@NbrOfLoadouts					
		,@NurAvailable					
		,@BigPen						
		,@PaymentSpaces			
		,@WFCapable
		,@WFCapableOverride
		,@ContractType
		,@NonPigSpace			
		,@UpdatedBy
		,GetDate()
	)
END

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_BARN_UPDATE] TO [db_sp_exec]
    AS [dbo];

