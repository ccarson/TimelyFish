CREATE TABLE [stage].[NurseEvent] (
    [NurseEventKey]  BIGINT        NOT NULL,
    [ParityEventKey] BIGINT        NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([NurseEventKey] ASC)
);



