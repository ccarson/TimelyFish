CREATE TABLE [dbo].[Customer] (
    [AccrRevAcct]       CHAR (10)     DEFAULT (' ') NOT NULL,
    [AccrRevSub]        CHAR (24)     DEFAULT (' ') NOT NULL,
    [AcctNbr]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [Addr1]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [Addr2]             CHAR (60)     DEFAULT (' ') NOT NULL,
    [AgentID]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [ApplFinChrg]       SMALLINT      DEFAULT ((0)) NOT NULL,
    [ArAcct]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [ArSub]             CHAR (24)     DEFAULT (' ') NOT NULL,
    [Attn]              CHAR (30)     DEFAULT (' ') NOT NULL,
    [AutoApply]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [BankID]            CHAR (10)     DEFAULT (' ') NOT NULL,
    [BillAddr1]         CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillAddr2]         CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillAttn]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillCity]          CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillCountry]       CHAR (3)      DEFAULT (' ') NOT NULL,
    [BillFax]           CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillName]          CHAR (60)     DEFAULT (' ') NOT NULL,
    [BillPhone]         CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillSalut]         CHAR (30)     DEFAULT (' ') NOT NULL,
    [BillState]         CHAR (3)      DEFAULT (' ') NOT NULL,
    [BillThruProject]   SMALLINT      DEFAULT ((0)) NOT NULL,
    [BillZip]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [CardExpDate]       SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [CardHldrName]      CHAR (60)     DEFAULT (' ') NOT NULL,
    [CardNbr]           CHAR (20)     DEFAULT (' ') NOT NULL,
    [CardType]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [City]              CHAR (30)     DEFAULT (' ') NOT NULL,
    [ClassId]           CHAR (6)      DEFAULT (' ') NOT NULL,
    [ConsolInv]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [Country]           CHAR (3)      DEFAULT (' ') NOT NULL,
    [CrLmt]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),(0)),(0)))) NOT NULL,
    [Crtd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [Crtd_User]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [CuryId]            CHAR (4)      DEFAULT (' ') NOT NULL,
    [CuryPrcLvlRtTp]    CHAR (6)      DEFAULT (' ') NOT NULL,
    [CuryRateType]      CHAR (6)      DEFAULT (' ') NOT NULL,
    [CustFillPriority]  SMALLINT      DEFAULT ((0)) NOT NULL,
    [CustId]            CHAR (15)     DEFAULT (' ') NOT NULL,
    [DfltShipToId]      CHAR (10)     DEFAULT (' ') NOT NULL,
    [DocPublishingFlag] CHAR (1)      DEFAULT ('Y') NOT NULL,
    [DunMsg]            SMALLINT      DEFAULT ((0)) NOT NULL,
    [EMailAddr]         CHAR (80)     DEFAULT (' ') NOT NULL,
    [Fax]               CHAR (30)     DEFAULT (' ') NOT NULL,
    [InvtSubst]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [LanguageID]        CHAR (4)      DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]         CHAR (8)      DEFAULT (' ') NOT NULL,
    [LUpd_User]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [Name]              CHAR (60)     DEFAULT (' ') NOT NULL,
    [NoteId]            INT           DEFAULT ((0)) NOT NULL,
    [OneDraft]          SMALLINT      DEFAULT ((0)) NOT NULL,
    [PerNbr]            CHAR (6)      DEFAULT (' ') NOT NULL,
    [Phone]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [PmtMethod]         CHAR (1)      DEFAULT (' ') NOT NULL,
    [PrcLvlId]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [PrePayAcct]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [PrePaySub]         CHAR (24)     DEFAULT (' ') NOT NULL,
    [PriceClassID]      CHAR (6)      DEFAULT (' ') NOT NULL,
    [PrtMCStmt]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [PrtStmt]           SMALLINT      DEFAULT ((0)) NOT NULL,
    [S4Future01]        CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future02]        CHAR (30)     DEFAULT (' ') NOT NULL,
    [S4Future03]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future04]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future05]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future06]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [S4Future07]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]        SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]        INT           DEFAULT ((0)) NOT NULL,
    [S4Future10]        INT           DEFAULT ((0)) NOT NULL,
    [S4Future11]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [S4Future12]        CHAR (10)     DEFAULT (' ') NOT NULL,
    [Salut]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [SetupDate]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [ShipCmplt]         SMALLINT      DEFAULT ((0)) NOT NULL,
    [ShipPctAct]        CHAR (1)      DEFAULT (' ') NOT NULL,
    [ShipPctMax]        FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SICCode1]          CHAR (4)      DEFAULT (' ') NOT NULL,
    [SICCode2]          CHAR (4)      DEFAULT (' ') NOT NULL,
    [SingleInvoice]     SMALLINT      DEFAULT ((0)) NOT NULL,
    [SlsAcct]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [SlsperId]          CHAR (10)     DEFAULT (' ') NOT NULL,
    [SlsSub]            CHAR (24)     DEFAULT (' ') NOT NULL,
    [State]             CHAR (3)      DEFAULT (' ') NOT NULL,
    [Status]            CHAR (1)      DEFAULT (' ') NOT NULL,
    [StmtCycleId]       CHAR (2)      DEFAULT (' ') NOT NULL,
    [StmtType]          CHAR (1)      DEFAULT (' ') NOT NULL,
    [TaxDflt]           CHAR (1)      DEFAULT (' ') NOT NULL,
    [TaxExemptNbr]      CHAR (15)     DEFAULT (' ') NOT NULL,
    [TaxID00]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID01]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID02]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxID03]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [TaxLocId]          CHAR (15)     DEFAULT (' ') NOT NULL,
    [TaxRegNbr]         CHAR (15)     DEFAULT (' ') NOT NULL,
    [Terms]             CHAR (2)      DEFAULT (' ') NOT NULL,
    [Territory]         CHAR (10)     DEFAULT (' ') NOT NULL,
    [TradeDisc]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User1]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User2]             CHAR (30)     DEFAULT (' ') NOT NULL,
    [User3]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]             FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User6]             CHAR (10)     DEFAULT (' ') NOT NULL,
    [User7]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]             SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [Zip]               CHAR (10)     DEFAULT (' ') NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [Customer0] PRIMARY KEY CLUSTERED ([CustId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Customer1]
    ON [dbo].[Customer]([Name] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer2]
    ON [dbo].[Customer]([Status] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer3]
    ON [dbo].[Customer]([StmtCycleId] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer4]
    ON [dbo].[Customer]([ArAcct] ASC, [ArSub] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer5]
    ON [dbo].[Customer]([ClassId] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer6]
    ON [dbo].[Customer]([Phone] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Customer7]
    ON [dbo].[Customer]([Zip] ASC, [CustId] ASC) WITH (FILLFACTOR = 90);

