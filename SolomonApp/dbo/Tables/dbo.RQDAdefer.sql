CREATE TABLE [dbo].[RQDAdefer] (
    [crtd_datetime] SMALLDATETIME NOT NULL,
    [crtd_prog]     CHAR (8)      NOT NULL,
    [crtd_user]     CHAR (10)     NOT NULL,
    [DeptId]        CHAR (10)     NOT NULL,
    [DeferUserID]   CHAR (47)     NOT NULL,
    [EndDate]       SMALLDATETIME NOT NULL,
    [Entered]       CHAR (1)      NOT NULL,
    [lupd_datetime] SMALLDATETIME NOT NULL,
    [lupd_prog]     CHAR (8)      NOT NULL,
    [lupd_user]     CHAR (10)     NOT NULL,
    [ProcessedBy]   CHAR (47)     NOT NULL,
    [ProcessedOn]   SMALLDATETIME NOT NULL,
    [S4Future1]     CHAR (30)     NOT NULL,
    [S4Future2]     CHAR (30)     NOT NULL,
    [S4Future3]     FLOAT (53)    NOT NULL,
    [S4Future4]     FLOAT (53)    NOT NULL,
    [S4Future5]     FLOAT (53)    NOT NULL,
    [S4Future6]     FLOAT (53)    NOT NULL,
    [S4Future7]     SMALLDATETIME NOT NULL,
    [S4Future8]     SMALLDATETIME NOT NULL,
    [S4Future9]     INT           NOT NULL,
    [S4Future10]    INT           NOT NULL,
    [S4Future11]    CHAR (10)     NOT NULL,
    [S4Future12]    CHAR (10)     NOT NULL,
    [StartDate]     SMALLDATETIME NOT NULL,
    [Terminated]    CHAR (1)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [UserId]        CHAR (47)     NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQDAdefer0]
    ON [dbo].[RQDAdefer]([DeptId] ASC, [UserId] ASC, [DeferUserID] ASC, [StartDate] ASC);

