CREATE TABLE [dbo].[cft_SLF_PIG_GROUPS_GEN8] (
    [CombPigGroupID]    CHAR (12)     NOT NULL,
    [PigGroupID]        CHAR (10)     NOT NULL,
    [MasterGroup]       CHAR (10)     NOT NULL,
    [MGActCloseDate]    SMALLDATETIME NOT NULL,
    [DestPhase]         CHAR (3)      NOT NULL,
    [acct]              CHAR (16)     NOT NULL,
    [Qty]               INT           NOT NULL,
    [TotalWgt]          FLOAT (53)    NOT NULL,
    [SourcePigGroupID]  CHAR (10)     NULL,
    [SourceProject]     CHAR (16)     NOT NULL,
    [SourceHC_TO]       INT           NULL,
    [SourceWt_TO]       FLOAT (53)    NULL,
    [SourcePhase]       CHAR (3)      NULL,
    [SourceCostFlag]    SMALLINT      NULL,
    [SourcePGStatusID]  CHAR (2)      NULL,
    [SourcePigSystemID] CHAR (10)     NULL
);

