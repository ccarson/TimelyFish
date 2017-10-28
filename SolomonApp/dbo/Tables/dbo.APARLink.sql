CREATE TABLE [dbo].[APARLink] (
    [APDocType]     CHAR (2)      NOT NULL,
    [APRefNbr]      CHAR (10)     NOT NULL,
    [ARDocType]     CHAR (2)      NOT NULL,
    [ARRefNbr]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (47)     NOT NULL,
    [CustId]        CHAR (15)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (47)     NOT NULL,
    [NoteId]        INT           NOT NULL,
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
    [Status]        CHAR (1)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [VendId]        CHAR (15)     NOT NULL,
    [TStamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [APARLink0] PRIMARY KEY CLUSTERED ([VendId] ASC, [APDocType] ASC, [APRefNbr] ASC, [CustId] ASC, [ARDocType] ASC, [ARRefNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [APARLink1]
    ON [dbo].[APARLink]([CustId] ASC, [ARDocType] ASC, [ARRefNbr] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [APARLink2]
    ON [dbo].[APARLink]([Status] ASC) WITH (FILLFACTOR = 90);

