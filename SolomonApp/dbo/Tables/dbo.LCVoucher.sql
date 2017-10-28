CREATE TABLE [dbo].[LCVoucher] (
    [AddlCost]       FLOAT (53)    CONSTRAINT [DF_LCVoucher_AddlCost] DEFAULT ((0)) NOT NULL,
    [AddlCostPct]    FLOAT (53)    CONSTRAINT [DF_LCVoucher_AddlCostPct] DEFAULT ((0)) NOT NULL,
    [AllocMethod]    CHAR (1)      CONSTRAINT [DF_LCVoucher_AllocMethod] DEFAULT (' ') NOT NULL,
    [APBatNbr]       CHAR (10)     CONSTRAINT [DF_LCVoucher_APBatNbr] DEFAULT (' ') NOT NULL,
    [APLineID]       INT           CONSTRAINT [DF_LCVoucher_APLineID] DEFAULT ((0)) NOT NULL,
    [APLineRef]      CHAR (5)      CONSTRAINT [DF_LCVoucher_APLineRef] DEFAULT (' ') NOT NULL,
    [APRefNbr]       CHAR (10)     CONSTRAINT [DF_LCVoucher_APRefNbr] DEFAULT (' ') NOT NULL,
    [BMICuryID]      CHAR (4)      CONSTRAINT [DF_LCVoucher_BMICuryID] DEFAULT (' ') NOT NULL,
    [BMIEffDate]     SMALLDATETIME CONSTRAINT [DF_LCVoucher_BMIEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [BMIExtCost]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_BMIExtCost] DEFAULT ((0)) NOT NULL,
    [BMIMultDiv]     CHAR (1)      CONSTRAINT [DF_LCVoucher_BMIMultDiv] DEFAULT (' ') NOT NULL,
    [BMIRate]        FLOAT (53)    CONSTRAINT [DF_LCVoucher_BMIRate] DEFAULT ((0)) NOT NULL,
    [BMIRtTp]        CHAR (6)      CONSTRAINT [DF_LCVoucher_BMIRtTp] DEFAULT (' ') NOT NULL,
    [BMITranAmt]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_BMITranAmt] DEFAULT ((0)) NOT NULL,
    [BMIUnitCost]    FLOAT (53)    CONSTRAINT [DF_LCVoucher_BMIUnitCost] DEFAULT ((0)) NOT NULL,
    [BMIUnitPrice]   FLOAT (53)    CONSTRAINT [DF_LCVoucher_BMIUnitPrice] DEFAULT ((0)) NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_LCVoucher_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_LCVoucher_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_LCVoucher_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_LCVoucher_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryAddlCost]   FLOAT (53)    CONSTRAINT [DF_LCVoucher_CuryAddlCost] DEFAULT ((0)) NOT NULL,
    [CuryExtCost]    FLOAT (53)    CONSTRAINT [DF_LCVoucher_CuryExtCost] DEFAULT ((0)) NOT NULL,
    [CuryID]         CHAR (4)      CONSTRAINT [DF_LCVoucher_CuryID] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]    CHAR (1)      CONSTRAINT [DF_LCVoucher_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryRate]       FLOAT (53)    CONSTRAINT [DF_LCVoucher_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryTranAmt]    FLOAT (53)    CONSTRAINT [DF_LCVoucher_CuryTranAmt] DEFAULT ((0)) NOT NULL,
    [CuryUnitCost]   FLOAT (53)    CONSTRAINT [DF_LCVoucher_CuryUnitCost] DEFAULT ((0)) NOT NULL,
    [ExtCost]        FLOAT (53)    CONSTRAINT [DF_LCVoucher_ExtCost] DEFAULT ((0)) NOT NULL,
    [ExtVolume]      FLOAT (53)    CONSTRAINT [DF_LCVoucher_ExtVolume] DEFAULT ((0)) NOT NULL,
    [ExtWeight]      FLOAT (53)    CONSTRAINT [DF_LCVoucher_ExtWeight] DEFAULT ((0)) NOT NULL,
    [InvAdjBatNbr]   CHAR (10)     CONSTRAINT [DF_LCVoucher_InvAdjBatNbr] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_LCVoucher_InvtID] DEFAULT (' ') NOT NULL,
    [LCCode]         CHAR (10)     CONSTRAINT [DF_LCVoucher_LCCode] DEFAULT (' ') NOT NULL,
    [LineNbr]        SMALLINT      CONSTRAINT [DF_LCVoucher_LineNbr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_LCVoucher_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_LCVoucher_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_LCVoucher_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]         INT           CONSTRAINT [DF_LCVoucher_NoteID] DEFAULT ((0)) NOT NULL,
    [OrigSiteID]     CHAR (10)     CONSTRAINT [DF_LCVoucher_OrigSiteID] DEFAULT (' ') NOT NULL,
    [PONbr]          CHAR (10)     CONSTRAINT [DF_LCVoucher_PONbr] DEFAULT (' ') NOT NULL,
    [RcptDate]       SMALLDATETIME CONSTRAINT [DF_LCVoucher_RcptDate] DEFAULT ('01/01/1900') NOT NULL,
    [RcptNbr]        CHAR (10)     CONSTRAINT [DF_LCVoucher_RcptNbr] DEFAULT (' ') NOT NULL,
    [RcptQty]        FLOAT (53)    CONSTRAINT [DF_LCVoucher_RcptQty] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_LCVoucher_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_LCVoucher_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_LCVoucher_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_LCVoucher_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_LCVoucher_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_LCVoucher_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_LCVoucher_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_LCVoucher_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_LCVoucher_S4Future12] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_LCVoucher_SpecificCostID] DEFAULT (' ') NOT NULL,
    [TranStatus]     CHAR (1)      CONSTRAINT [DF_LCVoucher_TranStatus] DEFAULT (' ') NOT NULL,
    [UnitDescr]      CHAR (6)      CONSTRAINT [DF_LCVoucher_UnitDescr] DEFAULT (' ') NOT NULL,
    [User1]          CHAR (30)     CONSTRAINT [DF_LCVoucher_User1] DEFAULT (' ') NOT NULL,
    [User10]         SMALLDATETIME CONSTRAINT [DF_LCVoucher_User10] DEFAULT ('01/01/1900') NOT NULL,
    [User2]          CHAR (30)     CONSTRAINT [DF_LCVoucher_User2] DEFAULT (' ') NOT NULL,
    [User3]          CHAR (30)     CONSTRAINT [DF_LCVoucher_User3] DEFAULT (' ') NOT NULL,
    [User4]          CHAR (30)     CONSTRAINT [DF_LCVoucher_User4] DEFAULT (' ') NOT NULL,
    [User5]          FLOAT (53)    CONSTRAINT [DF_LCVoucher_User5] DEFAULT ((0)) NOT NULL,
    [User6]          FLOAT (53)    CONSTRAINT [DF_LCVoucher_User6] DEFAULT ((0)) NOT NULL,
    [User7]          CHAR (10)     CONSTRAINT [DF_LCVoucher_User7] DEFAULT (' ') NOT NULL,
    [User8]          CHAR (10)     CONSTRAINT [DF_LCVoucher_User8] DEFAULT (' ') NOT NULL,
    [User9]          SMALLDATETIME CONSTRAINT [DF_LCVoucher_User9] DEFAULT ('01/01/1900') NOT NULL,
    [UserSpecPct]    FLOAT (53)    CONSTRAINT [DF_LCVoucher_UserSpecPct] DEFAULT ((0)) NOT NULL,
    [ValMthd]        CHAR (1)      CONSTRAINT [DF_LCVoucher_ValMthd] DEFAULT (' ') NOT NULL,
    [VendID]         CHAR (15)     CONSTRAINT [DF_LCVoucher_VendID] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [LCVoucher0] PRIMARY KEY CLUSTERED ([APBatNbr] ASC, [APRefNbr] ASC, [APLineRef] ASC, [RcptNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [LCVoucher1]
    ON [dbo].[LCVoucher]([CpnyID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCVoucher2]
    ON [dbo].[LCVoucher]([CpnyID] ASC, [APBatNbr] ASC, [APRefNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCVoucher3]
    ON [dbo].[LCVoucher]([TranStatus] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCVoucher4]
    ON [dbo].[LCVoucher]([APLineRef] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCVoucher5]
    ON [dbo].[LCVoucher]([APRefNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [LCVoucher6]
    ON [dbo].[LCVoucher]([VendID] ASC) WITH (FILLFACTOR = 90);

