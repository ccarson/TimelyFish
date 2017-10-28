CREATE TABLE [dbo].[smConPMTask] (
    [CallDate]      SMALLDATETIME NOT NULL,
    [CallGenerated] SMALLINT      NOT NULL,
    [CallNbr]       CHAR (10)     NOT NULL,
    [ContractId]    CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [EquipId]       CHAR (10)     NOT NULL,
    [EstTime]       CHAR (4)      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PMCode]        CHAR (10)     NOT NULL,
    [PMDate]        SMALLDATETIME NOT NULL,
    [PMUseReading]  FLOAT (53)    NOT NULL,
    [PT_ID01]       CHAR (30)     NOT NULL,
    [PT_ID02]       CHAR (30)     NOT NULL,
    [PT_ID03]       CHAR (20)     NOT NULL,
    [PT_ID04]       CHAR (20)     NOT NULL,
    [PT_ID05]       CHAR (10)     NOT NULL,
    [PT_ID06]       CHAR (10)     NOT NULL,
    [PT_ID07]       CHAR (4)      NOT NULL,
    [PT_ID08]       FLOAT (53)    NOT NULL,
    [PT_ID09]       SMALLDATETIME NOT NULL,
    [PT_ID10]       SMALLINT      NOT NULL,
    [SchedDate]     SMALLDATETIME NOT NULL,
    [Technician]    CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConPMTask0] PRIMARY KEY CLUSTERED ([ContractId] ASC, [EquipId] ASC, [PMCode] ASC, [PMDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smConPMTask1]
    ON [dbo].[smConPMTask]([ContractId] ASC, [EquipId] ASC, [PMDate] ASC, [PMCode] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConPMTask2]
    ON [dbo].[smConPMTask]([ContractId] ASC, [EquipId] ASC, [User7] ASC, [PMDate] ASC, [PMCode] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smConPMTask3]
    ON [dbo].[smConPMTask]([CallNbr] ASC) WITH (FILLFACTOR = 90);

