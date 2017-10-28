CREATE TABLE [dbo].[PJPROJXREFMSP] (
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (47)     NOT NULL,
    [LUpd_DateTime] SMALLDATETIME NOT NULL,
    [LUpd_Prog]     CHAR (8)      NOT NULL,
    [LUpd_User]     CHAR (47)     NOT NULL,
    [Project]       CHAR (16)     NOT NULL,
    [Project_MSPID] CHAR (36)     NOT NULL,
    [Status]        CHAR (1)      NOT NULL,
    [TStamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [PJPROJXREFMSP0] PRIMARY KEY CLUSTERED ([Project] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PJPROJXREFMSP1]
    ON [dbo].[PJPROJXREFMSP]([Project_MSPID] ASC) WITH (FILLFACTOR = 90);

