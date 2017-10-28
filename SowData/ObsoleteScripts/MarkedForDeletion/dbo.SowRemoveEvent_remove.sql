CREATE TABLE [dbo].[SowRemoveEvent_remove] (
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
    CONSTRAINT [PK_SowRemoveEvent] PRIMARY KEY CLUSTERED ([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 80)
);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEvent_FarmID]
    ON [dbo].[SowRemoveEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEvent_WeekOfDate]
    ON [dbo].[SowRemoveEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEvent_SowParity]
    ON [dbo].[SowRemoveEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEvent_SowGenetics]
    ON [dbo].[SowRemoveEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 80);


GO
CREATE NONCLUSTERED INDEX [idxSowRemoveEvent_SowID]
    ON [dbo].[SowRemoveEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 80);


GO
CREATE TRIGGER dbo.trIns_SowRemoveEvent ON [dbo].[SowRemoveEvent_remove]
	FOR INSERT
	As
	UPDATE s
	SET s.RemovalDate = i.EventDate, s.RemovalWeekOfDate = i.WeekOfDate,
	s.RemovalType = i.RemovalType, s.PrimaryReason = i.PrimaryReason, 
	s.SecondaryReason = i.SecondaryReason
	FROM Sow s
	JOIN Inserted i ON s.FarmID = i.FarmID AND s.SowID = i.SowID
