﻿CREATE TABLE [dbo].[Deduction] (
    [AllId]           CHAR (4)      NOT NULL,
    [AllocDed]        SMALLINT      NOT NULL,
    [ArrgDedAllow]    SMALLINT      NOT NULL,
    [BaseId]          CHAR (10)     NOT NULL,
    [BaseType]        CHAR (1)      NOT NULL,
    [BoxLet]          CHAR (2)      NOT NULL,
    [BoxNbr]          CHAR (3)      NOT NULL,
    [BwkIntrv]        SMALLINT      NOT NULL,
    [BwkMaxAmtPerPd]  FLOAT (53)    NOT NULL,
    [BwkMaxPerYr]     SMALLINT      NOT NULL,
    [BwkMinAmtPerPd]  FLOAT (53)    NOT NULL,
    [BwkPaySeq]       CHAR (1)      NOT NULL,
    [BwkSchedule]     CHAR (1)      NOT NULL,
    [BwkStrtPer]      SMALLINT      NOT NULL,
    [CalcMthd]        CHAR (2)      NOT NULL,
    [CalYr]           CHAR (4)      NOT NULL,
    [ChkSeq]          CHAR (2)      NOT NULL,
    [ChkSeqAll]       CHAR (1)      NOT NULL,
    [CpnyID]          CHAR (10)     NOT NULL,
    [CpnyTaxNbr]      CHAR (20)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [DedGrpID]        CHAR (10)     NOT NULL,
    [DedId]           CHAR (10)     NOT NULL,
    [DedSequence]     SMALLINT      NOT NULL,
    [DedType]         CHAR (1)      NOT NULL,
    [DefrdComp]       SMALLINT      NOT NULL,
    [Descr]           CHAR (30)     NOT NULL,
    [EmpleeDed]       SMALLINT      NOT NULL,
    [ExpAcct]         CHAR (10)     NOT NULL,
    [ExpSub]          CHAR (24)     NOT NULL,
    [ExpSubSrc]       CHAR (1)      NOT NULL,
    [FxdPctRate]      FLOAT (53)    NOT NULL,
    [HeadId]          CHAR (4)      NOT NULL,
    [IncInDispEarn]   SMALLINT      NOT NULL,
    [JointId]         CHAR (4)      NOT NULL,
    [Lifetime]        SMALLINT      NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [MarriedId]       CHAR (4)      NOT NULL,
    [MaxApplyFlg]     CHAR (1)      NOT NULL,
    [MaxDedAmt]       FLOAT (53)    NOT NULL,
    [MaxSubjWage]     FLOAT (53)    NOT NULL,
    [MinSubjWage]     FLOAT (53)    NOT NULL,
    [MonIntrv]        SMALLINT      NOT NULL,
    [MonMaxAmtPerPd]  FLOAT (53)    NOT NULL,
    [MonMaxPerYr]     SMALLINT      NOT NULL,
    [MonMinAmtPerPd]  FLOAT (53)    NOT NULL,
    [MonStrtPer]      SMALLINT      NOT NULL,
    [NoteId]          INT           NOT NULL,
    [OmitRptEarn]     SMALLINT      NOT NULL,
    [Pension]         SMALLINT      NOT NULL,
    [PrntEmplr]       SMALLINT      NOT NULL,
    [PrntZeroDed]     SMALLINT      NOT NULL,
    [ProjBillable]    CHAR (1)      NOT NULL,
    [ProjImpact]      CHAR (1)      NOT NULL,
    [RoundToDollars]  SMALLINT      NOT NULL,
    [S4Future01]      CHAR (30)     NOT NULL,
    [S4Future02]      CHAR (30)     NOT NULL,
    [S4Future03]      FLOAT (53)    NOT NULL,
    [S4Future04]      FLOAT (53)    NOT NULL,
    [S4Future05]      FLOAT (53)    NOT NULL,
    [S4Future06]      FLOAT (53)    NOT NULL,
    [S4Future07]      SMALLDATETIME NOT NULL,
    [S4Future08]      SMALLDATETIME NOT NULL,
    [S4Future09]      INT           NOT NULL,
    [S4Future10]      INT           NOT NULL,
    [S4Future11]      CHAR (10)     NOT NULL,
    [S4Future12]      CHAR (10)     NOT NULL,
    [Section457]      SMALLINT      NOT NULL,
    [SingleId]        CHAR (4)      NOT NULL,
    [SmonIntrv]       SMALLINT      NOT NULL,
    [SmonMaxAmtPerPd] FLOAT (53)    NOT NULL,
    [SmonMaxPerYr]    SMALLINT      NOT NULL,
    [SmonMinAmtPerPd] FLOAT (53)    NOT NULL,
    [SmonPaySeq]      CHAR (1)      NOT NULL,
    [SmonSchedule]    CHAR (1)      NOT NULL,
    [SmonStrtPer]     SMALLINT      NOT NULL,
    [State]           CHAR (3)      NOT NULL,
    [SubjAllEarnings] SMALLINT      NOT NULL,
    [SubjAllLaborCls] SMALLINT      NOT NULL,
    [SubjAllWrkloc]   SMALLINT      NOT NULL,
    [Union_Cd]        CHAR (10)     NOT NULL,
    [UpdProject]      CHAR (1)      NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [VendId]          CHAR (15)     NOT NULL,
    [WklyIntrv]       SMALLINT      NOT NULL,
    [WklyMaxAmtPerPd] FLOAT (53)    NOT NULL,
    [WklyMaxPerYr]    SMALLINT      NOT NULL,
    [WklyMinAmtPerPd] FLOAT (53)    NOT NULL,
    [WklyStrtPer]     SMALLINT      NOT NULL,
    [WkPaySeq]        CHAR (1)      NOT NULL,
    [WkSchedule]      CHAR (1)      NOT NULL,
    [WthldAcct]       CHAR (10)     NOT NULL,
    [WthldSub]        CHAR (24)     NOT NULL,
    [WthldSubSrc]     CHAR (1)      NOT NULL,
    [YearMaxOpt]      SMALLINT      NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [Deduction0] PRIMARY KEY CLUSTERED ([DedId] ASC, [CalYr] ASC)
);
