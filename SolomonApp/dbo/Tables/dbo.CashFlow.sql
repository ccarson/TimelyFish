CREATE TABLE [dbo].[CashFlow] (
    [Active]        CHAR (1)      NOT NULL,
    [AntDisb]       FLOAT (53)    NOT NULL,
    [AntRcpt]       FLOAT (53)    NOT NULL,
    [BankAcct]      CHAR (10)     NOT NULL,
    [BankSub]       CHAR (24)     NOT NULL,
    [CaseNbr]       CHAR (2)      NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [curyantdisb]   FLOAT (53)    NOT NULL,
    [curyantrcpt]   FLOAT (53)    NOT NULL,
    [curyeffdate]   SMALLDATETIME NOT NULL,
    [CuryID]        CHAR (4)      NOT NULL,
    [CuryMultDiv]   CHAR (1)      NOT NULL,
    [curyrate]      FLOAT (53)    NOT NULL,
    [CuryRateType]  CHAR (6)      NOT NULL,
    [Descr]         CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [PC_Status]     CHAR (1)      NOT NULL,
    [ProjectID]     CHAR (16)     NOT NULL,
    [RcptDisbDate]  SMALLDATETIME NOT NULL,
    [S4Future01]    CHAR (30)     NOT NULL,
    [S4Future02]    CHAR (30)     NOT NULL,
    [S4Future03]    FLOAT (53)    NOT NULL,
    [S4Future04]    FLOAT (53)    NOT NULL,
    [S4Future05]    FLOAT (53)    NOT NULL,
    [S4Future06]    FLOAT (53)    NOT NULL,
    [S4Future07]    SMALLDATETIME NOT NULL,
    [S4Future08]    SMALLDATETIME NOT NULL,
    [S4Future09]    INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
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
    CONSTRAINT [Cashflow0] PRIMARY KEY CLUSTERED ([CaseNbr] ASC, [Descr] ASC, [RcptDisbDate] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [cashflow1]
    ON [dbo].[CashFlow]([RcptDisbDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [cashflow2]
    ON [dbo].[CashFlow]([Descr] ASC) WITH (FILLFACTOR = 90);

