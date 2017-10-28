CREATE TABLE [dbo].[IN10990_Check] (
    [BatNbr]         CHAR (10)     CONSTRAINT [DF_IN10990_Check_BatNbr] DEFAULT (' ') NOT NULL,
    [BMITotCost]     FLOAT (53)    CONSTRAINT [DF_IN10990_Check_BMITotCost] DEFAULT ((0)) NOT NULL,
    [CpnyID]         CHAR (10)     CONSTRAINT [DF_IN10990_Check_CpnyID] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_IN10990_Check_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]      CHAR (8)      CONSTRAINT [DF_IN10990_Check_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]      CHAR (10)     CONSTRAINT [DF_IN10990_Check_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]    CHAR (1)      CONSTRAINT [DF_IN10990_Check_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [InvtID]         CHAR (30)     CONSTRAINT [DF_IN10990_Check_InvtID] DEFAULT (' ') NOT NULL,
    [LayerType]      CHAR (1)      CONSTRAINT [DF_IN10990_Check_LayerType] DEFAULT (' ') NOT NULL,
    [LineRef]        CHAR (5)      CONSTRAINT [DF_IN10990_Check_LineRef] DEFAULT (' ') NOT NULL,
    [LotSerNbr]      CHAR (25)     CONSTRAINT [DF_IN10990_Check_LotSerNbr] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME CONSTRAINT [DF_IN10990_Check_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]      CHAR (8)      CONSTRAINT [DF_IN10990_Check_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]      CHAR (10)     CONSTRAINT [DF_IN10990_Check_LUpd_User] DEFAULT (' ') NOT NULL,
    [Qty]            FLOAT (53)    CONSTRAINT [DF_IN10990_Check_Qty] DEFAULT ((0)) NOT NULL,
    [Rate]           FLOAT (53)    CONSTRAINT [DF_IN10990_Check_Rate] DEFAULT ((0)) NOT NULL,
    [RcptDate]       SMALLDATETIME CONSTRAINT [DF_IN10990_Check_RcptDate] DEFAULT ('01/01/1900') NOT NULL,
    [RcptNbr]        CHAR (15)     CONSTRAINT [DF_IN10990_Check_RcptNbr] DEFAULT (' ') NOT NULL,
    [RefNbr]         CHAR (15)     CONSTRAINT [DF_IN10990_Check_RefNbr] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_IN10990_Check_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_IN10990_Check_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_IN10990_Check_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_IN10990_Check_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_IN10990_Check_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_IN10990_Check_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_IN10990_Check_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_IN10990_Check_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_IN10990_Check_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_IN10990_Check_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_IN10990_Check_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_IN10990_Check_S4Future12] DEFAULT (' ') NOT NULL,
    [SiteID]         CHAR (10)     CONSTRAINT [DF_IN10990_Check_SiteID] DEFAULT (' ') NOT NULL,
    [SpecificCostID] CHAR (25)     CONSTRAINT [DF_IN10990_Check_SpecificCostID] DEFAULT (' ') NOT NULL,
    [TotCost]        FLOAT (53)    CONSTRAINT [DF_IN10990_Check_TotCost] DEFAULT ((0)) NOT NULL,
    [TranDate]       SMALLDATETIME CONSTRAINT [DF_IN10990_Check_TranDate] DEFAULT ('01/01/1900') NOT NULL,
    [TranDesc]       CHAR (30)     CONSTRAINT [DF_IN10990_Check_TranDesc] DEFAULT (' ') NOT NULL,
    [TranType]       CHAR (2)      CONSTRAINT [DF_IN10990_Check_TranType] DEFAULT (' ') NOT NULL,
    [UnitCost]       FLOAT (53)    CONSTRAINT [DF_IN10990_Check_UnitCost] DEFAULT ((0)) NOT NULL,
    [ValMthd]        CHAR (1)      CONSTRAINT [DF_IN10990_Check_ValMthd] DEFAULT (' ') NOT NULL,
    [WhseLoc]        CHAR (10)     CONSTRAINT [DF_IN10990_Check_WhseLoc] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IN10990_Check0]
    ON [dbo].[IN10990_Check]([SiteID] ASC, [InvtID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_Check1]
    ON [dbo].[IN10990_Check]([InvtID] ASC, [SiteID] ASC, [LayerType] ASC, [SpecificCostID] ASC, [RcptNbr] ASC, [RcptDate] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_Check2]
    ON [dbo].[IN10990_Check]([InvtID] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [IN10990_Check3]
    ON [dbo].[IN10990_Check]([InvtID] ASC, [LotSerNbr] ASC, [SiteID] ASC, [WhseLoc] ASC) WITH (FILLFACTOR = 90);

