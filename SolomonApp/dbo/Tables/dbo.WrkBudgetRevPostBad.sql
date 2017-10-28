CREATE TABLE [dbo].[WrkBudgetRevPostBad] (
    [Project]     CHAR (16)  NOT NULL,
    [MsgId]       INT        NOT NULL,
    [MsgTable]    CHAR (20)  NOT NULL,
    [RevId]       CHAR (4)   NOT NULL,
    [UserAddress] CHAR (47)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [WrkBudgetRevPostBad0] PRIMARY KEY CLUSTERED ([Project] ASC, [RevId] ASC, [UserAddress] ASC, [MsgId] ASC)
);

