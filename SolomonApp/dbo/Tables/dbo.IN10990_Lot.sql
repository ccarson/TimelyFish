CREATE TABLE [dbo].[IN10990_Lot] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [InvtID]        CHAR (30)     NOT NULL,
    [LineID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [LineRef]       CHAR (5)      NOT NULL,
    [LotSerNbr]     CHAR (25)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (10)     NOT NULL,
    [SiteID]        CHAR (10)     NOT NULL,
    [WhseLoc]       CHAR (10)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IN10990_Lot0] PRIMARY KEY CLUSTERED ([LineID] ASC) WITH (FILLFACTOR = 90)
);

