CREATE TABLE [dbo].[cft_SLF_TRANSFERIN_PIGDAYS] (
    [PigGroupID]        CHAR (10)  NOT NULL,
    [SourcePigGroupID]  CHAR (10)  NOT NULL,
    [TransferQty]       INT        NOT NULL,
    [TransferInPigDays] FLOAT (53) NOT NULL
);

