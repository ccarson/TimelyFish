CREATE TABLE [stage].[TransferEvent] (
    [TransferEventKey] BIGINT        NOT NULL,
    [SourceGUID]       NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([TransferEventKey] ASC)
);

