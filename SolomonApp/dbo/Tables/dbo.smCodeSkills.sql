CREATE TABLE [dbo].[smCodeSkills] (
    [Crtd_DateTime]      SMALLDATETIME NOT NULL,
    [Crtd_Prog]          CHAR (8)      NOT NULL,
    [Crtd_User]          CHAR (10)     NOT NULL,
    [FaultSkillsID]      CHAR (10)     NOT NULL,
    [FaultSkillsSkillID] CHAR (10)     NOT NULL,
    [Lupd_DateTime]      SMALLDATETIME NOT NULL,
    [Lupd_Prog]          CHAR (8)      NOT NULL,
    [Lupd_User]          CHAR (10)     NOT NULL,
    [user1]              CHAR (30)     NOT NULL,
    [user2]              CHAR (30)     NOT NULL,
    [user3]              FLOAT (53)    NOT NULL,
    [user4]              FLOAT (53)    NOT NULL,
    [User5]              CHAR (10)     NOT NULL,
    [User6]              CHAR (10)     NOT NULL,
    [User7]              SMALLDATETIME NOT NULL,
    [User8]              SMALLDATETIME NOT NULL,
    [tstamp]             ROWVERSION    NOT NULL,
    CONSTRAINT [smCodeSkills0] PRIMARY KEY CLUSTERED ([FaultSkillsID] ASC, [FaultSkillsSkillID] ASC) WITH (FILLFACTOR = 90)
);

