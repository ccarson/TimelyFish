CREATE TABLE [dbo].[BinType] (
    [BinTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [BinTypeDescription] VARCHAR (30) NOT NULL,
    [BinCapacity]        FLOAT (53)   NOT NULL,
    [RingConversion]     FLOAT (53)   NULL,
    [ConeConversion]     FLOAT (53)   NULL,
    CONSTRAINT [PK_BinType] PRIMARY KEY CLUSTERED ([BinTypeID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Description/Capacity]
    ON [dbo].[BinType]([BinTypeDescription] ASC, [BinCapacity] ASC) WITH (FILLFACTOR = 90);
