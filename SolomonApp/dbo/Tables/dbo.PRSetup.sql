﻿CREATE TABLE [dbo].[PRSetup] (
    [APBatDflt]         CHAR (1)      CONSTRAINT [DF_PRSetup_APBatDflt] DEFAULT (' ') NOT NULL,
    [APUpd]             SMALLINT      CONSTRAINT [DF_PRSetup_APUpd] DEFAULT ((0)) NOT NULL,
    [APUpdRel]          SMALLINT      CONSTRAINT [DF_PRSetup_APUpdRel] DEFAULT ((0)) NOT NULL,
    [Box17LIncl]        SMALLINT      CONSTRAINT [DF_PRSetup_Box17LIncl] DEFAULT ((0)) NOT NULL,
    [Box17LLmt]         FLOAT (53)    CONSTRAINT [DF_PRSetup_Box17LLmt] DEFAULT ((0)) NOT NULL,
    [Box22Incl]         SMALLINT      CONSTRAINT [DF_PRSetup_Box22Incl] DEFAULT ((0)) NOT NULL,
    [CalYr]             CHAR (4)      CONSTRAINT [DF_PRSetup_CalYr] DEFAULT (' ') NOT NULL,
    [ChkAcct]           CHAR (10)     CONSTRAINT [DF_PRSetup_ChkAcct] DEFAULT (' ') NOT NULL,
    [ChkSub]            CHAR (24)     CONSTRAINT [DF_PRSetup_ChkSub] DEFAULT (' ') NOT NULL,
    [ComputerManuf]     CHAR (8)      CONSTRAINT [DF_PRSetup_ComputerManuf] DEFAULT (' ') NOT NULL,
    [CovGrpNbr]         SMALLINT      CONSTRAINT [DF_PRSetup_CovGrpNbr] DEFAULT ((0)) NOT NULL,
    [CpnyID]            CHAR (10)     CONSTRAINT [DF_PRSetup_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME CONSTRAINT [DF_PRSetup_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      CONSTRAINT [DF_PRSetup_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]         CHAR (10)     CONSTRAINT [DF_PRSetup_Crtd_User] DEFAULT (' ') NOT NULL,
    [CurrCalYr]         CHAR (4)      CONSTRAINT [DF_PRSetup_CurrCalYr] DEFAULT (' ') NOT NULL,
    [DirectDeposit]     CHAR (1)      CONSTRAINT [DF_PRSetup_DirectDeposit] DEFAULT (' ') NOT NULL,
    [DPRateMult]        SMALLINT      CONSTRAINT [DF_PRSetup_DPRateMult] DEFAULT ((0)) NOT NULL,
    [DPUnits]           SMALLINT      CONSTRAINT [DF_PRSetup_DPUnits] DEFAULT ((0)) NOT NULL,
    [EmpIdToGL]         SMALLINT      CONSTRAINT [DF_PRSetup_EmpIdToGL] DEFAULT ((0)) NOT NULL,
    [EmpmtType]         CHAR (1)      CONSTRAINT [DF_PRSetup_EmpmtType] DEFAULT (' ') NOT NULL,
    [EmpRGP]            CHAR (6)      CONSTRAINT [DF_PRSetup_EmpRGP] DEFAULT (' ') NOT NULL,
    [EstabPlanNbr]      CHAR (4)      CONSTRAINT [DF_PRSetup_EstabPlanNbr] DEFAULT (' ') NOT NULL,
    [ExpAcct]           CHAR (10)     CONSTRAINT [DF_PRSetup_ExpAcct] DEFAULT (' ') NOT NULL,
    [ExpSub]            CHAR (24)     CONSTRAINT [DF_PRSetup_ExpSub] DEFAULT (' ') NOT NULL,
    [FedHrlyMinWage]    FLOAT (53)    CONSTRAINT [DF_PRSetup_FedHrlyMinWage] DEFAULT ((0)) NOT NULL,
    [GLPostOpt]         CHAR (1)      CONSTRAINT [DF_PRSetup_GLPostOpt] DEFAULT (' ') NOT NULL,
    [Init]              SMALLINT      CONSTRAINT [DF_PRSetup_Init] DEFAULT ((0)) NOT NULL,
    [LastBatNbr]        CHAR (10)     CONSTRAINT [DF_PRSetup_LastBatNbr] DEFAULT (' ') NOT NULL,
    [LmtLiab]           SMALLINT      CONSTRAINT [DF_PRSetup_LmtLiab] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME CONSTRAINT [DF_PRSetup_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      CONSTRAINT [DF_PRSetup_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]         CHAR (10)     CONSTRAINT [DF_PRSetup_LUpd_User] DEFAULT (' ') NOT NULL,
    [MagW2]             SMALLINT      CONSTRAINT [DF_PRSetup_MagW2] DEFAULT ((0)) NOT NULL,
    [MaxDec]            SMALLINT      CONSTRAINT [DF_PRSetup_MaxDec] DEFAULT ((0)) NOT NULL,
    [MCTimeEntry]       SMALLINT      CONSTRAINT [DF_PRSetup_MCTimeEntry] DEFAULT ((0)) NOT NULL,
    [MinWageMultiplier] FLOAT (53)    CONSTRAINT [DF_PRSetup_MinWageMultiplier] DEFAULT ((0)) NOT NULL,
    [MultChkPay]        CHAR (1)      CONSTRAINT [DF_PRSetup_MultChkPay] DEFAULT (' ') NOT NULL,
    [NextCheckDate]     SMALLDATETIME CONSTRAINT [DF_PRSetup_NextCheckDate] DEFAULT ('01/01/1900') NOT NULL,
    [NoteId]            INT           CONSTRAINT [DF_PRSetup_NoteId] DEFAULT ((0)) NOT NULL,
    [PercentDispEarn]   FLOAT (53)    CONSTRAINT [DF_PRSetup_PercentDispEarn] DEFAULT ((0)) NOT NULL,
    [PerNbr]            CHAR (6)      CONSTRAINT [DF_PRSetup_PerNbr] DEFAULT (' ') NOT NULL,
    [PerRetStubDtl]     SMALLINT      CONSTRAINT [DF_PRSetup_PerRetStubDtl] DEFAULT ((0)) NOT NULL,
    [ProjCostUpdFlag]   CHAR (1)      CONSTRAINT [DF_PRSetup_ProjCostUpdFlag] DEFAULT (' ') NOT NULL,
    [RetChkRcncl]       SMALLINT      CONSTRAINT [DF_PRSetup_RetChkRcncl] DEFAULT ((0)) NOT NULL,
    [RetDeductHist]     SMALLINT      CONSTRAINT [DF_PRSetup_RetDeductHist] DEFAULT ((0)) NOT NULL,
    [RetPerTimesheets]  SMALLINT      CONSTRAINT [DF_PRSetup_RetPerTimesheets] DEFAULT ((0)) NOT NULL,
    [RetQtrChecks]      SMALLINT      CONSTRAINT [DF_PRSetup_RetQtrChecks] DEFAULT ((0)) NOT NULL,
    [RetYrsEmpHist]     SMALLINT      CONSTRAINT [DF_PRSetup_RetYrsEmpHist] DEFAULT ((0)) NOT NULL,
    [S4Future01]        CHAR (30)     CONSTRAINT [DF_PRSetup_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]        CHAR (30)     CONSTRAINT [DF_PRSetup_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]        FLOAT (53)    CONSTRAINT [DF_PRSetup_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]        FLOAT (53)    CONSTRAINT [DF_PRSetup_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]        FLOAT (53)    CONSTRAINT [DF_PRSetup_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]        FLOAT (53)    CONSTRAINT [DF_PRSetup_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]        SMALLDATETIME CONSTRAINT [DF_PRSetup_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]        SMALLDATETIME CONSTRAINT [DF_PRSetup_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]        INT           CONSTRAINT [DF_PRSetup_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]        INT           CONSTRAINT [DF_PRSetup_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]        CHAR (10)     CONSTRAINT [DF_PRSetup_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]        CHAR (10)     CONSTRAINT [DF_PRSetup_S4Future12] DEFAULT (' ') NOT NULL,
    [SalaryChkSeq]      CHAR (2)      CONSTRAINT [DF_PRSetup_SalaryChkSeq] DEFAULT (' ') NOT NULL,
    [SetupId]           CHAR (2)      CONSTRAINT [DF_PRSetup_SetupId] DEFAULT (' ') NOT NULL,
    [StateLocNbr]       CHAR (9)      CONSTRAINT [DF_PRSetup_StateLocNbr] DEFAULT (' ') NOT NULL,
    [UnitNbr]           CHAR (3)      CONSTRAINT [DF_PRSetup_UnitNbr] DEFAULT (' ') NOT NULL,
    [User1]             CHAR (30)     CONSTRAINT [DF_PRSetup_User1] DEFAULT (' ') NOT NULL,
    [User2]             CHAR (30)     CONSTRAINT [DF_PRSetup_User2] DEFAULT (' ') NOT NULL,
    [User3]             FLOAT (53)    CONSTRAINT [DF_PRSetup_User3] DEFAULT ((0)) NOT NULL,
    [User4]             FLOAT (53)    CONSTRAINT [DF_PRSetup_User4] DEFAULT ((0)) NOT NULL,
    [User5]             CHAR (10)     CONSTRAINT [DF_PRSetup_User5] DEFAULT (' ') NOT NULL,
    [User6]             CHAR (10)     CONSTRAINT [DF_PRSetup_User6] DEFAULT (' ') NOT NULL,
    [User7]             SMALLDATETIME CONSTRAINT [DF_PRSetup_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]             SMALLDATETIME CONSTRAINT [DF_PRSetup_User8] DEFAULT ('01/01/1900') NOT NULL,
    [WCExpAcct]         CHAR (10)     CONSTRAINT [DF_PRSetup_WCExpAcct] DEFAULT (' ') NOT NULL,
    [WCLibAcct]         CHAR (10)     CONSTRAINT [DF_PRSetup_WCLibAcct] DEFAULT (' ') NOT NULL,
    [WCLibSub]          CHAR (24)     CONSTRAINT [DF_PRSetup_WCLibSub] DEFAULT (' ') NOT NULL,
    [WCPostToGL]        SMALLINT      CONSTRAINT [DF_PRSetup_WCPostToGL] DEFAULT ((0)) NOT NULL,
    [WCSubSrc]          CHAR (1)      CONSTRAINT [DF_PRSetup_WCSubSrc] DEFAULT (' ') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [PRSetup0] PRIMARY KEY CLUSTERED ([SetupId] ASC) WITH (FILLFACTOR = 90)
);

