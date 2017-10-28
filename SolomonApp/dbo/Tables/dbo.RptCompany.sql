CREATE TABLE [dbo].[RptCompany] (
    [CpnyID]   CHAR (10)  NOT NULL,
    [CpnyName] CHAR (30)  NOT NULL,
    [RI_ID]    SMALLINT   NOT NULL,
    [tstamp]   ROWVERSION NOT NULL,
    CONSTRAINT [RptCompany0] PRIMARY KEY CLUSTERED ([RI_ID] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90)
);

