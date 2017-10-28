CREATE TABLE [dbo].[AbraWCTemp] (
    [Amount]       FLOAT (53)    NOT NULL,
    [BatNbr]       CHAR (10)     NOT NULL,
    [ChaDate]      SMALLDATETIME NOT NULL,
    [ChargeDate]   SMALLDATETIME NOT NULL,
    [ChkDate]      SMALLDATETIME NOT NULL,
    [ChkNumber]    CHAR (7)      NOT NULL,
    [Company]      CHAR (3)      NOT NULL,
    [EarnCode]     CHAR (4)      NOT NULL,
    [EmpNo]        CHAR (9)      NOT NULL,
    [ExpAcct]      CHAR (30)     NOT NULL,
    [Hours]        FLOAT (53)    NOT NULL,
    [LineId]       SMALLINT      NOT NULL,
    [OrgLevel1]    CHAR (12)     NOT NULL,
    [OrgLevel2]    CHAR (12)     NOT NULL,
    [OrgLevel3]    CHAR (12)     NOT NULL,
    [OrgLevel4]    CHAR (12)     NOT NULL,
    [WorkCode]     CHAR (4)      NOT NULL,
    [WorkComp]     CHAR (6)      NOT NULL,
    [WorkCompRate] FLOAT (53)    NULL,
    [tstamp]       ROWVERSION    NULL,
    CONSTRAINT [AbraWCTemp0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [LineId] ASC) WITH (FILLFACTOR = 90)
);

