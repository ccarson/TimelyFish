﻿CREATE TABLE [dbo].[InvcDoc] (
    [BackFillOpt]    SMALLINT      NOT NULL,
    [BatNbr]         CHAR (10)     NOT NULL,
    [BillAddr1]      CHAR (60)     NOT NULL,
    [BillAddr2]      CHAR (60)     NOT NULL,
    [BillAttn]       CHAR (30)     NOT NULL,
    [BillCity]       CHAR (30)     NOT NULL,
    [BillCntryDesc]  CHAR (10)     NOT NULL,
    [BillCountry]    CHAR (3)      NOT NULL,
    [BillName]       CHAR (60)     NOT NULL,
    [BillState]      CHAR (2)      NOT NULL,
    [BillZip]        CHAR (10)     NOT NULL,
    [BlktNbr]        CHAR (10)     NOT NULL,
    [CmmnPct]        FLOAT (53)    NOT NULL,
    [COGSAcct]       CHAR (10)     NOT NULL,
    [COGSSub]        CHAR (24)     NOT NULL,
    [CpnyID]         CHAR (10)     NOT NULL,
    [CreditChk]      SMALLINT      NOT NULL,
    [Crtd_DateTime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [CuryEffDate]    SMALLDATETIME NOT NULL,
    [CuryFreight]    FLOAT (53)    NOT NULL,
    [CuryID]         CHAR (4)      NOT NULL,
    [CuryInvcTot]    FLOAT (53)    NOT NULL,
    [CuryMiscChrg]   FLOAT (53)    NOT NULL,
    [CuryMultDiv]    CHAR (1)      NOT NULL,
    [CuryOrdTot]     FLOAT (53)    NOT NULL,
    [CuryRate]       FLOAT (53)    NOT NULL,
    [CuryRateType]   CHAR (6)      NOT NULL,
    [CuryTaxFrt00]   FLOAT (53)    NOT NULL,
    [CuryTaxFrt01]   FLOAT (53)    NOT NULL,
    [CuryTaxFrt02]   FLOAT (53)    NOT NULL,
    [CuryTaxFrt03]   FLOAT (53)    NOT NULL,
    [CuryTaxMisc00]  FLOAT (53)    NOT NULL,
    [CuryTaxMisc01]  FLOAT (53)    NOT NULL,
    [CuryTaxMisc02]  FLOAT (53)    NOT NULL,
    [CuryTaxMisc03]  FLOAT (53)    NOT NULL,
    [CuryTaxTot00]   FLOAT (53)    NOT NULL,
    [CuryTaxTot01]   FLOAT (53)    NOT NULL,
    [CuryTaxTot02]   FLOAT (53)    NOT NULL,
    [CuryTaxTot03]   FLOAT (53)    NOT NULL,
    [CuryTotOrdDisc] FLOAT (53)    NOT NULL,
    [CuryTotTax]     FLOAT (53)    NOT NULL,
    [CuryTotTaxOrd]  FLOAT (53)    NOT NULL,
    [CuryTradeDisc]  FLOAT (53)    NOT NULL,
    [CuryTxblFrt00]  FLOAT (53)    NOT NULL,
    [CuryTxblFrt01]  FLOAT (53)    NOT NULL,
    [CuryTxblFrt02]  FLOAT (53)    NOT NULL,
    [CuryTxblFrt03]  FLOAT (53)    NOT NULL,
    [CuryTxblMisc00] FLOAT (53)    NOT NULL,
    [CuryTxblMisc01] FLOAT (53)    NOT NULL,
    [CuryTxblMisc02] FLOAT (53)    NOT NULL,
    [CuryTxblMisc03] FLOAT (53)    NOT NULL,
    [CuryTxblTot00]  FLOAT (53)    NOT NULL,
    [CuryTxblTot01]  FLOAT (53)    NOT NULL,
    [CuryTxblTot02]  FLOAT (53)    NOT NULL,
    [CuryTxblTot03]  FLOAT (53)    NOT NULL,
    [CustID]         CHAR (15)     NOT NULL,
    [CustOrdNbr]     CHAR (15)     NOT NULL,
    [DocDesc]        CHAR (30)     NOT NULL,
    [FOB]            CHAR (15)     NOT NULL,
    [Freight]        FLOAT (53)    NOT NULL,
    [InvcNbr]        CHAR (10)     NOT NULL,
    [InvcTot]        FLOAT (53)    NOT NULL,
    [InvcType]       CHAR (2)      NOT NULL,
    [InvoiceDate]    SMALLDATETIME NOT NULL,
    [LanguageID]     CHAR (4)      NOT NULL,
    [LineCntr]       SMALLINT      NOT NULL,
    [LUpd_DateTime]  SMALLDATETIME NOT NULL,
    [LUpd_Prog]      CHAR (8)      NOT NULL,
    [LUpd_User]      CHAR (10)     NOT NULL,
    [MiscChrg]       FLOAT (53)    NOT NULL,
    [NoteID]         INT           NOT NULL,
    [OrdNbr]         CHAR (10)     NOT NULL,
    [OrdTot]         FLOAT (53)    NOT NULL,
    [OurPONbr]       CHAR (10)     NOT NULL,
    [PC_Status]      CHAR (1)      NOT NULL,
    [PerClosed]      CHAR (6)      NOT NULL,
    [PerPost]        CHAR (6)      NOT NULL,
    [PriorStatus]    CHAR (1)      NOT NULL,
    [ProjectID]      CHAR (16)     NOT NULL,
    [PrtBatch]       SMALLINT      NOT NULL,
    [PrtStatus]      CHAR (1)      NOT NULL,
    [Rlsed]          SMALLINT      NOT NULL,
    [RMANbr]         CHAR (10)     NOT NULL,
    [S4Future01]     CHAR (30)     NOT NULL,
    [S4Future02]     CHAR (30)     NOT NULL,
    [S4Future03]     FLOAT (53)    NOT NULL,
    [S4Future04]     FLOAT (53)    NOT NULL,
    [S4Future05]     FLOAT (53)    NOT NULL,
    [S4Future06]     FLOAT (53)    NOT NULL,
    [S4Future07]     SMALLDATETIME NOT NULL,
    [S4Future08]     SMALLDATETIME NOT NULL,
    [S4Future09]     INT           NOT NULL,
    [S4Future10]     INT           NOT NULL,
    [S4Future11]     CHAR (10)     NOT NULL,
    [S4Future12]     CHAR (10)     NOT NULL,
    [ShipAddr1]      CHAR (60)     NOT NULL,
    [ShipAddr2]      CHAR (60)     NOT NULL,
    [ShipAttn]       CHAR (30)     NOT NULL,
    [ShipCity]       CHAR (30)     NOT NULL,
    [Shipcmplt]      SMALLINT      NOT NULL,
    [ShipCntryDesc]  CHAR (30)     NOT NULL,
    [ShipCountry]    CHAR (3)      NOT NULL,
    [ShipDate]       SMALLDATETIME NOT NULL,
    [ShipmentNbr]    SMALLINT      NOT NULL,
    [ShipName]       CHAR (60)     NOT NULL,
    [ShipperNbr]     CHAR (25)     NOT NULL,
    [ShipState]      CHAR (2)      NOT NULL,
    [ShiptoID]       CHAR (10)     NOT NULL,
    [ShipViaID]      CHAR (15)     NOT NULL,
    [ShipWght]       FLOAT (53)    NOT NULL,
    [ShipZip]        CHAR (10)     NOT NULL,
    [SlsPerID]       CHAR (10)     NOT NULL,
    [Status]         CHAR (1)      NOT NULL,
    [TaxCntr00]      SMALLINT      NOT NULL,
    [TaxCntr01]      SMALLINT      NOT NULL,
    [TaxCntr02]      SMALLINT      NOT NULL,
    [TaxCntr03]      SMALLINT      NOT NULL,
    [TaxFrt00]       FLOAT (53)    NOT NULL,
    [TaxFrt01]       FLOAT (53)    NOT NULL,
    [TaxFrt02]       FLOAT (53)    NOT NULL,
    [TaxFrt03]       FLOAT (53)    NOT NULL,
    [TaxID00]        CHAR (10)     NOT NULL,
    [TaxID01]        CHAR (10)     NOT NULL,
    [TaxID02]        CHAR (10)     NOT NULL,
    [TaxID03]        CHAR (10)     NOT NULL,
    [TaxMisc00]      FLOAT (53)    NOT NULL,
    [TaxMisc01]      FLOAT (53)    NOT NULL,
    [TaxMisc02]      FLOAT (53)    NOT NULL,
    [TaxMisc03]      FLOAT (53)    NOT NULL,
    [TaxTot00]       FLOAT (53)    NOT NULL,
    [TaxTot01]       FLOAT (53)    NOT NULL,
    [TaxTot02]       FLOAT (53)    NOT NULL,
    [TaxTot03]       FLOAT (53)    NOT NULL,
    [Terms]          CHAR (2)      NOT NULL,
    [TotOrdDisc]     FLOAT (53)    NOT NULL,
    [TotTax]         FLOAT (53)    NOT NULL,
    [TotTaxOrd]      FLOAT (53)    NOT NULL,
    [TradeDisc]      FLOAT (53)    NOT NULL,
    [TxblFrt00]      FLOAT (53)    NOT NULL,
    [TxblFrt01]      FLOAT (53)    NOT NULL,
    [TxblFrt02]      FLOAT (53)    NOT NULL,
    [TxblFrt03]      FLOAT (53)    NOT NULL,
    [TxblMisc00]     FLOAT (53)    NOT NULL,
    [TxblMisc01]     FLOAT (53)    NOT NULL,
    [TxblMisc02]     FLOAT (53)    NOT NULL,
    [TxblMisc03]     FLOAT (53)    NOT NULL,
    [TxblTot00]      FLOAT (53)    NOT NULL,
    [TxblTot01]      FLOAT (53)    NOT NULL,
    [TxblTot02]      FLOAT (53)    NOT NULL,
    [TxblTot03]      FLOAT (53)    NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [InvcDoc0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [InvcDoc1]
    ON [dbo].[InvcDoc]([BatNbr] ASC, [InvcNbr] ASC) WITH (FILLFACTOR = 90);

