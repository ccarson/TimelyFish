CREATE TABLE [dbo].[SlsPrc] (
    [CatalogNbr]    CHAR (15)     CONSTRAINT [DF_SlsPrc_CatalogNbr] DEFAULT (' ') NOT NULL,
    [ContractNbr]   CHAR (25)     CONSTRAINT [DF_SlsPrc_ContractNbr] DEFAULT (' ') NOT NULL,
    [ContractQty]   FLOAT (53)    CONSTRAINT [DF_SlsPrc_ContractQty] DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_SlsPrc_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_SlsPrc_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_SlsPrc_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryID]        CHAR (4)      CONSTRAINT [DF_SlsPrc_CuryID] DEFAULT (' ') NOT NULL,
    [CustClassID]   CHAR (6)      CONSTRAINT [DF_SlsPrc_CustClassID] DEFAULT (' ') NOT NULL,
    [CustID]        CHAR (15)     CONSTRAINT [DF_SlsPrc_CustID] DEFAULT (' ') NOT NULL,
    [DetCntr]       CHAR (5)      CONSTRAINT [DF_SlsPrc_DetCntr] DEFAULT (' ') NOT NULL,
    [DiscPrcMthd]   CHAR (1)      CONSTRAINT [DF_SlsPrc_DiscPrcMthd] DEFAULT (' ') NOT NULL,
    [DiscPrcTyp]    CHAR (1)      CONSTRAINT [DF_SlsPrc_DiscPrcTyp] DEFAULT (' ') NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_SlsPrc_InvtID] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_SlsPrc_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_SlsPrc_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_SlsPrc_LUpd_User] DEFAULT (' ') NOT NULL,
    [MaxQty]        FLOAT (53)    CONSTRAINT [DF_SlsPrc_MaxQty] DEFAULT ((0)) NOT NULL,
    [MinQty]        FLOAT (53)    CONSTRAINT [DF_SlsPrc_MinQty] DEFAULT ((0)) NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_SlsPrc_NoteID] DEFAULT ((0)) NOT NULL,
    [PrcLvlID]      CHAR (10)     CONSTRAINT [DF_SlsPrc_PrcLvlID] DEFAULT (' ') NOT NULL,
    [PriceCat]      CHAR (2)      CONSTRAINT [DF_SlsPrc_PriceCat] DEFAULT (' ') NOT NULL,
    [PriceClassID]  CHAR (6)      CONSTRAINT [DF_SlsPrc_PriceClassID] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_SlsPrc_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_SlsPrc_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_SlsPrc_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_SlsPrc_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_SlsPrc_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_SlsPrc_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_SlsPrc_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_SlsPrc_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_SlsPrc_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_SlsPrc_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_SlsPrc_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_SlsPrc_S4Future12] DEFAULT (' ') NOT NULL,
    [SelectFld1]    CHAR (30)     CONSTRAINT [DF_SlsPrc_SelectFld1] DEFAULT (' ') NOT NULL,
    [SelectFld2]    CHAR (30)     CONSTRAINT [DF_SlsPrc_SelectFld2] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_SlsPrc_SiteID] DEFAULT (' ') NOT NULL,
    [SlsPrcID]      CHAR (15)     CONSTRAINT [DF_SlsPrc_SlsPrcID] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_SlsPrc_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_SlsPrc_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_SlsPrc_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_SlsPrc_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_SlsPrc_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_SlsPrc_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_SlsPrc_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_SlsPrc_User8] DEFAULT ('01/01/1900') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [SlsPrc0] PRIMARY KEY CLUSTERED ([SlsPrcID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [SlsPrc1]
    ON [dbo].[SlsPrc]([PriceCat] ASC, [DiscPrcTyp] ASC, [SelectFld1] ASC, [SelectFld2] ASC, [CuryID] ASC, [SiteID] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SlsPrc2]
    ON [dbo].[SlsPrc]([CatalogNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [SlsPrc3]
    ON [dbo].[SlsPrc]([PriceCat] ASC, [SelectFld1] ASC, [SelectFld2] ASC, [CuryID] ASC, [SiteID] ASC, [CatalogNbr] ASC) WITH (FILLFACTOR = 90);

