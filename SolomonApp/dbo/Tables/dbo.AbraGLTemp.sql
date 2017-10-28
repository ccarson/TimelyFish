CREATE TABLE [dbo].[AbraGLTemp] (
    [AcctNumber] CHAR (20)     NOT NULL,
    [BatNbr]     CHAR (10)     NOT NULL,
    [ChaDate]    SMALLDATETIME NOT NULL,
    [ChkDate]    SMALLDATETIME NOT NULL,
    [Company]    CHAR (10)     NOT NULL,
    [Credit]     FLOAT (53)    NOT NULL,
    [Debit]      FLOAT (53)    NOT NULL,
    [EmpNo]      CHAR (10)     NOT NULL,
    [GLOrg1]     CHAR (10)     NOT NULL,
    [GLOrg2]     CHAR (10)     NOT NULL,
    [GLOrg3]     CHAR (10)     NOT NULL,
    [GLOrg4]     CHAR (10)     NOT NULL,
    [LineId]     SMALLINT      NOT NULL,
    [OrgLevel1]  CHAR (15)     NOT NULL,
    [OrgLevel2]  CHAR (15)     NOT NULL,
    [OrgLevel3]  CHAR (15)     NOT NULL,
    [OrgLevel4]  CHAR (15)     NOT NULL,
    [tstamp]     ROWVERSION    NULL,
    CONSTRAINT [AbraGLTemp0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [LineId] ASC) WITH (FILLFACTOR = 90)
);

