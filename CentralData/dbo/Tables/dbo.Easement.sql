CREATE TABLE [dbo].[Easement] (
    [EasementID]             INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [StartDate]              SMALLDATETIME NULL,
    [ExpirationDate]         SMALLDATETIME NULL,
    [Description]            VARCHAR (30)  NULL,
    [SiteID]                 INT           NULL,
    [EasementAttachmentFile] VARCHAR (50)  NULL,
    CONSTRAINT [PK_Easement] PRIMARY KEY CLUSTERED ([EasementID] ASC) WITH (FILLFACTOR = 90)
);

