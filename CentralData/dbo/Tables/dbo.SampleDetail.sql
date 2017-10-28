CREATE TABLE [dbo].[SampleDetail] (
    [LineNbr]     INT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SampleID]    INT        NOT NULL,
    [AnalyteID]   INT        NOT NULL,
    [TestValue]   FLOAT (53) NOT NULL,
    [NutrientQty] FLOAT (53) NULL,
    CONSTRAINT [PK_SampleDetail] PRIMARY KEY CLUSTERED ([SampleID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SampleDetail_Sample] FOREIGN KEY ([SampleID]) REFERENCES [dbo].[Sample] ([SampleID]) ON DELETE CASCADE
);

