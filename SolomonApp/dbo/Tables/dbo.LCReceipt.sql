CREATE TABLE [dbo].[LCReceipt] (
    [AllocMethod]   CHAR (1)      CONSTRAINT [DF_LCReceipt_AllocMethod] DEFAULT (' ') NOT NULL,
    [APRefNbr]      CHAR (10)     CONSTRAINT [DF_LCReceipt_APRefNbr] DEFAULT (' ') NOT NULL,
    [BatNbr]        CHAR (10)     CONSTRAINT [DF_LCReceipt_BatNbr] DEFAULT (' ') NOT NULL,
    [BMIExtCost]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_BMIExtCost] DEFAULT ((0)) NOT NULL,
    [BMIFlag]       SMALLINT      CONSTRAINT [DF_LCReceipt_BMIFlag] DEFAULT ((0)) NOT NULL,
    [BMIMultDiv]    CHAR (1)      CONSTRAINT [DF_LCReceipt_BMIMultDiv] DEFAULT (' ') NOT NULL,
    [BMIRate]       FLOAT (53)    CONSTRAINT [DF_LCReceipt_BMIRate] DEFAULT ((0)) NOT NULL,
    [CpnyID]        CHAR (10)     CONSTRAINT [DF_LCReceipt_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_LCReceipt_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_LCReceipt_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_LCReceipt_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryDocAmt]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_CuryDocAmt] DEFAULT ((0)) NOT NULL,
    [CuryEffDate]   SMALLDATETIME CONSTRAINT [DF_LCReceipt_CuryEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [CuryID]        CHAR (4)      CONSTRAINT [DF_LCReceipt_CuryID] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]   CHAR (1)      CONSTRAINT [DF_LCReceipt_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryRate]      FLOAT (53)    CONSTRAINT [DF_LCReceipt_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryRateType]  CHAR (6)      CONSTRAINT [DF_LCReceipt_CuryRateType] DEFAULT (' ') NOT NULL,
    [DocAmt]        FLOAT (53)    CONSTRAINT [DF_LCReceipt_DocAmt] DEFAULT ((0)) NOT NULL,
    [INBatNbr]      CHAR (10)     CONSTRAINT [DF_LCReceipt_INBatNbr] DEFAULT (' ') NOT NULL,
    [InvcDate]      SMALLDATETIME CONSTRAINT [DF_LCReceipt_InvcDate] DEFAULT ('01/01/1900') NOT NULL,
    [InvcNbr]       CHAR (15)     CONSTRAINT [DF_LCReceipt_InvcNbr] DEFAULT (' ') NOT NULL,
    [LCCode]        CHAR (10)     CONSTRAINT [DF_LCReceipt_LCCode] DEFAULT (' ') NOT NULL,
    [LineNbr]       SMALLINT      CONSTRAINT [DF_LCReceipt_LineNbr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_LCReceipt_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_LCReceipt_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_LCReceipt_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_LCReceipt_NoteID] DEFAULT ((0)) NOT NULL,
    [PerPost]       CHAR (6)      CONSTRAINT [DF_LCReceipt_PerPost] DEFAULT (' ') NOT NULL,
    [PONbr]         CHAR (10)     CONSTRAINT [DF_LCReceipt_PONbr] DEFAULT (' ') NOT NULL,
    [RcptNbr]       CHAR (10)     CONSTRAINT [DF_LCReceipt_RcptNbr] DEFAULT (' ') NOT NULL,
    [ReasonCd]      CHAR (6)      CONSTRAINT [DF_LCReceipt_ReasonCd] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_LCReceipt_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_LCReceipt_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_LCReceipt_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_LCReceipt_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_LCReceipt_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_LCReceipt_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_LCReceipt_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_LCReceipt_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_LCReceipt_S4Future12] DEFAULT (' ') NOT NULL,
    [TermsID]       CHAR (2)      CONSTRAINT [DF_LCReceipt_TermsID] DEFAULT (' ') NOT NULL,
    [TranStatus]    CHAR (1)      CONSTRAINT [DF_LCReceipt_TranStatus] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_LCReceipt_User1] DEFAULT (' ') NOT NULL,
    [User10]        SMALLDATETIME CONSTRAINT [DF_LCReceipt_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_LCReceipt_User2] DEFAULT (' ') NOT NULL,
    [User3]         CHAR (30)     CONSTRAINT [DF_LCReceipt_User3] DEFAULT (' ') NOT NULL,
    [User4]         CHAR (30)     CONSTRAINT [DF_LCReceipt_User4] DEFAULT (' ') NOT NULL,
    [User5]         FLOAT (53)    CONSTRAINT [DF_LCReceipt_User5] DEFAULT ((0)) NOT NULL,
    [User6]         FLOAT (53)    CONSTRAINT [DF_LCReceipt_User6] DEFAULT ((0)) NOT NULL,
    [User7]         CHAR (10)     CONSTRAINT [DF_LCReceipt_User7] DEFAULT (' ') NOT NULL,
    [User8]         CHAR (10)     CONSTRAINT [DF_LCReceipt_User8] DEFAULT (' ') NOT NULL,
    [User9]         SMALLDATETIME CONSTRAINT [DF_LCReceipt_User9] DEFAULT ('01/01/1900') NOT NULL,
    [UserSpecPct]   FLOAT (53)    CONSTRAINT [DF_LCReceipt_UserSpecPct] DEFAULT ((0)) NOT NULL,
    [VendID]        CHAR (15)     CONSTRAINT [DF_LCReceipt_VendID] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [LCReceipt0] PRIMARY KEY CLUSTERED ([RcptNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [LCReceipt1]
    ON [dbo].[LCReceipt]([LCCode] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCReceipt2]
    ON [dbo].[LCReceipt]([RcptNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCReceipt3]
    ON [dbo].[LCReceipt]([TranStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCReceipt4]
    ON [dbo].[LCReceipt]([LineNbr] ASC) WITH (FILLFACTOR = 90);

