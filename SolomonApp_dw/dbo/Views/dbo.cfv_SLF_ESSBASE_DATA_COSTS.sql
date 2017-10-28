





CREATE VIEW [dbo].[cfv_SLF_ESSBASE_DATA_COSTS]
AS
SELECT CAST([Site] As NVARCHAR(30)) As [Site]
      ,CAST([MasterGroup] As NVARCHAR(10)) As [MasterGroup]
      ,CAST([MasterGroupDescription] As NVARCHAR(40)) As [MasterGroupDescription]
      ,CAST([FlowGroup] As NVARCHAR(10)) As [FlowGroup]
      ,CAST([FlowGroupDescription] As NVARCHAR(50)) As [FlowGroupDescription]
      ,CAST([CombWTFGroup] As NVARCHAR(50)) As [CombWTFGroup]
      ,CAST([Phase] As NVARCHAR(30)) As [Phase]
     ,CAST([PhaseTypeDesc] As NVARCHAR(50)) As [PhaseTypeDesc]
      ,[PigFlowID]
      ,CAST([PigFlowDescription] As NVARCHAR(50)) As [PigFlowDescription] 
      ,CAST([PG_Week] As NVARCHAR(6)) As [PG_Week]
      ,CAST([MG_Week] As NVARCHAR(6)) As [MG_Week]
      ,CAST([Scenario] As NVARCHAR(30)) As [Scenario]
      ,[FEED_ISSUE]
      ,[FREIGHT]
      ,[MISC_JOB_CHARGES]
      ,[OTHER_REVENUE]
      ,[PIG_BASE_DOLLARS]
      ,[PIG_DEATH]
      ,[PIG_FEED_DELIV]
      ,[PIG_FEED_GRD_MIX]
      ,[PIG_FEED_ISSUE]
      ,[PIG_GRADE_PREM]
      ,[PIG_INT_WC_CHG]
      ,[PIG_MEDS_CHG]
      ,[PIG_MEDS_ISSUE]
      ,[PIG_MISC_EXP]
      ,[PIG_MKT_TRUCKING]
      ,[PIG_MOVE_IN]
      ,[PIG_MOVE_OUT]
      ,[PIG_OVR_HD_CHG]
      ,[PIG_OVR_HD_COST]
      ,[PIG_PURCHASE]
      ,[PIG_SALE]
      ,[PIG_SALE_DED_OTR]
      ,[PIG_SITE_CHG]
      ,[PIG_SORT_LOSS]
      ,[PIG_TRANSFER_IN]
      ,[PIG_TRANSFER_OUT]
      ,[PIG_TRUCKING_CHG]
      ,[PIG_TRUCKING_IN]
      ,[PIG_VACC_CHG]
      ,[PIG_VACC_ISSUE]
      ,[PIG_VET_CHG]
      ,[REPAIR_MAINT]
      ,[REPAIR_PARTS]
      ,[SITE_COST_ACCUM]
      ,[SUPPLIES]
      ,[TRANSPORT_DEATH]
  FROM [dbo].[cft_SLF_ESSBASE_DATA_COSTS]





GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_SLF_ESSBASE_DATA_COSTS] TO [SSIS_Operator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cfv_SLF_ESSBASE_DATA_COSTS] TO [db_sp_exec]
    AS [dbo];

