CREATE TABLE [dbo].[POItemReqHdr] (
    [BillAddr1]     CHAR (60)     CONSTRAINT [DF_POItemReqHdr_BillAddr1] DEFAULT (' ') NOT NULL,
    [BillAddr2]     CHAR (60)     CONSTRAINT [DF_POItemReqHdr_BillAddr2] DEFAULT (' ') NOT NULL,
    [BillCity]      CHAR (30)     CONSTRAINT [DF_POItemReqHdr_BillCity] DEFAULT (' ') NOT NULL,
    [BillCountry]   CHAR (3)      CONSTRAINT [DF_POItemReqHdr_BillCountry] DEFAULT (' ') NOT NULL,
    [BillEmail]     CHAR (80)     CONSTRAINT [DF_POItemReqHdr_BillEmail] DEFAULT (' ') NOT NULL,
    [BillFax]       CHAR (30)     CONSTRAINT [DF_POItemReqHdr_BillFax] DEFAULT (' ') NOT NULL,
    [BillName]      CHAR (60)     CONSTRAINT [DF_POItemReqHdr_BillName] DEFAULT (' ') NOT NULL,
    [BillPhone]     CHAR (30)     CONSTRAINT [DF_POItemReqHdr_BillPhone] DEFAULT (' ') NOT NULL,
    [BillState]     CHAR (3)      CONSTRAINT [DF_POItemReqHdr_BillState] DEFAULT (' ') NOT NULL,
    [BillZip]       CHAR (10)     CONSTRAINT [DF_POItemReqHdr_BillZip] DEFAULT (' ') NOT NULL,
    [City]          CHAR (30)     CONSTRAINT [DF_POItemReqHdr_City] DEFAULT (' ') NOT NULL,
    [Country]       CHAR (3)      CONSTRAINT [DF_POItemReqHdr_Country] DEFAULT (' ') NOT NULL,
    [CreateDate]    SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_CreateDate] DEFAULT ('01/01/1900') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [Crtd_Prog]     CHAR (8)      CONSTRAINT [DF_POItemReqHdr_Crtd_Prog] DEFAULT (' ') NOT NULL,
    [Crtd_User]     CHAR (10)     CONSTRAINT [DF_POItemReqHdr_Crtd_User] DEFAULT (' ') NOT NULL,
    [Descr]         CHAR (30)     CONSTRAINT [DF_POItemReqHdr_Descr] DEFAULT (' ') NOT NULL,
    [DocHandling]   CHAR (2)      CONSTRAINT [DF_POItemReqHdr_DocHandling] DEFAULT (' ') NOT NULL,
    [IrTotal]       FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_IrTotal] DEFAULT ((0)) NOT NULL,
    [ItemReqNbr]    CHAR (10)     CONSTRAINT [DF_POItemReqHdr_ItemReqNbr] DEFAULT (' ') NOT NULL,
    [LineCntr]      SMALLINT      CONSTRAINT [DF_POItemReqHdr_LineCntr] DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime] SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_LUpd_DateTime] DEFAULT ('01/01/1900') NOT NULL,
    [LUpd_Prog]     CHAR (8)      CONSTRAINT [DF_POItemReqHdr_LUpd_Prog] DEFAULT (' ') NOT NULL,
    [LUpd_User]     CHAR (10)     CONSTRAINT [DF_POItemReqHdr_LUpd_User] DEFAULT (' ') NOT NULL,
    [NoteID]        INT           CONSTRAINT [DF_POItemReqHdr_NoteID] DEFAULT ((0)) NOT NULL,
    [Requstnr]      CHAR (47)     CONSTRAINT [DF_POItemReqHdr_Requstnr] DEFAULT (' ') NOT NULL,
    [RequstnrDept]  CHAR (10)     CONSTRAINT [DF_POItemReqHdr_RequstnrDept] DEFAULT (' ') NOT NULL,
    [RequstnrName]  CHAR (30)     CONSTRAINT [DF_POItemReqHdr_RequstnrName] DEFAULT (' ') NOT NULL,
    [S4Future01]    CHAR (30)     CONSTRAINT [DF_POItemReqHdr_S4Future01] DEFAULT (' ') NOT NULL,
    [S4Future02]    CHAR (30)     CONSTRAINT [DF_POItemReqHdr_S4Future02] DEFAULT (' ') NOT NULL,
    [S4Future03]    FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_S4Future03] DEFAULT ((0)) NOT NULL,
    [S4Future04]    FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_S4Future04] DEFAULT ((0)) NOT NULL,
    [S4Future05]    FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_S4Future05] DEFAULT ((0)) NOT NULL,
    [S4Future06]    FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_S4Future06] DEFAULT ((0)) NOT NULL,
    [S4Future07]    SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_S4Future07] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future08]    SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_S4Future08] DEFAULT ('01/01/1900') NOT NULL,
    [S4Future09]    INT           CONSTRAINT [DF_POItemReqHdr_S4Future09] DEFAULT ((0)) NOT NULL,
    [S4Future10]    INT           CONSTRAINT [DF_POItemReqHdr_S4Future10] DEFAULT ((0)) NOT NULL,
    [S4Future11]    CHAR (10)     CONSTRAINT [DF_POItemReqHdr_S4Future11] DEFAULT (' ') NOT NULL,
    [S4Future12]    CHAR (10)     CONSTRAINT [DF_POItemReqHdr_S4Future12] DEFAULT (' ') NOT NULL,
    [ShipAddr1]     CHAR (60)     CONSTRAINT [DF_POItemReqHdr_ShipAddr1] DEFAULT (' ') NOT NULL,
    [ShipAddr2]     CHAR (60)     CONSTRAINT [DF_POItemReqHdr_ShipAddr2] DEFAULT (' ') NOT NULL,
    [ShipCity]      CHAR (30)     CONSTRAINT [DF_POItemReqHdr_ShipCity] DEFAULT (' ') NOT NULL,
    [ShipCountry]   CHAR (3)      CONSTRAINT [DF_POItemReqHdr_ShipCountry] DEFAULT (' ') NOT NULL,
    [ShipEmail]     CHAR (80)     CONSTRAINT [DF_POItemReqHdr_ShipEmail] DEFAULT (' ') NOT NULL,
    [ShipFax]       CHAR (30)     CONSTRAINT [DF_POItemReqHdr_ShipFax] DEFAULT (' ') NOT NULL,
    [ShipName]      CHAR (60)     CONSTRAINT [DF_POItemReqHdr_ShipName] DEFAULT (' ') NOT NULL,
    [ShipPhone]     CHAR (30)     CONSTRAINT [DF_POItemReqHdr_ShipPhone] DEFAULT (' ') NOT NULL,
    [ShipState]     CHAR (3)      CONSTRAINT [DF_POItemReqHdr_ShipState] DEFAULT (' ') NOT NULL,
    [ShipZip]       CHAR (10)     CONSTRAINT [DF_POItemReqHdr_ShipZip] DEFAULT (' ') NOT NULL,
    [State]         CHAR (3)      CONSTRAINT [DF_POItemReqHdr_State] DEFAULT (' ') NOT NULL,
    [Status]        CHAR (2)      CONSTRAINT [DF_POItemReqHdr_Status] DEFAULT (' ') NOT NULL,
    [User1]         CHAR (30)     CONSTRAINT [DF_POItemReqHdr_User1] DEFAULT (' ') NOT NULL,
    [User2]         CHAR (30)     CONSTRAINT [DF_POItemReqHdr_User2] DEFAULT (' ') NOT NULL,
    [User3]         FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_User3] DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    CONSTRAINT [DF_POItemReqHdr_User4] DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     CONSTRAINT [DF_POItemReqHdr_User5] DEFAULT (' ') NOT NULL,
    [User6]         CHAR (10)     CONSTRAINT [DF_POItemReqHdr_User6] DEFAULT (' ') NOT NULL,
    [User7]         SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_User7] DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME CONSTRAINT [DF_POItemReqHdr_User8] DEFAULT ('01/01/1900') NOT NULL,
    [Zip]           CHAR (10)     CONSTRAINT [DF_POItemReqHdr_Zip] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [POItemReqHdr0] PRIMARY KEY CLUSTERED ([ItemReqNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [POItemReqHdr1]
    ON [dbo].[POItemReqHdr]([Status] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POItemReqHdr2]
    ON [dbo].[POItemReqHdr]([CreateDate] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POItemReqHdr3]
    ON [dbo].[POItemReqHdr]([IrTotal] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [POItemReqHdr4]
    ON [dbo].[POItemReqHdr]([Requstnr] ASC, [ItemReqNbr] ASC) WITH (FILLFACTOR = 90);

