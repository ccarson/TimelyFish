CREATE TABLE [dbo].[smContractRev] (
    [Comment]       CHAR (60)     NOT NULL,
    [ContractID]    CHAR (10)     NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [CR_ID01]       CHAR (30)     NOT NULL,
    [CR_ID02]       CHAR (30)     NOT NULL,
    [CR_ID03]       CHAR (20)     NOT NULL,
    [CR_ID04]       CHAR (20)     NOT NULL,
    [CR_ID05]       CHAR (10)     NOT NULL,
    [CR_ID06]       CHAR (10)     NOT NULL,
    [CR_ID07]       CHAR (4)      NOT NULL,
    [CR_ID08]       FLOAT (53)    NOT NULL,
    [CR_ID09]       SMALLDATETIME NOT NULL,
    [CR_ID10]       SMALLINT      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DocType]       CHAR (2)      NOT NULL,
    [GLBatNbr]      CHAR (10)     NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [RevAmount]     FLOAT (53)    NOT NULL,
    [RevDate]       SMALLDATETIME NOT NULL,
    [RevFlag]       SMALLINT      NOT NULL,
    [SalesAcct]     CHAR (10)     NOT NULL,
    [SalesSub]      CHAR (24)     NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [TaskID]        CHAR (32)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smContractRev0] PRIMARY KEY CLUSTERED ([ContractID] ASC, [RevDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smContractRev1]
    ON [dbo].[smContractRev]([RevDate] ASC, [RevFlag] ASC, [Status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [smContractRev2]
    ON [dbo].[smContractRev]([ContractID] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90);

