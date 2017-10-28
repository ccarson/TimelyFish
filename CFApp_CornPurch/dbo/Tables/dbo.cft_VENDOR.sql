CREATE TABLE [dbo].[cft_VENDOR] (
    [Addr1]            CHAR (30)     NOT NULL,
    [Addr2]            CHAR (30)     NOT NULL,
    [APAcct]           CHAR (10)     NOT NULL,
    [APSub]            CHAR (24)     NOT NULL,
    [Attn]             CHAR (30)     NOT NULL,
    [BkupWthld]        SMALLINT      NOT NULL,
    [City]             CHAR (30)     NOT NULL,
    [ClassID]          CHAR (10)     NOT NULL,
    [ContTwc1099]      SMALLINT      NOT NULL,
    [Country]          CHAR (3)      NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Curr1099Yr]       CHAR (4)      NOT NULL,
    [CuryId]           CHAR (4)      NOT NULL,
    [CuryRateType]     CHAR (6)      NOT NULL,
    [DfltBox]          CHAR (2)      NOT NULL,
    [DfltOrdFromId]    CHAR (10)     NOT NULL,
    [DfltPurchaseType] CHAR (2)      NOT NULL,
    [DirectDeposit]    CHAR (1)      NOT NULL,
    [EMailAddr]        CHAR (30)     NOT NULL,
    [ExpAcct]          CHAR (10)     NOT NULL,
    [ExpSub]           CHAR (24)     NOT NULL,
    [Fax]              CHAR (30)     NOT NULL,
    [LCCode]           CHAR (10)     DEFAULT (' ') NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (10)     NOT NULL,
    [MultiChk]         SMALLINT      NOT NULL,
    [Name]             CHAR (30)     NOT NULL,
    [Next1099Yr]       CHAR (4)      NOT NULL,
    [NoteID]           INT           NOT NULL,
    [PayDateDflt]      CHAR (1)      NOT NULL,
    [PerNbr]           CHAR (6)      NOT NULL,
    [Phone]            CHAR (30)     NOT NULL,
    [PmtMethod]        CHAR (1)      NOT NULL,
    [PPayAcct]         CHAR (10)     NOT NULL,
    [PPaySub]          CHAR (24)     NOT NULL,
    [RcptPctAct]       CHAR (1)      NOT NULL,
    [RcptPctMax]       FLOAT (53)    NOT NULL,
    [RcptPctMin]       FLOAT (53)    NOT NULL,
    [RemitAddr1]       CHAR (30)     NOT NULL,
    [RemitAddr2]       CHAR (30)     NOT NULL,
    [RemitAttn]        CHAR (30)     NOT NULL,
    [RemitCity]        CHAR (30)     NOT NULL,
    [RemitCountry]     CHAR (3)      NOT NULL,
    [RemitFax]         CHAR (30)     NOT NULL,
    [RemitName]        CHAR (30)     NOT NULL,
    [RemitPhone]       CHAR (30)     NOT NULL,
    [RemitSalut]       CHAR (30)     NOT NULL,
    [RemitState]       CHAR (3)      NOT NULL,
    [RemitZip]         CHAR (10)     NOT NULL,
    [S4Future01]       CHAR (30)     NOT NULL,
    [S4Future02]       CHAR (30)     NOT NULL,
    [S4Future03]       FLOAT (53)    NOT NULL,
    [S4Future04]       FLOAT (53)    NOT NULL,
    [S4Future05]       FLOAT (53)    NOT NULL,
    [S4Future06]       FLOAT (53)    NOT NULL,
    [S4Future07]       SMALLDATETIME NOT NULL,
    [S4Future08]       SMALLDATETIME NOT NULL,
    [S4Future09]       INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [Salut]            CHAR (30)     NOT NULL,
    [State]            CHAR (3)      NOT NULL,
    [Status]           CHAR (1)      NOT NULL,
    [TaxDflt]          CHAR (1)      NOT NULL,
    [TaxId00]          CHAR (10)     NOT NULL,
    [TaxId01]          CHAR (10)     NOT NULL,
    [TaxId02]          CHAR (10)     NOT NULL,
    [TaxId03]          CHAR (10)     NOT NULL,
    [TaxLocId]         CHAR (15)     NOT NULL,
    [TaxPost]          CHAR (1)      NOT NULL,
    [TaxRegNbr]        CHAR (15)     NOT NULL,
    [Terms]            CHAR (2)      NOT NULL,
    [TIN]              CHAR (11)     NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [Vend1099]         SMALLINT      NOT NULL,
    [VendId]           CHAR (15)     NOT NULL,
    [Zip]              CHAR (10)     NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [Vendor0] PRIMARY KEY CLUSTERED ([VendId] ASC) WITH (FILLFACTOR = 90)
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[cft_VENDOR] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[cft_VENDOR] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[cft_VENDOR] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[cft_VENDOR] TO [07718158D19D4f5f9D23B55DBF5DF1]
    AS [dbo];

