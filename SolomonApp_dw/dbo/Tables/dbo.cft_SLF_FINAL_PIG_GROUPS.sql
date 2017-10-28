CREATE TABLE [dbo].[cft_SLF_FINAL_PIG_GROUPS] (
    [PigGroupID]     CHAR (10)     NOT NULL,
    [PigProdPhaseID] CHAR (3)      NOT NULL,
    [ActCloseDate]   SMALLDATETIME NOT NULL,
    [PGStatusID]     CHAR (2)      NOT NULL,
    [CostFlag]       SMALLINT      NOT NULL,
    [PigSystemID]    CHAR (10)     NOT NULL,
    [MasterGroup]    CHAR (10)     NOT NULL,
    [MGActCloseDate] SMALLDATETIME NOT NULL
);

