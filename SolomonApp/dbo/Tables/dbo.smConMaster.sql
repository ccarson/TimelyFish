CREATE TABLE [dbo].[smConMaster] (
    [BranchId]      CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [CustId]        CHAR (15)     NOT NULL,
    [EndDate]       SMALLDATETIME NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [MasterId]      CHAR (10)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [StartDate]     SMALLDATETIME NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smConMaster0] PRIMARY KEY CLUSTERED ([MasterId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smConMaster1]
    ON [dbo].[smConMaster]([CustId] ASC, [MasterId] ASC) WITH (FILLFACTOR = 90);

