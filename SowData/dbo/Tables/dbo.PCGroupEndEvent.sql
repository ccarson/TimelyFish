CREATE TABLE [dbo].[PCGroupEndEvent] (
    [EventID]    BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]     VARCHAR (8)   NOT NULL,
    [GroupID]    VARCHAR (12)  NOT NULL,
    [EventDate]  SMALLDATETIME NOT NULL,
    [WeekOfDate] SMALLDATETIME NOT NULL,
    [EventType]  VARCHAR (15)  NOT NULL,
    [SortCode]   INT           NULL,
    CONSTRAINT [PK_PCGroupEndEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE TRIGGER dbo.trIns_PCGroupEndEvent ON dbo.PCGroupEndEvent
	FOR INSERT
	As
	UPDATE g
	SET g.CloseDate = i.EventDate
	FROM PCGroup g
	JOIN Inserted i ON g.FarmID = i.FarmID AND g.GroupID = i.GroupID
