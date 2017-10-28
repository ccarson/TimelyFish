CREATE TABLE [dbo].[cftBarnType] (
    [BarnTypeDescription] VARCHAR (30) NULL,
    [BarnTypeID]          INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Crtd_DateTime]       DATETIME     NOT NULL,
    [Lupd_User]           VARCHAR (16) NOT NULL,
    [Crtd_User]           VARCHAR (14) NOT NULL,
    [Lupd_Prog]           INT          NOT NULL,
    [Lupd_DateTime]       DATETIME     NOT NULL,
    [tstamp]              ROWVERSION   NOT NULL,
    PRIMARY KEY CLUSTERED ([BarnTypeID] ASC) WITH (FILLFACTOR = 90)
);

