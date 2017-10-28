CREATE TABLE [stage].[MatingEvent] (
    [MatingEventKey] BIGINT        NOT NULL,
    [ParityEventKey] BIGINT        NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([MatingEventKey] ASC)
);



