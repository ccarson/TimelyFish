CREATE TABLE [dbo].[smServHistory] (
    [CallStatus]    CHAR (10)     NOT NULL,
    [ChangedDate]   SMALLDATETIME NOT NULL,
    [ChangedTime]   CHAR (8)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [ServiceCallID] CHAR (10)     NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [UserID]        CHAR (47)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smServHistory0] PRIMARY KEY CLUSTERED ([ServiceCallID] ASC, [CallStatus] ASC, [ChangedDate] ASC, [ChangedTime] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smServHistory1]
    ON [dbo].[smServHistory]([ServiceCallID] ASC, [ChangedDate] ASC, [ChangedTime] ASC, [CallStatus] ASC) WITH (FILLFACTOR = 90);

