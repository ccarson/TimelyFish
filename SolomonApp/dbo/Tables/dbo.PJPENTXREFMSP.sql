CREATE TABLE [dbo].[PJPENTXREFMSP] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (47)     NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (47)     NOT NULL,
    [Pjt_Entity]       CHAR (32)     NOT NULL,
    [Pjt_Entity_MSPID] CHAR (36)     NOT NULL,
    [Project]          CHAR (16)     NOT NULL,
    [Project_MSPID]    CHAR (36)     NOT NULL,
    [Status]           CHAR (1)      NOT NULL,
    [TStamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [PJPENTXREFMSP0] PRIMARY KEY CLUSTERED ([Project] ASC, [Pjt_Entity] ASC) WITH (FILLFACTOR = 90)
);

