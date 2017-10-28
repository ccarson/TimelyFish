CREATE TABLE [dbo].[WrkFSTriBal] (
    [Acct]      CHAR (10)  NOT NULL,
    [AcctType]  CHAR (2)   NOT NULL,
    [AdjgCrAmt] FLOAT (53) NOT NULL,
    [AdjgDrAmt] FLOAT (53) NOT NULL,
    [BegBal]    FLOAT (53) NOT NULL,
    [Descr]     CHAR (30)  NOT NULL,
    [EndBal]    FLOAT (53) NOT NULL,
    [PtdBal]    FLOAT (53) NOT NULL,
    [RefNbr]    CHAR (10)  NOT NULL,
    [RI_ID]     SMALLINT   NOT NULL,
    [Sub]       CHAR (24)  NOT NULL,
    [tstamp]    ROWVERSION NOT NULL
);

