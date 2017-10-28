CREATE TABLE [dbo].[SFWork1] (
    [CatalogNbr]     CHAR (15)     CONSTRAINT [DF_SFWork1_CatalogNbr] DEFAULT (' ') NOT NULL,
    [CnvFact]        FLOAT (53)    CONSTRAINT [DF_SFWork1_CnvFact] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME CONSTRAINT [DF_SFWork1_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [CuryID]         CHAR (4)      CONSTRAINT [DF_SFWork1_CuryID] DEFAULT (' ') NOT NULL,
    [CustClassDescr] CHAR (30)     CONSTRAINT [DF_SFWork1_CustClassDescr] DEFAULT (' ') NOT NULL,
    [CustClassID]    CHAR (6)      CONSTRAINT [DF_SFWork1_CustClassID] DEFAULT (' ') NOT NULL,
    [DetCntr]        CHAR (5)      CONSTRAINT [DF_SFWork1_DetCntr] DEFAULT (' ') NOT NULL,
    [DiscPrcMthd]    CHAR (1)      CONSTRAINT [DF_SFWork1_DiscPrcMthd] DEFAULT (' ') NOT NULL,
    [DiscPrcTyp]     CHAR (1)      CONSTRAINT [DF_SFWork1_DiscPrcTyp] DEFAULT (' ') NOT NULL,
    [ID]             INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [ItemCost]       FLOAT (53)    CONSTRAINT [DF_SFWork1_ItemCost] DEFAULT ((0)) NOT NULL,
    [MaxQty]         FLOAT (53)    CONSTRAINT [DF_SFWork1_MaxQty] DEFAULT ((0)) NOT NULL,
    [MinQty]         FLOAT (53)    CONSTRAINT [DF_SFWork1_MinQty] DEFAULT ((0)) NOT NULL,
    [MultDiv]        CHAR (1)      CONSTRAINT [DF_SFWork1_MultDiv] DEFAULT (' ') NOT NULL,
    [PriceBasis]     FLOAT (53)    CONSTRAINT [DF_SFWork1_PriceBasis] DEFAULT ((0)) NOT NULL,
    [PriceCat]       CHAR (2)      CONSTRAINT [DF_SFWork1_PriceCat] DEFAULT (' ') NOT NULL,
    [S4Future01]     CHAR (30)     CONSTRAINT [DF_SFWork1_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]     CHAR (30)     CONSTRAINT [DF_SFWork1_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]     FLOAT (53)    CONSTRAINT [DF_SFWork1_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]     FLOAT (53)    CONSTRAINT [DF_SFWork1_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]     FLOAT (53)    CONSTRAINT [DF_SFWork1_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]     FLOAT (53)    CONSTRAINT [DF_SFWork1_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]     SMALLDATETIME CONSTRAINT [DF_SFWork1_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]     SMALLDATETIME CONSTRAINT [DF_SFWork1_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]     INT           CONSTRAINT [DF_SFWork1_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]     INT           CONSTRAINT [DF_SFWork1_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]     CHAR (10)     CONSTRAINT [DF_SFWork1_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]     CHAR (10)     CONSTRAINT [DF_SFWork1_S4Future12] DEFAULT (' ') NOT NULL,
    [SlsPrcID]       CHAR (15)     CONSTRAINT [DF_SFWork1_SlsPrcID] DEFAULT (' ') NOT NULL,
    [SPID]           SMALLINT      CONSTRAINT [DF_SFWork1_SPID] DEFAULT ((0)) NOT NULL,
    [UOM]            CHAR (6)      CONSTRAINT [DF_SFWork1_UOM] DEFAULT (' ') NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL
);


GO
CREATE CLUSTERED INDEX [SFWork11]
    ON [dbo].[SFWork1]([SPID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SFWork10]
    ON [dbo].[SFWork1]([ID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SFWork12]
    ON [dbo].[SFWork1]([UOM] ASC) WITH (FILLFACTOR = 90);

