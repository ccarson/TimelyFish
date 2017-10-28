





CREATE VIEW [dbo].[cfv_SLF_ESSBASE_DATA]
AS
SELECT CAST([Site] As NVARCHAR(30)) As [Site]
      ,CAST([MasterGroup] As NVARCHAR(10)) As [MasterGroup]
      ,CAST([MasterGroupDescription] As NVARCHAR(40)) As [MasterGroupDescription]
      ,CAST([FlowGroup] As NVARCHAR(10)) As [FlowGroup]
      ,CAST([FlowGroupDescription] As NVARCHAR(50)) As [FlowGroupDescription]
      ,CAST([Group_Number] As NVARCHAR(50)) As [Group_Number]
      ,CAST([Phase] As NVARCHAR(30)) As [Phase]
     ,CAST([PhaseTypeDesc] As NVARCHAR(50)) As [PhaseTypeDesc]
      ,[PigFlowID]
      ,CAST([PigFlowDescription] As NVARCHAR(50)) As [PigFlowDescription] 
      ,CAST([PG_Week] As NVARCHAR(6)) As [PG_Week]
      ,CAST([MG_Week] As NVARCHAR(6)) As [MG_Week]
      ,CAST([Scenario] As NVARCHAR(30)) As [Scenario]
      ,CAST([PigGroupFeedMill] As NVARCHAR(50)) As [PigGroupFeedMill]
      ,CAST([FlowGroupFeedMill] As NVARCHAR(50)) As [FlowGroupFeedMill]
      ,[TransferInWP_Qty]
      ,[TransferIn_Qty]
      ,[MoveIn_Qty]
      ,[MoveOut_Qty]
      ,[PigDeath_Qty]
      ,[PigDeathTD_Qty]
      ,[TransportDeath_Qty]
      ,[InventoryAdjustment_Qty]
      ,[TransferOut_Qty]
      ,[TransferToTailender_Qty]
      ,[Prim_Qty]
      ,[Cull_Qty]
      ,[DeadOnTruck_Qty]
      ,[DeadInYard_Qty]
      ,[Condemn_Qty]
      ,[TransferInWP_Wt]
      ,[TransferIn_Wt]
      ,[MoveIn_Wt]
      ,[MoveOut_Wt]
      ,[PigDeathTD_Wt]
      ,[TransportDeath_Wt]
      ,[TransferOut_Wt]
      ,[TransferToTailender_Wt]
      ,[Prim_Wt]
      ,[Cull_Wt]
      ,[DeadOnTruck_Wt]
      ,[DeadInYard_Wt]
      ,[Condemn_Wt]
      ,[DeadPigDays]
      ,[LivePigDays]
      ,[Feed_Qty]
      ,[HdCapacity]
      ,[MaxCapacityDays]
      ,[EmptyCapacityDays]
  FROM [dbo].[cft_SLF_ESSBASE_DATA]





GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_SLF_ESSBASE_DATA] TO [SSIS_Operator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_SLF_ESSBASE_DATA] TO [db_sp_exec]
    AS [dbo];

