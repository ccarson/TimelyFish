CREATE TABLE [dbo].[SOAddress] (
    [Addr1]         CHAR (60)     CONSTRAINT [DF_SOAddress_Addr1] DEFAULT (' ') NOT NULL,
    [Addr2]         CHAR (60)     CONSTRAINT [DF_SOAddress_Addr2] DEFAULT (' ') NOT NULL,
    [Attn]          CHAR (30)     CONSTRAINT [DF_SOAddress_Attn] DEFAULT (' ') NOT NULL,
    [City]          CHAR (30)     CONSTRAINT [DF_SOAddress_City] DEFAULT (' ') NOT NULL,
    [COGSAcct]      CHAR (10)     CONSTRAINT [DF_SOAddress_COGSAcct] DEFAULT (' ') NOT NULL,
    [COGSSub]       CHAR (31)     CONSTRAINT [DF_SOAddress_COGSSub] DEFAULT (' ') NOT NULL,
    [Country]       CHAR (3)      CONSTRAINT [DF_SOAddress_Country] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_SOAddress_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_SOAddress_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_SOAddress_Crtd_User] DEFAULT (' ') NOT NULL,
    [CustId]        CHAR (15)     CONSTRAINT [DF_SOAddress_CustId] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_SOAddress_Descr] DEFAULT (' ') NOT NULL,
    [DiscAcct]      CHAR (10)     CONSTRAINT [DF_SOAddress_DiscAcct] DEFAULT (' ') NOT NULL,
    [DiscSub]       CHAR (31)     CONSTRAINT [DF_SOAddress_DiscSub] DEFAULT (' ') NOT NULL,
    [EMailAddr]     CHAR (80)     CONSTRAINT [DF_SOAddress_EMailAddr] DEFAULT (' ') NOT NULL,
    [Fax]           CHAR (30)     CONSTRAINT [DF_SOAddress_Fax] DEFAULT (' ') NOT NULL,
    [FOB]           CHAR (15)     CONSTRAINT [DF_SOAddress_FOB] DEFAULT (' ') NOT NULL,
    [FrghtCode]     CHAR (4)      CONSTRAINT [DF_SOAddress_FrghtCode] DEFAULT (' ') NOT NULL,
    [FrtAcct]       CHAR (10)     CONSTRAINT [DF_SOAddress_FrtAcct] DEFAULT (' ') NOT NULL,
    [FrtSub]        CHAR (31)     CONSTRAINT [DF_SOAddress_FrtSub] DEFAULT (' ') NOT NULL,
    [FrtTermsID]    CHAR (10)     CONSTRAINT [DF_SOAddress_FrtTermsID] DEFAULT (' ') NOT NULL,
    [GeoCode]       CHAR (10)     CONSTRAINT [DF_SOAddress_GeoCode] DEFAULT (' ') NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_SOAddress_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_SOAddress_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_SOAddress_LUpd_User] DEFAULT (' ') NOT NULL,
    [MapLocation]   CHAR (10)     CONSTRAINT [DF_SOAddress_MapLocation] DEFAULT (' ') NOT NULL,
    [MiscAcct]      CHAR (10)     CONSTRAINT [DF_SOAddress_MiscAcct] DEFAULT (' ') NOT NULL,
    [MiscSub]       CHAR (31)     CONSTRAINT [DF_SOAddress_MiscSub] DEFAULT (' ') NOT NULL,
    [Name]          CHAR (60)     CONSTRAINT [DF_SOAddress_Name] DEFAULT (' ') NOT NULL,
    [NoteId]        INT           CONSTRAINT [DF_SOAddress_NoteId] DEFAULT ((0)) NOT NULL,
    [Phone]         CHAR (30)     CONSTRAINT [DF_SOAddress_Phone] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_SOAddress_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_SOAddress_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_SOAddress_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_SOAddress_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_SOAddress_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_SOAddress_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_SOAddress_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_SOAddress_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_SOAddress_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_SOAddress_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_SOAddress_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_SOAddress_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipToId]      CHAR (10)     CONSTRAINT [DF_SOAddress_ShipToId] DEFAULT (' ') NOT NULL,
    [ShipViaID]     CHAR (15)     CONSTRAINT [DF_SOAddress_ShipViaID] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_SOAddress_SiteID] DEFAULT (' ') NOT NULL,
    [SlsAcct]       CHAR (10)     CONSTRAINT [DF_SOAddress_SlsAcct] DEFAULT (' ') NOT NULL,
    [SlsPerID]      CHAR (10)     CONSTRAINT [DF_SOAddress_SlsPerID] DEFAULT (' ') NOT NULL,
    [SlsSub]        CHAR (31)     CONSTRAINT [DF_SOAddress_SlsSub] DEFAULT (' ') NOT NULL,
    [State]         CHAR (3)      CONSTRAINT [DF_SOAddress_State] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (1)      CONSTRAINT [DF_SOAddress_Status] DEFAULT (' ') NOT NULL,
    [TaxId00]       CHAR (10)     CONSTRAINT [DF_SOAddress_TaxId00] DEFAULT (' ') NOT NULL,
    [TaxId01]       CHAR (10)     CONSTRAINT [DF_SOAddress_TaxId01] DEFAULT (' ') NOT NULL,
    [TaxId02]       CHAR (10)     CONSTRAINT [DF_SOAddress_TaxId02] DEFAULT (' ') NOT NULL,
    [TaxId03]       CHAR (10)     CONSTRAINT [DF_SOAddress_TaxId03] DEFAULT (' ') NOT NULL,
    [TaxLocId]      CHAR (15)     CONSTRAINT [DF_SOAddress_TaxLocId] DEFAULT (' ') NOT NULL,
    [TaxRegNbr]     CHAR (15)     CONSTRAINT [DF_SOAddress_TaxRegNbr] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_SOAddress_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_SOAddress_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_SOAddress_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_SOAddress_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_SOAddress_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_SOAddress_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_SOAddress_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_SOAddress_User8] DEFAULT ('01/01/1900') NOT NULL,
    [Zip]           CHAR (10)     CONSTRAINT [DF_SOAddress_Zip] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [soaddress0] PRIMARY KEY CLUSTERED ([CustId] ASC, [ShipToId] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [soaddress1]
    ON [dbo].[SOAddress]([ShipToId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_4]
    ON [dbo].[SOAddress]([Addr1] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_5]
    ON [dbo].[SOAddress]([Name] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_6]
    ON [dbo].[SOAddress]([Descr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_7]
    ON [dbo].[SOAddress]([Attn] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_8]
    ON [dbo].[SOAddress]([Addr2] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_9]
    ON [dbo].[SOAddress]([City] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_10]
    ON [dbo].[SOAddress]([Zip] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [sm_SOAddress_11]
    ON [dbo].[SOAddress]([Phone] ASC) WITH (FILLFACTOR = 90);

