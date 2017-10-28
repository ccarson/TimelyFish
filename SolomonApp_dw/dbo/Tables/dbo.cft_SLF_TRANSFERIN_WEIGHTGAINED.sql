CREATE TABLE [dbo].[cft_SLF_TRANSFERIN_WEIGHTGAINED] (
    [PigGroupID]       CHAR (10)  NOT NULL,
    [SourcePigGroupID] CHAR (10)  NOT NULL,
    [Qty]              INT        NOT NULL,
    [TotalWgt]         FLOAT (53) NOT NULL,
    [AvgWgtOut]        FLOAT (53) NOT NULL,
    [AvgStartWgt]      FLOAT (53) NOT NULL,
    [WgtGained]        FLOAT (53) NOT NULL
);

