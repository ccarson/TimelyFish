CREATE TABLE [dbo].[WrkSumInquiry] (
    [Acct]     CHAR (10)  NOT NULL,
    [AcctYear] CHAR (4)   NOT NULL,
    [Actual]   FLOAT (53) NOT NULL,
    [Budget]   FLOAT (53) NOT NULL,
    [Descr]    CHAR (30)  NOT NULL,
    [Period]   CHAR (2)   NOT NULL,
    [RI_ID]    SMALLINT   NOT NULL,
    [Sub]      CHAR (24)  NOT NULL,
    [tstamp]   ROWVERSION NOT NULL
);

