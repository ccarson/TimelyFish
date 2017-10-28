CREATE TABLE [stage].[WeanEvent] (
    [WeanEventKey]   BIGINT        NOT NULL,
    [ParityEventKey] BIGINT        NOT NULL,
    [SourceGUID]     NVARCHAR (36) NOT NULL,
    CONSTRAINT [pk_stage_WeanEvent] PRIMARY KEY CLUSTERED ([WeanEventKey] ASC)
);



