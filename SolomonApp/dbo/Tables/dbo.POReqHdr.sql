CREATE TABLE [dbo].[POReqHdr] (
    [Addr1]            CHAR (60)     CONSTRAINT [DF_POReqHdr_Addr1] DEFAULT (' ') NOT NULL,
    [Addr2]            CHAR (60)     CONSTRAINT [DF_POReqHdr_Addr2] DEFAULT (' ') NOT NULL,
    [AppvLevObt]       CHAR (2)      CONSTRAINT [DF_POReqHdr_AppvLevObt] DEFAULT (' ') NOT NULL,
    [AppvLevReq]       CHAR (2)      CONSTRAINT [DF_POReqHdr_AppvLevReq] DEFAULT (' ') NOT NULL,
    [AppvProjectID]    CHAR (16)     CONSTRAINT [DF_POReqHdr_AppvProjectID] DEFAULT (' ') NOT NULL,
    [AppvRouting]      CHAR (1)      CONSTRAINT [DF_POReqHdr_AppvRouting] DEFAULT (' ') NOT NULL,
    [Attn]             CHAR (30)     CONSTRAINT [DF_POReqHdr_Attn] DEFAULT (' ') NOT NULL,
    [BillAddr1]        CHAR (60)     CONSTRAINT [DF_POReqHdr_BillAddr1] DEFAULT (' ') NOT NULL,
    [BillAddr2]        CHAR (60)     CONSTRAINT [DF_POReqHdr_BillAddr2] DEFAULT (' ') NOT NULL,
    [BillAttn]         CHAR (30)     CONSTRAINT [DF_POReqHdr_BillAttn] DEFAULT (' ') NOT NULL,
    [BillCity]         CHAR (30)     CONSTRAINT [DF_POReqHdr_BillCity] DEFAULT (' ') NOT NULL,
    [BillCountry]      CHAR (3)      CONSTRAINT [DF_POReqHdr_BillCountry] DEFAULT (' ') NOT NULL,
    [BillEmail]        CHAR (80)     CONSTRAINT [DF_POReqHdr_BillEmail] DEFAULT (' ') NOT NULL,
    [BillFax]          CHAR (30)     CONSTRAINT [DF_POReqHdr_BillFax] DEFAULT (' ') NOT NULL,
    [BillName]         CHAR (60)     CONSTRAINT [DF_POReqHdr_BillName] DEFAULT (' ') NOT NULL,
    [BillPhone]        CHAR (30)     CONSTRAINT [DF_POReqHdr_BillPhone] DEFAULT (' ') NOT NULL,
    [BillState]        CHAR (3)      CONSTRAINT [DF_POReqHdr_BillState] DEFAULT (' ') NOT NULL,
    [BillZip]          CHAR (10)     CONSTRAINT [DF_POReqHdr_BillZip] DEFAULT (' ') NOT NULL,
    [BlktExpDate]      SMALLDATETIME CONSTRAINT [DF_POReqHdr_BlktExpDate] DEFAULT ('01/01/1900') NOT NULL,
    [BlktNbr]          CHAR (10)     CONSTRAINT [DF_POReqHdr_BlktNbr] DEFAULT (' ') NOT NULL,
    [Buyer]            CHAR (10)     CONSTRAINT [DF_POReqHdr_Buyer] DEFAULT (' ') NOT NULL,
    [CertCompl]        SMALLINT      CONSTRAINT [DF_POReqHdr_CertCompl] DEFAULT ((0)) NOT NULL,
    [City]             CHAR (30)     CONSTRAINT [DF_POReqHdr_City] DEFAULT (' ') NOT NULL,
    [ConfirmTo]        CHAR (10)     CONSTRAINT [DF_POReqHdr_ConfirmTo] DEFAULT (' ') NOT NULL,
    [COPrinted]        SMALLINT      CONSTRAINT [DF_POReqHdr_COPrinted] DEFAULT ((0)) NOT NULL,
    [Country]          CHAR (3)      CONSTRAINT [DF_POReqHdr_Country] DEFAULT (' ') NOT NULL,
    [CpnyID]           CHAR (10)     CONSTRAINT [DF_POReqHdr_CpnyID] DEFAULT (' ') NOT NULL,
    [CreateDate]       SMALLDATETIME CONSTRAINT [DF_POReqHdr_CreateDate] DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME CONSTRAINT [DF_POReqHdr_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]        CHAR (8)      CONSTRAINT [DF_POReqHdr_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]        CHAR (10)     CONSTRAINT [DF_POReqHdr_Crtd_User] DEFAULT (' ') NOT NULL,
    [CuryEffDate]      SMALLDATETIME CONSTRAINT [DF_POReqHdr_CuryEffDate] DEFAULT ('01/01/1900') NOT NULL,
    [CuryFreight]      FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryFreight] DEFAULT ((0)) NOT NULL,
    [CuryID]           CHAR (4)      CONSTRAINT [DF_POReqHdr_CuryID] DEFAULT (' ') NOT NULL,
    [CuryMultDiv]      CHAR (1)      CONSTRAINT [DF_POReqHdr_CuryMultDiv] DEFAULT (' ') NOT NULL,
    [CuryPrevPOTotal]  FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryPrevPOTotal] DEFAULT ((0)) NOT NULL,
    [CuryRate]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryRate] DEFAULT ((0)) NOT NULL,
    [CuryRateType]     CHAR (6)      CONSTRAINT [DF_POReqHdr_CuryRateType] DEFAULT (' ') NOT NULL,
    [CuryReqTotal]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryReqTotal] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot00]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTaxTot00] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot01]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTaxTot01] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot02]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTaxTot02] DEFAULT ((0)) NOT NULL,
    [CuryTaxTot03]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTaxTot03] DEFAULT ((0)) NOT NULL,
    [CuryTotalExtCost] FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTotalExtCost] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot00]    FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTxblTot00] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot01]    FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTxblTot01] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot02]    FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTxblTot02] DEFAULT ((0)) NOT NULL,
    [CuryTxblTot03]    FLOAT (53)    CONSTRAINT [DF_POReqHdr_CuryTxblTot03] DEFAULT ((0)) NOT NULL,
    [Descr]            CHAR (30)     CONSTRAINT [DF_POReqHdr_Descr] DEFAULT (' ') NOT NULL,
    [DocHandling]      CHAR (2)      CONSTRAINT [DF_POReqHdr_DocHandling] DEFAULT (' ') NOT NULL,
    [EMail]            CHAR (80)     CONSTRAINT [DF_POReqHdr_EMail] DEFAULT (' ') NOT NULL,
    [EncumbranceFlag]  CHAR (1)      CONSTRAINT [DF_POReqHdr_EncumbranceFlag] DEFAULT (' ') NOT NULL,
    [Fax]              CHAR (30)     CONSTRAINT [DF_POReqHdr_Fax] DEFAULT (' ') NOT NULL,
    [FOB]              CHAR (15)     CONSTRAINT [DF_POReqHdr_FOB] DEFAULT (' ') NOT NULL,
    [Freight]          FLOAT (53)    CONSTRAINT [DF_POReqHdr_Freight] DEFAULT ((0)) NOT NULL,
    [LineCntr]         SMALLINT      CONSTRAINT [DF_POReqHdr_LineCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME CONSTRAINT [DF_POReqHdr_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]        CHAR (8)      CONSTRAINT [DF_POReqHdr_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]        CHAR (10)     CONSTRAINT [DF_POReqHdr_LUpd_User] DEFAULT (' ') NOT NULL,
    [Name]             CHAR (60)     CONSTRAINT [DF_POReqHdr_Name] DEFAULT (' ') NOT NULL,
    [NoteID]           INT           CONSTRAINT [DF_POReqHdr_NoteID] DEFAULT ((0)) NOT NULL,
    [OptA]             CHAR (1)      CONSTRAINT [DF_POReqHdr_OptA] DEFAULT (' ') NOT NULL,
    [OptB]             CHAR (1)      CONSTRAINT [DF_POReqHdr_OptB] DEFAULT (' ') NOT NULL,
    [OptC]             CHAR (1)      CONSTRAINT [DF_POReqHdr_OptC] DEFAULT (' ') NOT NULL,
    [PerApproved]      CHAR (6)      CONSTRAINT [DF_POReqHdr_PerApproved] DEFAULT (' ') NOT NULL,
    [PerEntered]       CHAR (6)      CONSTRAINT [DF_POReqHdr_PerEntered] DEFAULT (' ') NOT NULL,
    [Phone]            CHAR (30)     CONSTRAINT [DF_POReqHdr_Phone] DEFAULT (' ') NOT NULL,
    [PODate]           SMALLDATETIME CONSTRAINT [DF_POReqHdr_PODate] DEFAULT ('01/01/1900') NOT NULL,
    [PolicyLevObt]     CHAR (2)      CONSTRAINT [DF_POReqHdr_PolicyLevObt] DEFAULT (' ') NOT NULL,
    [PolicyLevReq]     CHAR (2)      CONSTRAINT [DF_POReqHdr_PolicyLevReq] DEFAULT (' ') NOT NULL,
    [PONbr]            CHAR (10)     CONSTRAINT [DF_POReqHdr_PONbr] DEFAULT (' ') NOT NULL,
    [POPrinted]        SMALLINT      CONSTRAINT [DF_POReqHdr_POPrinted] DEFAULT ((0)) NOT NULL,
    [POType]           CHAR (2)      CONSTRAINT [DF_POReqHdr_POType] DEFAULT (' ') NOT NULL,
    [PrevPOTotal]      FLOAT (53)    CONSTRAINT [DF_POReqHdr_PrevPOTotal] DEFAULT ((0)) NOT NULL,
    [ProjectID]        CHAR (16)     CONSTRAINT [DF_POReqHdr_ProjectID] DEFAULT (' ') NOT NULL,
    [QuoteDate]        SMALLDATETIME CONSTRAINT [DF_POReqHdr_QuoteDate] DEFAULT ('01/01/1900') NOT NULL,
    [ReqCntr]          CHAR (2)      CONSTRAINT [DF_POReqHdr_ReqCntr] DEFAULT (' ') NOT NULL,
    [ReqNbr]           CHAR (10)     CONSTRAINT [DF_POReqHdr_ReqNbr] DEFAULT (' ') NOT NULL,
    [ReqTotal]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_ReqTotal] DEFAULT ((0)) NOT NULL,
    [ReqType]          CHAR (2)      CONSTRAINT [DF_POReqHdr_ReqType] DEFAULT (' ') NOT NULL,
    [Requstnr]         CHAR (47)     CONSTRAINT [DF_POReqHdr_Requstnr] DEFAULT (' ') NOT NULL,
    [RequstnrDept]     CHAR (10)     CONSTRAINT [DF_POReqHdr_RequstnrDept] DEFAULT (' ') NOT NULL,
    [RequstnrName]     CHAR (30)     CONSTRAINT [DF_POReqHdr_RequstnrName] DEFAULT (' ') NOT NULL,
    [S4Future01]       CHAR (30)     CONSTRAINT [DF_POReqHdr_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]       CHAR (30)     CONSTRAINT [DF_POReqHdr_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]       FLOAT (53)    CONSTRAINT [DF_POReqHdr_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]       FLOAT (53)    CONSTRAINT [DF_POReqHdr_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]       FLOAT (53)    CONSTRAINT [DF_POReqHdr_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]       FLOAT (53)    CONSTRAINT [DF_POReqHdr_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]       SMALLDATETIME CONSTRAINT [DF_POReqHdr_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]       SMALLDATETIME CONSTRAINT [DF_POReqHdr_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]       INT           CONSTRAINT [DF_POReqHdr_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]       INT           CONSTRAINT [DF_POReqHdr_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]       CHAR (10)     CONSTRAINT [DF_POReqHdr_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]       CHAR (10)     CONSTRAINT [DF_POReqHdr_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipAddr1]        CHAR (60)     CONSTRAINT [DF_POReqHdr_ShipAddr1] DEFAULT (' ') NOT NULL,
    [ShipAddr2]        CHAR (60)     CONSTRAINT [DF_POReqHdr_ShipAddr2] DEFAULT (' ') NOT NULL,
    [ShipAddrID]       CHAR (10)     CONSTRAINT [DF_POReqHdr_ShipAddrID] DEFAULT (' ') NOT NULL,
    [ShipAttn]         CHAR (30)     CONSTRAINT [DF_POReqHdr_ShipAttn] DEFAULT (' ') NOT NULL,
    [ShipCity]         CHAR (30)     CONSTRAINT [DF_POReqHdr_ShipCity] DEFAULT (' ') NOT NULL,
    [ShipCountry]      CHAR (3)      CONSTRAINT [DF_POReqHdr_ShipCountry] DEFAULT (' ') NOT NULL,
    [ShipEmail]        CHAR (80)     CONSTRAINT [DF_POReqHdr_ShipEmail] DEFAULT (' ') NOT NULL,
    [ShipFax]          CHAR (30)     CONSTRAINT [DF_POReqHdr_ShipFax] DEFAULT (' ') NOT NULL,
    [ShipName]         CHAR (60)     CONSTRAINT [DF_POReqHdr_ShipName] DEFAULT (' ') NOT NULL,
    [ShipPhone]        CHAR (30)     CONSTRAINT [DF_POReqHdr_ShipPhone] DEFAULT (' ') NOT NULL,
    [ShipState]        CHAR (3)      CONSTRAINT [DF_POReqHdr_ShipState] DEFAULT (' ') NOT NULL,
    [ShipVia]          CHAR (15)     CONSTRAINT [DF_POReqHdr_ShipVia] DEFAULT (' ') NOT NULL,
    [ShipZip]          CHAR (10)     CONSTRAINT [DF_POReqHdr_ShipZip] DEFAULT (' ') NOT NULL,
    [State]            CHAR (3)      CONSTRAINT [DF_POReqHdr_State] DEFAULT (' ') NOT NULL,
    [Status]           CHAR (2)      CONSTRAINT [DF_POReqHdr_Status] DEFAULT (' ') NOT NULL,
    [TaxCntr00]        SMALLINT      CONSTRAINT [DF_POReqHdr_TaxCntr00] DEFAULT ((0)) NOT NULL,
    [TaxCntr01]        SMALLINT      CONSTRAINT [DF_POReqHdr_TaxCntr01] DEFAULT ((0)) NOT NULL,
    [TaxCntr02]        SMALLINT      CONSTRAINT [DF_POReqHdr_TaxCntr02] DEFAULT ((0)) NOT NULL,
    [TaxCntr03]        SMALLINT      CONSTRAINT [DF_POReqHdr_TaxCntr03] DEFAULT ((0)) NOT NULL,
    [TaxID00]          CHAR (10)     CONSTRAINT [DF_POReqHdr_TaxID00] DEFAULT (' ') NOT NULL,
    [TaxID01]          CHAR (10)     CONSTRAINT [DF_POReqHdr_TaxID01] DEFAULT (' ') NOT NULL,
    [TaxID02]          CHAR (10)     CONSTRAINT [DF_POReqHdr_TaxID02] DEFAULT (' ') NOT NULL,
    [TaxID03]          CHAR (10)     CONSTRAINT [DF_POReqHdr_TaxID03] DEFAULT (' ') NOT NULL,
    [TaxTot00]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_TaxTot00] DEFAULT ((0)) NOT NULL,
    [TaxTot01]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_TaxTot01] DEFAULT ((0)) NOT NULL,
    [TaxTot02]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_TaxTot02] DEFAULT ((0)) NOT NULL,
    [TaxTot03]         FLOAT (53)    CONSTRAINT [DF_POReqHdr_TaxTot03] DEFAULT ((0)) NOT NULL,
    [Terms]            CHAR (2)      CONSTRAINT [DF_POReqHdr_Terms] DEFAULT (' ') NOT NULL,
    [TotalExtCost]     FLOAT (53)    CONSTRAINT [DF_POReqHdr_TotalExtCost] DEFAULT ((0)) NOT NULL,
    [TranMedium]       CHAR (2)      CONSTRAINT [DF_POReqHdr_TranMedium] DEFAULT (' ') NOT NULL,
    [TxblTot00]        FLOAT (53)    CONSTRAINT [DF_POReqHdr_TxblTot00] DEFAULT ((0)) NOT NULL,
    [TxblTot01]        FLOAT (53)    CONSTRAINT [DF_POReqHdr_TxblTot01] DEFAULT ((0)) NOT NULL,
    [TxblTot02]        FLOAT (53)    CONSTRAINT [DF_POReqHdr_TxblTot02] DEFAULT ((0)) NOT NULL,
    [TxblTot03]        FLOAT (53)    CONSTRAINT [DF_POReqHdr_TxblTot03] DEFAULT ((0)) NOT NULL,
    [User1]            CHAR (30)     CONSTRAINT [DF_POReqHdr_User1] DEFAULT (' ') NOT NULL,
    [User2]            CHAR (30)     CONSTRAINT [DF_POReqHdr_User2] DEFAULT (' ') NOT NULL,
    [User3]            FLOAT (53)    CONSTRAINT [DF_POReqHdr_User3] DEFAULT ((0)) NOT NULL,
    [User4]            FLOAT (53)    CONSTRAINT [DF_POReqHdr_User4] DEFAULT ((0)) NOT NULL,
    [User5]            CHAR (10)     CONSTRAINT [DF_POReqHdr_User5] DEFAULT (' ') NOT NULL,
    [User6]            CHAR (10)     CONSTRAINT [DF_POReqHdr_User6] DEFAULT (' ') NOT NULL,
    [User7]            SMALLDATETIME CONSTRAINT [DF_POReqHdr_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]            SMALLDATETIME CONSTRAINT [DF_POReqHdr_User8] DEFAULT ('01/01/1900') NOT NULL,
    [VendAddrID]       CHAR (10)     CONSTRAINT [DF_POReqHdr_VendAddrID] DEFAULT (' ') NOT NULL,
    [VendID]           CHAR (15)     CONSTRAINT [DF_POReqHdr_VendID] DEFAULT (' ') NOT NULL,
    [Zip]              CHAR (10)     CONSTRAINT [DF_POReqHdr_Zip] DEFAULT (' ') NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [POReqHdr0] PRIMARY KEY CLUSTERED ([ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [POReqHdr1]
    ON [dbo].[POReqHdr]([ReqType] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr2]
    ON [dbo].[POReqHdr]([Status] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr3]
    ON [dbo].[POReqHdr]([ReqTotal] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr4]
    ON [dbo].[POReqHdr]([Requstnr] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr5]
    ON [dbo].[POReqHdr]([VendID] ASC, [ReqNbr] ASC, [ReqCntr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POReqHdr6]
    ON [dbo].[POReqHdr]([ReqCntr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr7]
    ON [dbo].[POReqHdr]([CpnyID] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr8]
    ON [dbo].[POReqHdr]([PONbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [POReqHdr9]
    ON [dbo].[POReqHdr]([Terms] ASC) WITH (FILLFACTOR = 100);

