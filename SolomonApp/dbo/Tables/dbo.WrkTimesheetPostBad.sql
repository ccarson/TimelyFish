CREATE TABLE [dbo].[WrkTimesheetPostBad] (
    [DocNbr]      CHAR (10)  NOT NULL,
    [LineNbr]     CHAR (11)  NOT NULL,
    [MsgId]       INT        NOT NULL,
    [MsgParms]    CHAR (100) NOT NULL,
    [MsgTable]    CHAR (20)  NOT NULL,
    [UserID]      CHAR (47)  NOT NULL,
    [UserAddress] CHAR (47)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [WrkTimesheetPostBad0] PRIMARY KEY CLUSTERED ([DocNbr] ASC, [UserAddress] ASC, [UserID] ASC, [MsgId] ASC)
);

