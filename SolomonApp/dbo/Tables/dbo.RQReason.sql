CREATE TABLE [dbo].[RQReason] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [ItemNbr]       CHAR (10)     NOT NULL,
    [ItemLineNbr]   SMALLINT      NOT NULL,
    [ItemType]      CHAR (1)      NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [S4Future1]     CHAR (30)     NOT NULL,
    [S4Future2]     CHAR (30)     NOT NULL,
    [S4Future3]     FLOAT (53)    NOT NULL,
    [S4Future4]     FLOAT (53)    NOT NULL,
    [S4Future5]     FLOAT (53)    NOT NULL,
    [S4Future6]     FLOAT (53)    NOT NULL,
    [S4Future7]     SMALLDATETIME NOT NULL,
    [S4Future8]     SMALLDATETIME NOT NULL,
    [S4Future9]     INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [ZZReason]      TEXT          NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [RQItemReqReason0] PRIMARY KEY CLUSTERED ([ItemType] ASC, [ItemNbr] ASC, [ItemLineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQReason0]
    ON [dbo].[RQReason]([ItemType] ASC, [ItemNbr] ASC, [ItemLineNbr] ASC);

