CREATE TABLE [stage].[ObservedHeatEvent] (
    [ObservedHeatEventKey] BIGINT        NOT NULL,
    [ParityEventKey]       BIGINT        NOT NULL,
    [SourceGUID]           NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([ObservedHeatEventKey] ASC)
);



