CREATE TABLE [dbo].[cft_Pig_Group_Genetics] (
    [PigGroupID]              VARCHAR (10)   NULL,
    [TaskID]                  VARCHAR (12)   NULL,
    [PigFlowID]               INT            NULL,
    [PigFlowDescription]      VARCHAR (100)  NULL,
    [ReportingGroupID]        INT            NULL,
    [SowTotalWeanedOnPicWeek] INT            NULL,
    [PigChampGeneticName]     VARCHAR (30)   NULL,
    [EstWeanPicYear_Wk]       VARCHAR (6)    NULL,
    [% Genetics]              DECIMAL (5, 2) NULL,
    [GeneticsPercentageOrder] INT            NULL
);

