CREATE TABLE [dbo].[ManureApplicationMethod] (
    [ManureApplicationMethodID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]               VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureAppliationType] PRIMARY KEY CLUSTERED ([ManureApplicationMethodID] ASC) WITH (FILLFACTOR = 90)
);

