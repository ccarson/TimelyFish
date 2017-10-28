CREATE TABLE [dbo].[PJEMPLOYXREFMSP] (
    [CpnyID]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (47)     NOT NULL,
    [Employee]         CHAR (10)     NOT NULL,
    [Employee_MSPID]   CHAR (36)     NOT NULL,
    [Employee_MSPName] CHAR (60)     NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (47)     NOT NULL,
    [ProjectManager]   CHAR (1)      NOT NULL,
    [WindowsUserAcct]  CHAR (85)     NOT NULL,
    [TStamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [PJEMPLOYXREFMSP0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [Employee] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PJEMPLOYXREFMSP1]
    ON [dbo].[PJEMPLOYXREFMSP]([Employee_MSPID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PJEMPLOYXREFMSP2]
    ON [dbo].[PJEMPLOYXREFMSP]([Employee_MSPName] ASC) WITH (FILLFACTOR = 90);

