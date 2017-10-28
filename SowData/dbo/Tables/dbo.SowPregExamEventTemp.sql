CREATE TABLE [dbo].[SowPregExamEventTemp] (
    [EventID]     BIGINT        NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NOT NULL,
    [ExamResult]  VARCHAR (20)  NULL,
    [SowParity]   SMALLINT      NOT NULL,
    [SowGenetics] VARCHAR (20)  NOT NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowPregExamEventTemp] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEventTemp_FarmIDSowID]
    ON [dbo].[SowPregExamEventTemp]([FarmID] ASC, [SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEventTemp_EventDate]
    ON [dbo].[SowPregExamEventTemp]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEventTemp_SowParity]
    ON [dbo].[SowPregExamEventTemp]([SowParity] ASC) WITH (FILLFACTOR = 90);

