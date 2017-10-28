CREATE TABLE [dbo].[APAdjust] (
    [AdjAmt]            FLOAT (53)    NOT NULL,
    [AdjBatNbr]         CHAR (10)     NOT NULL,
    [AdjBkupWthld]      FLOAT (53)    NOT NULL,
    [AdjdDocType]       CHAR (2)      NOT NULL,
    [AdjDiscAmt]        FLOAT (53)    NOT NULL,
    [AdjdRefNbr]        CHAR (10)     NOT NULL,
    [AdjgAcct]          CHAR (10)     NOT NULL,
    [AdjgDocDate]       SMALLDATETIME NOT NULL,
    [AdjgDocType]       CHAR (2)      NOT NULL,
    [AdjgPerPost]       CHAR (6)      NOT NULL,
    [AdjgRefNbr]        CHAR (10)     NOT NULL,
    [AdjgSub]           CHAR (24)     NOT NULL,
    [Crtd_DateTime]     SMALLDATETIME NOT NULL,
    [Crtd_Prog]         CHAR (8)      NOT NULL,
    [Crtd_User]         CHAR (10)     NOT NULL,
    [CuryAdjdAmt]       FLOAT (53)    NOT NULL,
    [CuryAdjdBkupWthld] FLOAT (53)    NOT NULL,
    [CuryAdjdCuryId]    CHAR (4)      NOT NULL,
    [CuryAdjdDiscAmt]   FLOAT (53)    NOT NULL,
    [CuryAdjdMultDiv]   CHAR (1)      NOT NULL,
    [CuryAdjdRate]      FLOAT (53)    NOT NULL,
    [CuryAdjgAmt]       FLOAT (53)    NOT NULL,
    [CuryAdjgBkupWthld] FLOAT (53)    NOT NULL,
    [CuryAdjgDiscAmt]   FLOAT (53)    NOT NULL,
    [CuryRGOLAmt]       FLOAT (53)    NOT NULL,
    [DateAppl]          SMALLDATETIME NOT NULL,
    [LUpd_DateTime]     SMALLDATETIME NOT NULL,
    [LUpd_Prog]         CHAR (8)      NOT NULL,
    [LUpd_User]         CHAR (10)     NOT NULL,
    [PerAppl]           CHAR (6)      NOT NULL,
    [PrePay_RefNbr]     CHAR (10)     NOT NULL,
    [S4Future01]        CHAR (30)     NOT NULL,
    [S4Future02]        CHAR (30)     NOT NULL,
    [S4Future03]        FLOAT (53)    NOT NULL,
    [S4Future04]        FLOAT (53)    NOT NULL,
    [S4Future05]        FLOAT (53)    NOT NULL,
    [S4Future06]        FLOAT (53)    NOT NULL,
    [S4Future07]        SMALLDATETIME NOT NULL,
    [S4Future08]        SMALLDATETIME NOT NULL,
    [S4Future09]        INT           NOT NULL,
    [S4Future10]        INT           NOT NULL,
    [S4Future11]        CHAR (10)     NOT NULL,
    [S4Future12]        CHAR (10)     NOT NULL,
    [User1]             CHAR (30)     NOT NULL,
    [User2]             CHAR (30)     NOT NULL,
    [User3]             FLOAT (53)    NOT NULL,
    [User4]             FLOAT (53)    NOT NULL,
    [User5]             CHAR (10)     NOT NULL,
    [User6]             CHAR (10)     NOT NULL,
    [User7]             SMALLDATETIME NOT NULL,
    [User8]             SMALLDATETIME NOT NULL,
    [VendId]            CHAR (15)     NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [APAdjust0] PRIMARY KEY CLUSTERED ([AdjdRefNbr] ASC, [AdjdDocType] ASC, [AdjgRefNbr] ASC, [AdjgDocType] ASC, [VendId] ASC, [AdjgAcct] ASC, [AdjgSub] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [APAdjust1]
    ON [dbo].[APAdjust]([AdjdRefNbr] ASC, [AdjdDocType] ASC, [VendId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APAdjust2]
    ON [dbo].[APAdjust]([AdjgRefNbr] ASC, [AdjgDocType] ASC, [AdjgAcct] ASC, [AdjgSub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APAdjust3]
    ON [dbo].[APAdjust]([VendId] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APAdjust4]
    ON [dbo].[APAdjust]([AdjgPerPost] ASC, [AdjdRefNbr] ASC, [AdjdDocType] ASC, [AdjgRefNbr] ASC, [AdjgDocType] ASC, [VendId] ASC, [AdjgAcct] ASC, [AdjgSub] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [APAdjust5]
    ON [dbo].[APAdjust]([AdjBatNbr] ASC) WITH (FILLFACTOR = 100);

