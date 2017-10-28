CREATE TABLE [dbo].[cftPMWeekStatus] (
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PigSystemID]   CHAR (2)      NOT NULL,
    [PMStatusID]    CHAR (2)      NOT NULL,
    [PMTypeID]      CHAR (2)      NOT NULL,
    [WeekOfDate]    SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPMWeekStatus0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [PigSystemID] ASC, [PMTypeID] ASC, [WeekOfDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idxcftPMWeekStatus_WeekOfDate]
    ON [dbo].[cftPMWeekStatus]([WeekOfDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPMWeekStatus_PigSystemID]
    ON [dbo].[cftPMWeekStatus]([PigSystemID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPMWeekStatus_PMStatusID]
    ON [dbo].[cftPMWeekStatus]([PMStatusID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPMWeekStatus_PMTypeID]
    ON [dbo].[cftPMWeekStatus]([PMTypeID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idxcftPMWeekStatus_CpnyID]
    ON [dbo].[cftPMWeekStatus]([CpnyID] ASC) WITH (FILLFACTOR = 90);

