CREATE TABLE [dbo].[cftPSDetail] (
    [BatNbr]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [DetailTypeId]  CHAR (2)      NOT NULL,
    [GLAcct]        CHAR (10)     NOT NULL,
    [InclFlg]       SMALLINT      NOT NULL,
    [KillDate]      SMALLDATETIME NOT NULL,
    [LineNbr]       SMALLINT      NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [PkrContactId]  CHAR (6)      NOT NULL,
    [Qty]           SMALLINT      NOT NULL,
    [RefNbr]        CHAR (10)     NOT NULL,
    [TattooNbr]     CHAR (6)      NOT NULL,
    [WgtCarc]       FLOAT (53)    NOT NULL,
    [WgtLive]       FLOAT (53)    NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [cftPSDetail0] PRIMARY KEY CLUSTERED ([BatNbr] ASC, [RefNbr] ASC, [LineNbr] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [cftPSDetail_RefNbr_DetailTypeID]
    ON [dbo].[cftPSDetail]([DetailTypeId] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE UNIQUE NONCLUSTERED INDEX [cftPSDetail_RefNbr_DetailTypeID_2]
    ON [dbo].[cftPSDetail]([RefNbr] ASC, [DetailTypeId] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [idx_cftPSDetail_cp518_RefNbr_incl]
    ON [dbo].[cftPSDetail]([RefNbr] ASC)
    INCLUDE([WgtLive]) WITH (FILLFACTOR = 90);

