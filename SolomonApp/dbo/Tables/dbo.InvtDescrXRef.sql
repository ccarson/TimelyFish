CREATE TABLE [dbo].[InvtDescrXRef] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DescrSeg]      CHAR (20)     NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [InvtDescrXRef0] PRIMARY KEY CLUSTERED ([InvtID] ASC, [DescrSeg] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [InvtDescrXRef1]
    ON [dbo].[InvtDescrXRef]([DescrSeg] ASC, [InvtID] ASC) WITH (FILLFACTOR = 90);

