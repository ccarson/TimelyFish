CREATE TABLE [stage].[PregnancyExamEvent] (
    [PregnancyExamEventKey] BIGINT        NOT NULL,
    [ParityEventKey]        BIGINT        NOT NULL,
    [SourceGUID]            NVARCHAR (36) NOT NULL,
    PRIMARY KEY CLUSTERED ([PregnancyExamEventKey] ASC)
);



