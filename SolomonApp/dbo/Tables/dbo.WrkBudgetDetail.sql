CREATE TABLE [dbo].[WrkBudgetDetail] (
    [Acct]                    CHAR (10)  NOT NULL,
    [AcctDescr]               CHAR (30)  NOT NULL,
    [AcctType]                CHAR (2)   NOT NULL,
    [BasisActualCpnyID]       CHAR (10)  NOT NULL,
    [BasisActualLedger]       CHAR (10)  NOT NULL,
    [BasisActualPTDBal00]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal01]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal02]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal03]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal04]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal05]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal06]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal07]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal08]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal09]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal10]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal11]     FLOAT (53) NOT NULL,
    [BasisActualPTDBal12]     FLOAT (53) NOT NULL,
    [BasisActualYear]         CHAR (4)   NOT NULL,
    [BasisActualYTDBal00]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal01]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal02]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal03]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal04]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal05]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal06]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal07]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal08]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal09]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal10]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal11]     FLOAT (53) NOT NULL,
    [BasisActualYTDBal12]     FLOAT (53) NOT NULL,
    [BasisBudgetAnnBdgt]      FLOAT (53) NOT NULL,
    [BasisBudgetCpnyID]       CHAR (10)  NOT NULL,
    [BasisBudgetLedger]       CHAR (10)  NOT NULL,
    [BasisBudgetPTDBal00]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal01]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal02]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal03]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal04]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal05]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal06]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal07]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal08]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal09]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal10]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal11]     FLOAT (53) NOT NULL,
    [BasisBudgetPTDBal12]     FLOAT (53) NOT NULL,
    [BasisBudgetYear]         CHAR (4)   NOT NULL,
    [BasisBudgetYTDBal00]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal01]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal02]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal03]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal04]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal05]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal06]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal07]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal08]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal09]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal10]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal11]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDBal12]     FLOAT (53) NOT NULL,
    [BasisBudgetYTDEstimated] FLOAT (53) NOT NULL,
    [BdgtSegmentGroup]        CHAR (24)  NOT NULL,
    [BudgetAnnBdgt]           FLOAT (53) NOT NULL,
    [BudgetLedger]            CHAR (10)  NOT NULL,
    [BudgetPTDBal00]          FLOAT (53) NOT NULL,
    [BudgetPTDBal01]          FLOAT (53) NOT NULL,
    [BudgetPTDBal02]          FLOAT (53) NOT NULL,
    [BudgetPTDBal03]          FLOAT (53) NOT NULL,
    [BudgetPTDBal04]          FLOAT (53) NOT NULL,
    [BudgetPTDBal05]          FLOAT (53) NOT NULL,
    [BudgetPTDBal06]          FLOAT (53) NOT NULL,
    [BudgetPTDBal07]          FLOAT (53) NOT NULL,
    [BudgetPTDBal08]          FLOAT (53) NOT NULL,
    [BudgetPTDBal09]          FLOAT (53) NOT NULL,
    [BudgetPTDBal10]          FLOAT (53) NOT NULL,
    [BudgetPTDBal11]          FLOAT (53) NOT NULL,
    [BudgetPTDBal12]          FLOAT (53) NOT NULL,
    [BudgetYear]              CHAR (4)   NOT NULL,
    [BudgetYTDBal00]          FLOAT (53) NOT NULL,
    [BudgetYTDBal01]          FLOAT (53) NOT NULL,
    [BudgetYTDBal02]          FLOAT (53) NOT NULL,
    [BudgetYTDBal03]          FLOAT (53) NOT NULL,
    [BudgetYTDBal04]          FLOAT (53) NOT NULL,
    [BudgetYTDBal05]          FLOAT (53) NOT NULL,
    [BudgetYTDBal06]          FLOAT (53) NOT NULL,
    [BudgetYTDBal07]          FLOAT (53) NOT NULL,
    [BudgetYTDBal08]          FLOAT (53) NOT NULL,
    [BudgetYTDBal09]          FLOAT (53) NOT NULL,
    [BudgetYTDBal10]          FLOAT (53) NOT NULL,
    [BudgetYTDBal11]          FLOAT (53) NOT NULL,
    [BudgetYTDBal12]          FLOAT (53) NOT NULL,
    [BudgetYTDEstimated]      FLOAT (53) NOT NULL,
    [CpnyID]                  CHAR (10)  NOT NULL,
    [RI_ID]                   SMALLINT   NOT NULL,
    [Sub]                     CHAR (24)  NOT NULL,
    [TStamp]                  ROWVERSION NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [WrkBudgetDetail0]
    ON [dbo].[WrkBudgetDetail]([Acct] ASC, [Sub] ASC);


GO
CREATE NONCLUSTERED INDEX [WrkBudgetDetail1]
    ON [dbo].[WrkBudgetDetail]([BudgetLedger] ASC, [BudgetYear] ASC);


GO
CREATE NONCLUSTERED INDEX [WrkBudgetDetail2]
    ON [dbo].[WrkBudgetDetail]([BdgtSegmentGroup] ASC);


GO
CREATE NONCLUSTERED INDEX [WrkBudgetDetail3]
    ON [dbo].[WrkBudgetDetail]([BdgtSegmentGroup] ASC, [Acct] ASC, [Sub] ASC);

