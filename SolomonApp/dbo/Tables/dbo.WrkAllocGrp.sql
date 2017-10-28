CREATE TABLE [dbo].[WrkAllocGrp] (
    [Acct]        CHAR (10)  NOT NULL,
    [CBAcct]      CHAR (10)  NOT NULL,
    [CBCpnyID]    CHAR (10)  NOT NULL,
    [CBSub]       CHAR (24)  NOT NULL,
    [CpnyID]      CHAR (10)  NOT NULL,
    [GrpId]       CHAR (6)   NOT NULL,
    [LDLSType]    CHAR (1)   NOT NULL,
    [LmtDestFact] FLOAT (53) NOT NULL,
    [RI_ID]       INT        NOT NULL,
    [Sub]         CHAR (24)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [WrkAllocGrp0] PRIMARY KEY CLUSTERED ([GrpId] ASC, [LDLSType] ASC, [CpnyID] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90)
);

