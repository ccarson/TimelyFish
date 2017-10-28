CREATE TABLE [dbo].[cft_SLF_TRANSFER_ALL_COST_WP] (
    [PigGroupID]    CHAR (10)  NOT NULL,
    [acct]          CHAR (16)  NOT NULL,
    [FYPeriod]      CHAR (7)   NOT NULL,
    [Qty]           INT        NOT NULL,
    [TotalWgt]      FLOAT (53) NOT NULL,
    [SourceProject] CHAR (16)  NOT NULL,
    [ThreeMoWPCost] FLOAT (53) NULL
);

