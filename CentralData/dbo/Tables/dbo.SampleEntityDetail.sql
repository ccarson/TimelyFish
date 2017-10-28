CREATE TABLE [dbo].[SampleEntityDetail] (
    [SampleID]     INT NOT NULL,
    [EntityID]     INT NOT NULL,
    [EntityTypeID] INT NULL,
    CONSTRAINT [PK_SampleEntityDetail] PRIMARY KEY CLUSTERED ([SampleID] ASC, [EntityID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_SampleEntityDetail_Sample] FOREIGN KEY ([SampleID]) REFERENCES [dbo].[Sample] ([SampleID]) ON DELETE CASCADE
);

