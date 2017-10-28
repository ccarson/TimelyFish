CREATE TABLE [dbo].[cft_SLF_TOTAL_TRANSFEROUT] (
    [PigGroupID]     CHAR (10)  NOT NULL,
    [Qty]            INT        NOT NULL,
    [TotalWgt]       FLOAT (53) NOT NULL,
    [PigProdPhaseID] CHAR (3)   NULL,
    [CostFlag]       SMALLINT   NULL,
    [PGStatusID]     CHAR (2)   NULL,
    [PigSystemID]    CHAR (10)  NULL
);

