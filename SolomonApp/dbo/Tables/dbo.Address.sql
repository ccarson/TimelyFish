﻿CREATE TABLE [dbo].[Address] (
    [Addr1]         CHAR (60)     NOT NULL,
    [Addr2]         CHAR (60)     NOT NULL,
    [AddrId]        CHAR (10)     NOT NULL,
    [Attn]          CHAR (30)     NOT NULL,
    [City]          CHAR (30)     NOT NULL,
    [Country]       CHAR (3)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Fax]           CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [Name]          CHAR (60)     NOT NULL,
    [Phone]         CHAR (30)     NOT NULL,
    [S4Future01]    CHAR (30)     NOT NULL,
    [S4Future02]    CHAR (30)     NOT NULL,
    [S4Future03]    FLOAT (53)    NOT NULL,
    [S4Future04]    FLOAT (53)    NOT NULL,
    [S4Future05]    FLOAT (53)    NOT NULL,
    [S4Future06]    FLOAT (53)    NOT NULL,
    [S4Future07]    SMALLDATETIME NOT NULL,
    [S4Future08]    SMALLDATETIME NOT NULL,
    [S4Future09]    INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [Salut]         CHAR (30)     NOT NULL,
    [State]         CHAR (3)      NOT NULL,
    [TaxId00]       CHAR (10)     NOT NULL,
    [TaxId01]       CHAR (10)     NOT NULL,
    [TaxId02]       CHAR (10)     NOT NULL,
    [TaxId03]       CHAR (10)     NOT NULL,
    [TaxLocId]      CHAR (15)     NOT NULL,
    [TaxRegNbr]     CHAR (15)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [User9]         CHAR (45)     NOT NULL,
    [User10]        CHAR (30)     NOT NULL,
    [Zip]           CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [Address0] PRIMARY KEY CLUSTERED ([AddrId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [Address1]
    ON [dbo].[Address]([Name] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Address2]
    ON [dbo].[Address]([Zip] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [Address3]
    ON [dbo].[Address]([Phone] ASC) WITH (FILLFACTOR = 90);

