CREATE TABLE [dbo].[Sow_remove] (
    [FarmID]            VARCHAR (8)   NOT NULL,
    [SowID]             VARCHAR (12)  NOT NULL,
    [AlternateID]       VARCHAR (20)  NULL,
    [EntryDate]         SMALLDATETIME NULL,
    [EntryWeekOfDate]   SMALLDATETIME NULL,
    [TrueEntryDate]     VARCHAR (3)   CONSTRAINT [DF_Sow_TrueEntryDate] DEFAULT ('YES') NULL,
    [Genetics]          VARCHAR (20)  NULL,
    [InitialParity]     SMALLINT      CONSTRAINT [DF_Sow_InitialParity] DEFAULT (0) NULL,
    [Origin]            VARCHAR (20)  NULL,
    [Birthdate]         SMALLDATETIME NULL,
    [Sire]              VARCHAR (12)  NULL,
    [Dam]               VARCHAR (12)  NULL,
    [RemovalDate]       SMALLDATETIME NULL,
    [RemovalWeekOfDate] SMALLDATETIME NULL,
    [RemovalType]       VARCHAR (20)  NULL,
    [PrimaryReason]     VARCHAR (30)  NULL,
    [SecondaryReason]   VARCHAR (30)  NULL,
    [User1]             VARCHAR (20)  NULL,
    [User2]             VARCHAR (20)  NULL,
    CONSTRAINT [PK_Sow] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSow_EntryDate]
    ON [dbo].[Sow_remove]([EntryDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSow_RemovalDate]
    ON [dbo].[Sow_remove]([RemovalDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSow_RemovalType]
    ON [dbo].[Sow_remove]([RemovalType] ASC) WITH (FILLFACTOR = 80);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Sow_remove] TO PUBLIC
    AS [dbo];

