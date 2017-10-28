CREATE TABLE [dbo].[SowRemoveEventTemp] (
    [FarmID]          VARCHAR (8)   NOT NULL,
    [SowID]           VARCHAR (12)  NOT NULL,
    [EventDate]       SMALLDATETIME NULL,
    [WeekOfDate]      SMALLDATETIME NULL,
    [RemovalType]     VARCHAR (20)  NULL,
    [PrimaryReason]   VARCHAR (30)  NULL,
    [SecondaryReason] VARCHAR (30)  NULL,
    [SowParity]       SMALLINT      NULL,
    [SowGenetics]     VARCHAR (20)  NULL,
    [SortCode]        INT           NULL,
    CONSTRAINT [PK_SowRemoveEventTemp] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEventTemp_EventDate]
    ON [dbo].[SowRemoveEventTemp]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEventTemp_WeekOfDate]
    ON [dbo].[SowRemoveEventTemp]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);

