CREATE TABLE [dbo].[SowTemp] (
    [FarmID]            VARCHAR (8)   NOT NULL,
    [SowID]             VARCHAR (12)  NOT NULL,
    [AlternateID]       VARCHAR (20)  NULL,
    [EntryDate]         SMALLDATETIME NULL,
    [EntryWeekOfDate]   SMALLDATETIME NULL,
    [TrueEntryDate]     VARCHAR (3)   CONSTRAINT [DF_SowTemp_TrueEntryDate] DEFAULT ('YES') NULL,
    [Genetics]          VARCHAR (20)  NULL,
    [InitialParity]     SMALLINT      CONSTRAINT [DF_SowTemp_InitialParity] DEFAULT (0) NULL,
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
    CONSTRAINT [PK_SowTemp] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowTemp_RemovalDate]
    ON [dbo].[SowTemp]([RemovalDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowTemp_EntryDate]
    ON [dbo].[SowTemp]([EntryDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowTemp_RemovalWeekOfDate]
    ON [dbo].[SowTemp]([RemovalWeekOfDate] ASC) WITH (FILLFACTOR = 90);

