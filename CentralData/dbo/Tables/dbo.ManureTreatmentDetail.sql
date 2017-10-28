CREATE TABLE [dbo].[ManureTreatmentDetail] (
    [LineNbr]              INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ManureTreatID]        INT          NOT NULL,
    [ManureTreatProductID] VARCHAR (30) NULL,
    [UnitOfMeasure]        VARCHAR (50) NULL,
    [Qty]                  FLOAT (53)   NULL,
    [Comment]              VARCHAR (60) NULL,
    CONSTRAINT [PK_ManureTreatmentDetail] PRIMARY KEY CLUSTERED ([ManureTreatID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_ManureTreatmentDetail_ManureTreatment] FOREIGN KEY ([ManureTreatID]) REFERENCES [dbo].[ManureTreatment] ([ManureTreatID]) ON DELETE CASCADE
);

