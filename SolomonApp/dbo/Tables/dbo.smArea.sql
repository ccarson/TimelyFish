CREATE TABLE [dbo].[smArea] (
    [AreaAvgRevenue]   FLOAT (53)    NOT NULL,
    [AreaDesc]         CHAR (30)     NOT NULL,
    [AreaId]           CHAR (10)     NOT NULL,
    [AreaNumOfCalls]   SMALLINT      NOT NULL,
    [AreaTotalRevenue] FLOAT (53)    NOT NULL,
    [AssignEmployee]   CHAR (10)     NOT NULL,
    [Crtd_dateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [smArea0] PRIMARY KEY CLUSTERED ([AreaId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smArea1]
    ON [dbo].[smArea]([AreaDesc] ASC) WITH (FILLFACTOR = 90);

