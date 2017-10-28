CREATE TABLE [dbo].[CustNameXRef] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustID]        CHAR (15)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [NameSeg]       CHAR (20)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [CustNameXRef0] PRIMARY KEY CLUSTERED ([CustID] ASC, [NameSeg] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [CustNameXRef1]
    ON [dbo].[CustNameXRef]([NameSeg] ASC, [CustID] ASC) WITH (FILLFACTOR = 90);

