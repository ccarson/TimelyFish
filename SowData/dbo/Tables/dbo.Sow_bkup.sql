CREATE TABLE [dbo].[Sow_bkup] (
    [FarmID]            VARCHAR (8)   NOT NULL,
    [SowID]             VARCHAR (12)  NOT NULL,
    [AlternateID]       VARCHAR (20)  NULL,
    [EntryDate]         SMALLDATETIME NULL,
    [EntryWeekOfDate]   SMALLDATETIME NULL,
    [TrueEntryDate]     VARCHAR (3)   NULL,
    [Genetics]          VARCHAR (20)  NULL,
    [InitialParity]     SMALLINT      NULL,
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
    CONSTRAINT [PK_Sow_bkup] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 80)
);

