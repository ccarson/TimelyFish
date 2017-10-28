CREATE TABLE [dbo].[Position] (
    [PositionID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PositionDescription] VARCHAR (30) NULL,
    CONSTRAINT [PK_Position] PRIMARY KEY CLUSTERED ([PositionID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [PositionDescription]
    ON [dbo].[Position]([PositionDescription] ASC) WITH (FILLFACTOR = 90);

