CREATE TABLE [dbo].[PJPENTEMXREFMSP] (
    [Assignment_MSPID] CHAR (36)     NOT NULL,
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (47)     NOT NULL,
    [Employee]         CHAR (10)     NOT NULL,
    [LUpd_DateTime]    SMALLDATETIME NOT NULL,
    [LUpd_Prog]        CHAR (8)      NOT NULL,
    [LUpd_User]        CHAR (47)     NOT NULL,
    [Pjt_Entity]       CHAR (32)     NOT NULL,
    [Project]          CHAR (16)     NOT NULL,
    [Status]           CHAR (1)      NOT NULL,
    [SubTask_Name]     CHAR (50)     NOT NULL,
    [TStamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [PJPENTEMXREFMSP0] PRIMARY KEY CLUSTERED ([Project] ASC, [Pjt_Entity] ASC, [Employee] ASC, [SubTask_Name] ASC) WITH (FILLFACTOR = 90)
);

