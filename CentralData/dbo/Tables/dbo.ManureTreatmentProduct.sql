CREATE TABLE [dbo].[ManureTreatmentProduct] (
    [ManureTreatProductID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]          VARCHAR (30) NOT NULL,
    [UnitOfMeasure]        VARCHAR (30) NULL,
    CONSTRAINT [PK_ManureTreatmentProduct] PRIMARY KEY CLUSTERED ([ManureTreatProductID] ASC) WITH (FILLFACTOR = 90)
);

