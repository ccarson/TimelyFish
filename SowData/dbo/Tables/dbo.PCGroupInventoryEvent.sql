CREATE TABLE [dbo].[PCGroupInventoryEvent] (
    [EventID]            BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]             VARCHAR (8)   NOT NULL,
    [GroupID]            VARCHAR (12)  NOT NULL,
    [EventDate]          SMALLDATETIME NOT NULL,
    [WeekOfDate]         SMALLDATETIME NOT NULL,
    [EventType]          VARCHAR (15)  NOT NULL,
    [EventSubType]       VARCHAR (30)  NULL,
    [Qty]                INT           NULL,
    [InventoryEffect]    SMALLINT      NOT NULL,
    [TotalCarcassWeight] FLOAT (53)    NULL,
    [TotalLiveWeight]    FLOAT (53)    NULL,
    [TotalAmount]        FLOAT (53)    NULL,
    [DestinationType]    VARCHAR (15)  NULL,
    [Destination]        VARCHAR (20)  NULL,
    [Source]             VARCHAR (20)  NULL,
    [SortCode]           INT           NULL,
    CONSTRAINT [PK_PCGroupInventoryEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);

