CREATE TABLE [dbo].[GiltTagUsage] (
    [GiltTagUsageID]    INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]            VARCHAR (8)   NOT NULL,
    [TagDate1KDay]      VARCHAR (6)   NULL,
    [TagDate]           SMALLDATETIME NOT NULL,
    [TagSeries]         VARCHAR (2)   NULL,
    [StartingTagNbr]    VARCHAR (4)   NULL,
    [EndingTagNbr]      VARCHAR (4)   NULL,
    [Genetics]          VARCHAR (20)  NULL,
    [Comment]           VARCHAR (60)  NULL,
    [CreatedByUser]     VARCHAR (20)  NULL,
    [CreatedOnDate]     SMALLDATETIME NULL,
    [LastUpdatedByUser] VARCHAR (20)  NULL,
    [LastUpdatedOnDate] SMALLDATETIME NULL,
    CONSTRAINT [PK_GiltTagUsage] PRIMARY KEY CLUSTERED ([GiltTagUsageID] ASC) WITH (FILLFACTOR = 90)
);

