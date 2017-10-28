CREATE TABLE [dbo].[SiteCareType] (
    [SiteCareTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteCareTypeDescription] VARCHAR (15) NULL,
    CONSTRAINT [PK_SiteCareType] PRIMARY KEY CLUSTERED ([SiteCareTypeID] ASC) WITH (FILLFACTOR = 90)
);

