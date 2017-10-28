CREATE TABLE [dbo].[cftPfosBinTrack] (
    [BinNbr]         CHAR (6)      NOT NULL,
    [Crtd_DateTime]  DATETIME      NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Event_DT]       SMALLDATETIME NOT NULL,
    [IDPfosBinTrack] INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Note]           CHAR (100)    NOT NULL,
    [PfosEventID]    INT           NOT NULL,
    [PigGroupID]     CHAR (10)     NOT NULL,
    [Tons]           FLOAT (53)    NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosBinTrack0] PRIMARY KEY CLUSTERED ([IDPfosBinTrack] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_cftPfosBinTrack_pgbinedt_incl]
    ON [dbo].[cftPfosBinTrack]([PigGroupID] ASC, [PfosEventID] ASC, [BinNbr] ASC)
    INCLUDE([Event_DT], [IDPfosBinTrack]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftPfosBinTrack_id_date]
    ON [dbo].[cftPfosBinTrack]([Event_DT] ASC, [PigGroupID] ASC)
    INCLUDE([BinNbr], [PfosEventID]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [cftPfosBinTrack1]
    ON [dbo].[cftPfosBinTrack]([Event_DT] ASC)
    INCLUDE([BinNbr], [PfosEventID], [PigGroupID]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [idx_cftpfosbintrack_binnbr_piggroupid_incl]
    ON [dbo].[cftPfosBinTrack]([BinNbr] ASC, [PigGroupID] ASC)
    INCLUDE([Tons], [tstamp], [Crtd_Prog], [Crtd_User], [Event_DT], [IDPfosBinTrack], [Note], [PfosEventID], [Crtd_DateTime]) WITH (FILLFACTOR = 100);

