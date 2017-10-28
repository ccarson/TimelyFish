CREATE TABLE [dbo].[SamplingMethod] (
    [SamplingMethodID] INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Description]      VARCHAR (30) NULL,
    CONSTRAINT [PK_SamplingMethod] PRIMARY KEY CLUSTERED ([SamplingMethodID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Description]
    ON [dbo].[SamplingMethod]([Description] ASC) WITH (FILLFACTOR = 90);

