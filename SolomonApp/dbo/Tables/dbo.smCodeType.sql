CREATE TABLE [dbo].[smCodeType] (
    [CallTypeId]    CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Fault_Id]      CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smCodeType0] PRIMARY KEY CLUSTERED ([Fault_Id] ASC, [CallTypeId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [smCodeType1]
    ON [dbo].[smCodeType]([CallTypeId] ASC, [Fault_Id] ASC) WITH (FILLFACTOR = 90);

