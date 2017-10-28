CREATE TABLE [dbo].[cftPfosPigGroup] (
    [crtd_user]    CHAR (20)     NOT NULL,
    [Eff_DT]       SMALLDATETIME NOT NULL,
    [Expire_DT]    SMALLDATETIME NULL,
    [PfosID]       INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [PfosStatusID] INT           NOT NULL,
    [PigGrougID]   CHAR (10)     NOT NULL,
    [tstamp]       ROWVERSION    NOT NULL,
    CONSTRAINT [cftPfosPigGroup0] PRIMARY KEY CLUSTERED ([PfosID] ASC) WITH (FILLFACTOR = 80)
);

