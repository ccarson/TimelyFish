CREATE TABLE [dbo].[SFWork2] (
    [CnvFact]        FLOAT (53)    CONSTRAINT [DF_SFWork2_CnvFact] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SFWork2_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [CuryID]         CHAR (4)      CONSTRAINT [DF_SFWork2_CuryID] DEFAULT (' ') NOT NULL,
    [CustClassDescr] CHAR (30)     CONSTRAINT [DF_SFWork2_CustClassDescr] DEFAULT (' ') NOT NULL,
    [CustClassID]    CHAR (6)      CONSTRAINT [DF_SFWork2_CustClassID] DEFAULT (' ') NOT NULL,
    [DetRef]         CHAR (5)      CONSTRAINT [DF_SFWork2_DetRef] DEFAULT (' ') NOT NULL,
    [DiscPct]        FLOAT (53)    CONSTRAINT [DF_SFWork2_DiscPct] DEFAULT ((0)) NOT NULL,
    [DiscPctS4]      FLOAT (53)    CONSTRAINT [DF_SFWork2_DiscPctS4] DEFAULT ((0)) NOT NULL,
    [DiscPrcMthd]    CHAR (1)      CONSTRAINT [DF_SFWork2_DiscPrcMthd] DEFAULT (' ') NOT NULL,
    [DiscPrice]      FLOAT (53)    CONSTRAINT [DF_SFWork2_DiscPrice] DEFAULT ((0)) NOT NULL,
    [EndDate]        SMALLDATETIME CONSTRAINT [DF_SFWork2_EndDate] DEFAULT ('01/01/1900') NOT NULL,
    [Exclude]        SMALLINT      CONSTRAINT [DF_SFWork2_Exclude] DEFAULT ((0)) NOT NULL,
    [ID]             INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ItemCost]       FLOAT (53)    CONSTRAINT [DF_SFWork2_ItemCost] DEFAULT ((0)) NOT NULL,
    [MaxQty]         FLOAT (53)    CONSTRAINT [DF_SFWork2_MaxQty] DEFAULT ((0)) NOT NULL,
    [MinQty]         FLOAT (53)    CONSTRAINT [DF_SFWork2_MinQty] DEFAULT ((0)) NOT NULL,
    [MultDiv]        CHAR (1)      CONSTRAINT [DF_SFWork2_MultDiv] DEFAULT (' ') NOT NULL,
    [PriceBasis]     FLOAT (53)    CONSTRAINT [DF_SFWork2_PriceBasis] DEFAULT ((0)) NOT NULL,
    [PriceChgFlag]   SMALLINT      CONSTRAINT [DF_SFWork2_PriceChgFlag] DEFAULT ((0)) NOT NULL,
    [QtySold]        FLOAT (53)    CONSTRAINT [DF_SFWork2_QtySold] DEFAULT ((0)) NOT NULL,
    [RvsdDiscPct]    FLOAT (53)    CONSTRAINT [DF_SFWork2_RvsdDiscPct] DEFAULT ((0)) NOT NULL,
    [RvsdDiscPrice]  FLOAT (53)    CONSTRAINT [DF_SFWork2_RvsdDiscPrice] DEFAULT ((0)) NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SFWork2_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SFWork2_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SFWork2_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SFWork2_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SFWork2_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SFWork2_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SFWork2_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SFWork2_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SFWork2_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SFWork2_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SFWork2_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SFWork2_S4Future12] DEFAULT (' ') NOT NULL,
    [SlsPrcID]       CHAR (15)     CONSTRAINT [DF_SFWork2_SlsPrcID] DEFAULT (' ') NOT NULL,
    [SlsUnit]        CHAR (6)      CONSTRAINT [DF_SFWork2_SlsUnit] DEFAULT (' ') NOT NULL,
    [SPID]           SMALLINT      CONSTRAINT [DF_SFWork2_SPID] DEFAULT ((0)) NOT NULL,
    [StartDate]      SMALLDATETIME CONSTRAINT [DF_SFWork2_StartDate] DEFAULT ('01/01/1900') NOT NULL,
    [UOM]            CHAR (6)      CONSTRAINT [DF_SFWork2_UOM] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [SFWork21]
    ON [dbo].[SFWork2]([SPID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SFWork20]
    ON [dbo].[SFWork2]([ID] ASC) WITH (FILLFACTOR = 90);

