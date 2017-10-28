CREATE TABLE [dbo].[WrkIChk] (
    [Custid] CHAR (15)  NOT NULL,
    [Cpnyid] CHAR (10)  NOT NULL,
    [MsgID]  INT        NOT NULL,
    [OldBal] FLOAT (53) NOT NULL,
    [NewBal] FLOAT (53) NOT NULL,
    [AdjBal] FLOAT (53) NOT NULL,
    [Other]  CHAR (10)  NOT NULL,
    [tstamp] ROWVERSION NOT NULL
);

