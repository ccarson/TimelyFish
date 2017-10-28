CREATE TABLE [dbo].[smBranch] (
    [Addr1]         CHAR (30)     NOT NULL,
    [Addr2]         CHAR (30)     NOT NULL,
    [Attn]          CHAR (30)     NOT NULL,
    [BranchId]      CHAR (10)     NOT NULL,
    [City]          CHAR (30)     NOT NULL,
    [Country]       CHAR (3)      NOT NULL,
    [CpnyID]        CHAR (10)     NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [FaxNbr]        CHAR (15)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [Name]          CHAR (30)     NOT NULL,
    [NoteId]        INT           NOT NULL,
    [Phone]         CHAR (15)     NOT NULL,
    [SB_ID01]       CHAR (30)     NOT NULL,
    [SB_ID02]       CHAR (30)     NOT NULL,
    [SB_ID03]       CHAR (20)     NOT NULL,
    [SB_ID04]       CHAR (20)     NOT NULL,
    [SB_ID05]       CHAR (10)     NOT NULL,
    [SB_ID06]       CHAR (10)     NOT NULL,
    [SB_ID07]       CHAR (4)      NOT NULL,
    [SB_ID08]       FLOAT (53)    NOT NULL,
    [SB_ID09]       SMALLDATETIME NOT NULL,
    [SB_ID10]       SMALLINT      NOT NULL,
    [ShortKey]      CHAR (3)      NOT NULL,
    [State]         CHAR (3)      NOT NULL,
    [User1]         CHAR (30)     NOT NULL,
    [User2]         CHAR (30)     NOT NULL,
    [User3]         FLOAT (53)    NOT NULL,
    [User4]         FLOAT (53)    NOT NULL,
    [User5]         CHAR (10)     NOT NULL,
    [User6]         CHAR (10)     NOT NULL,
    [User7]         SMALLDATETIME NOT NULL,
    [User8]         SMALLDATETIME NOT NULL,
    [Zip]           CHAR (9)      NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [smBranch0] PRIMARY KEY CLUSTERED ([BranchId] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [smBranch1]
    ON [dbo].[smBranch]([BranchId] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90);

