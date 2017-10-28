CREATE TABLE [dbo].[IN10550_Wrk] (
    [ComputerName]  CHAR (21)     CONSTRAINT [DF_IN10550_Wrk_ComputerName] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10550_Wrk_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [KitID]         CHAR (30)     CONSTRAINT [DF_IN10550_Wrk_KitID] DEFAULT (' ') NOT NULL,
    [SiteID]        CHAR (10)     CONSTRAINT [DF_IN10550_Wrk_SiteID] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IN10550_Wrk0] PRIMARY KEY CLUSTERED ([KitID] ASC, [SiteID] ASC, [ComputerName] ASC) WITH (FILLFACTOR = 90)
);

