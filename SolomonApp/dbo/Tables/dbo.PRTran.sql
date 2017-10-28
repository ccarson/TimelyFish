CREATE TABLE [dbo].[PRTran] (
    [Acct]             CHAR (10)     NOT NULL,
    [AcctDist]         SMALLINT      NOT NULL,
    [APBatch]          CHAR (10)     NOT NULL,
    [APLineId]         INT           NOT NULL,
    [APRefNbr]         CHAR (10)     NOT NULL,
    [ArrgAmt]          FLOAT (53)    NOT NULL,
    [BatNbr]           CHAR (10)     NOT NULL,
    [BenClassId]       CHAR (10)     NOT NULL,
    [BenId]            CHAR (10)     NOT NULL,
    [Billable]         CHAR (1)      NOT NULL,
    [CalQtr]           SMALLINT      NOT NULL,
    [CalYr]            CHAR (4)      NOT NULL,
    [CertPR]           CHAR (1)      NOT NULL,
    [ChkAcct]          CHAR (10)     NOT NULL,
    [ChkSeq]           CHAR (2)      NOT NULL,
    [ChkSub]           CHAR (24)     NOT NULL,
    [CostType]         CHAR (8)      NOT NULL,
    [CpnyID]           CHAR (10)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [DailyOpt]         CHAR (1)      NOT NULL,
    [Dist]             CHAR (1)      NOT NULL,
    [DrCr]             CHAR (1)      NOT NULL,
    [EarnDedId]        CHAR (10)     NOT NULL,
    [EmpId]            CHAR (10)     NOT NULL,
    [Excpt]            SMALLINT      NOT NULL,
    [ExtRefNbr]        CHAR (15)     NOT NULL,
    [Group_Cd]         CHAR (16)     NOT NULL,
    [HomeUnion]        CHAR (10)     NOT NULL,
    [JobRate]          FLOAT (53)    NOT NULL,
    [JrnlType]         CHAR (3)      NOT NULL,
    [Labor_Class_Cd]   CHAR (4)      NOT NULL,
    [LineId]           INT           NOT NULL,
    [LineNbr]          SMALLINT      NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [NoteId]           INT           NOT NULL,
    [Paid]             SMALLINT      NOT NULL,
    [PayPerNbr]        SMALLINT      NOT NULL,
    [PC_Status]        CHAR (1)      NOT NULL,
    [PerEnt]           CHAR (6)      NOT NULL,
    [PerPost]          CHAR (6)      NOT NULL,
    [ProjectID]        CHAR (16)     NOT NULL,
    [PW_cd]            CHAR (4)      NOT NULL,
    [Qty]              FLOAT (53)    NOT NULL,
    [RateBaseFlg]      CHAR (1)      NOT NULL,
    [RateMult]         FLOAT (53)    NOT NULL,
    [RefNbr]           CHAR (10)     NOT NULL,
    [Rlsed]            SMALLINT      NOT NULL,
    [RptEarnSubjDed]   FLOAT (53)    NOT NULL,
    [S4Future01]       CHAR (30)     NOT NULL,
    [S4Future02]       CHAR (30)     NOT NULL,
    [S4Future03]       FLOAT (53)    NOT NULL,
    [S4Future04]       FLOAT (53)    NOT NULL,
    [S4Future05]       FLOAT (53)    NOT NULL,
    [S4Future06]       FLOAT (53)    NOT NULL,
    [S4Future07]       SMALLDATETIME NOT NULL,
    [S4Future08]       SMALLDATETIME NOT NULL,
    [S4Future09]       INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [ScreenNbr]        CHAR (10)     NOT NULL,
    [Shift]            CHAR (7)      NOT NULL,
    [SS_BillableHours] FLOAT (53)    NOT NULL,
    [SS_ContractID]    CHAR (10)     NOT NULL,
    [SS_EquipmentID]   CHAR (10)     NOT NULL,
    [SS_ExtPrice]      FLOAT (53)    NOT NULL,
    [SS_InvtLocId]     CHAR (10)     NOT NULL,
    [SS_LineTypes]     CHAR (1)      NOT NULL,
    [SS_LineItemID]    CHAR (30)     NOT NULL,
    [SS_PostFlag]      CHAR (1)      NOT NULL,
    [SS_ServiceCallID] CHAR (10)     NOT NULL,
    [SS_UnitPrice]     FLOAT (53)    NOT NULL,
    [StdUnitRate]      FLOAT (53)    NOT NULL,
    [Sub]              CHAR (24)     NOT NULL,
    [TaskID]           CHAR (32)     NOT NULL,
    [TimeShtFlg]       SMALLINT      NOT NULL,
    [TimeShtNbr]       CHAR (10)     NOT NULL,
    [TranAmt]          FLOAT (53)    NOT NULL,
    [TranDate]         SMALLDATETIME NOT NULL,
    [TranDesc]         CHAR (30)     NOT NULL,
    [TranType]         CHAR (2)      NOT NULL,
    [Type_]            CHAR (2)      NOT NULL,
    [Union_Cd]         CHAR (10)     NOT NULL,
    [UnitDesc]         CHAR (6)      NOT NULL,
    [UnitPrice]        FLOAT (53)    NOT NULL,
    [UnitsDay1]        FLOAT (53)    NOT NULL,
    [UnitsDay2]        FLOAT (53)    NOT NULL,
    [UnitsDay3]        FLOAT (53)    NOT NULL,
    [UnitsDay4]        FLOAT (53)    NOT NULL,
    [UnitsDay5]        FLOAT (53)    NOT NULL,
    [UnitsDay6]        FLOAT (53)    NOT NULL,
    [UnitsDay7]        FLOAT (53)    NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [WCtoGL]           SMALLINT      NOT NULL,
    [WorkComp]         CHAR (6)      NOT NULL,
    [WorkOrder]        CHAR (16)     NOT NULL,
    [WorkType]         CHAR (2)      NOT NULL,
    [WrkLocId]         CHAR (6)      NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [PRTran0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [ChkAcct] ASC, [ChkSub] ASC, [RefNbr] ASC, [TranType] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PRTRAN_si90]
    ON [dbo].[PRTran]([BatNbr] ASC, [EmpId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran1]
    ON [dbo].[PRTran]([EmpId] ASC, [TimeShtFlg] ASC, [Rlsed] ASC, [Paid] ASC, [WrkLocId] ASC, [EarnDedId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran2]
    ON [dbo].[PRTran]([BatNbr] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran3]
    ON [dbo].[PRTran]([PerPost] ASC, [Rlsed] ASC, [ScreenNbr] ASC, [TimeShtFlg] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran4]
    ON [dbo].[PRTran]([ChkAcct] ASC, [ChkSub] ASC, [RefNbr] ASC, [TranType] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran5]
    ON [dbo].[PRTran]([APBatch] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran6]
    ON [dbo].[PRTran]([TimeShtFlg] ASC, [ProjectID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [BR_PRTran1]
    ON [dbo].[PRTran]([PerPost] ASC, [Acct] ASC, [Sub] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran_WO]
    ON [dbo].[PRTran]([PC_Status] ASC, [TimeShtFlg] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [PRTran7]
    ON [dbo].[PRTran]([EarnDedId] ASC, [CalQtr] ASC, [CalYr] ASC, [TranType] ASC, [Rlsed] ASC) WITH (FILLFACTOR = 90);

