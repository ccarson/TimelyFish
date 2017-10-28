CREATE TABLE [dbo].[XDDTaxPmt] (
    [Code]          CHAR (5)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Descr]         CHAR (50)     NOT NULL,
    [IDNbr]         CHAR (15)     NOT NULL,
    [IDonSixRec]    SMALLINT      DEFAULT ((0)) NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [Periods]       CHAR (20)     NOT NULL,
    [RecFormat]     CHAR (1)      DEFAULT ('') NOT NULL,
    [Selected]      CHAR (1)      NOT NULL,
    [ShortDescr]    CHAR (15)     NOT NULL,
    [SKFuture01]    CHAR (30)     DEFAULT ('') NOT NULL,
    [SKFuture02]    CHAR (30)     DEFAULT ('') NOT NULL,
    [SKFuture03]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SKFuture04]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SKFuture05]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SKFuture06]    FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [SKFuture07]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SKFuture08]    SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [SKFuture09]    INT           DEFAULT ((0)) NOT NULL,
    [SKFuture10]    INT           DEFAULT ((0)) NOT NULL,
    [SKFuture11]    CHAR (10)     DEFAULT ('') NOT NULL,
    [SKFuture12]    CHAR (10)     DEFAULT ('') NOT NULL,
    [SubCategory]   CHAR (5)      DEFAULT ('') NOT NULL,
    [User1]         CHAR (30)     DEFAULT ('') NOT NULL,
    [User10]        CHAR (30)     DEFAULT ('') NOT NULL,
    [User2]         CHAR (30)     DEFAULT ('') NOT NULL,
    [User3]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User4]         FLOAT (53)    DEFAULT ((0)) NOT NULL,
    [User5]         CHAR (10)     DEFAULT ('') NOT NULL,
    [User6]         CHAR (10)     DEFAULT ('') NOT NULL,
    [User7]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User8]         SMALLDATETIME DEFAULT ('01/01/1900') NOT NULL,
    [User9]         CHAR (30)     DEFAULT ('') NOT NULL,
    [Verification]  CHAR (6)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [XDDTaxPmt0] PRIMARY KEY CLUSTERED ([ShortDescr] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [XDDTaxPmt1]
    ON [dbo].[XDDTaxPmt]([Code] ASC, [SubCategory] ASC, [IDNbr] ASC);

