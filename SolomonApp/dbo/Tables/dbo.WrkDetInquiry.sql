CREATE TABLE [dbo].[WrkDetInquiry] (
    [Acct]          CHAR (10)     NOT NULL,
    [Amount]        FLOAT (53)    NOT NULL,
    [BatchNbr]      CHAR (10)     NOT NULL,
    [ExtRef]        CHAR (15)     NOT NULL,
    [FiscYr]        CHAR (6)      NOT NULL,
    [Journal]       CHAR (3)      NOT NULL,
    [Module]        CHAR (2)      NOT NULL,
    [PerBegBalance] FLOAT (53)    NOT NULL,
    [PerEndBalance] FLOAT (53)    NOT NULL,
    [PerFrom]       CHAR (6)      NOT NULL,
    [PerPost]       CHAR (6)      NOT NULL,
    [PerThru]       CHAR (6)      NOT NULL,
    [Ref]           CHAR (10)     NOT NULL,
    [RI_ID]         SMALLINT      NOT NULL,
    [RptNbr]        CHAR (10)     NOT NULL,
    [Sub]           CHAR (24)     NOT NULL,
    [TranDate]      SMALLDATETIME NOT NULL,
    [TranDesc]      CHAR (30)     NOT NULL,
    [VendorName]    CHAR (60)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);

