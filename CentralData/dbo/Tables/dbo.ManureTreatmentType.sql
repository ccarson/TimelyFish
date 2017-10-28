CREATE TABLE [dbo].[ManureTreatmentType] (
    [ManureTreatTypeID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]       VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureTreatmentType] PRIMARY KEY CLUSTERED ([ManureTreatTypeID] ASC) WITH (FILLFACTOR = 90)
);

