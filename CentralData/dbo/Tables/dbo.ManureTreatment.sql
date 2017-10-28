CREATE TABLE [dbo].[ManureTreatment] (
    [ManureTreatID]     INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureTreatTypeID] INT           NULL,
    [StartDate]         SMALLDATETIME NULL,
    [EndDate]           SMALLDATETIME NULL,
    [SiteContactID]     INT           NULL,
    [SiteID]            VARCHAR (4)   NULL,
    [ManureStructureID] INT           NULL,
    [Comment]           VARCHAR (60)  NULL,
    CONSTRAINT [PK_ManureTreatment] PRIMARY KEY CLUSTERED ([ManureTreatID] ASC) WITH (FILLFACTOR = 90)
);

