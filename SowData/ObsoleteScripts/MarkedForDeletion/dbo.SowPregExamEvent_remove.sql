CREATE TABLE [dbo].[SowPregExamEvent_remove] (
    [EventID]     BIGINT        IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [FarmID]      VARCHAR (8)   NOT NULL,
    [SowID]       VARCHAR (12)  NOT NULL,
    [EventDate]   SMALLDATETIME NOT NULL,
    [WeekOfDate]  SMALLDATETIME NULL,
    [ExamResult]  VARCHAR (20)  NULL,
    [SowParity]   SMALLINT      NULL,
    [SowGenetics] VARCHAR (20)  NULL,
    [SortCode]    INT           NULL,
    CONSTRAINT [PK_SowPregExamEvent] PRIMARY KEY CLUSTERED ([EventID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_FarmID]
    ON [dbo].[SowPregExamEvent_remove]([FarmID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_SowID]
    ON [dbo].[SowPregExamEvent_remove]([SowID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_WeekOfDate]
    ON [dbo].[SowPregExamEvent_remove]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_EventDate]
    ON [dbo].[SowPregExamEvent_remove]([EventDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_SowParity]
    ON [dbo].[SowPregExamEvent_remove]([SowParity] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxSowPregExamEvent_SowGenetics]
    ON [dbo].[SowPregExamEvent_remove]([SowGenetics] ASC) WITH (FILLFACTOR = 90);

