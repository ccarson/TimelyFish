CREATE TABLE [dbo].[smEmpClass] (
    [Crtd_DateTime]    SMALLDATETIME NOT NULL,
    [Crtd_Prog]        CHAR (8)      NOT NULL,
    [Crtd_User]        CHAR (10)     NOT NULL,
    [Display]          SMALLINT      NOT NULL,
    [EmpclassCommPaid] CHAR (1)      NOT NULL,
    [Empclassdesc]     CHAR (30)     NOT NULL,
    [Empclassid]       CHAR (10)     NOT NULL,
    [Lupd_DateTime]    SMALLDATETIME NOT NULL,
    [Lupd_Prog]        CHAR (8)      NOT NULL,
    [Lupd_User]        CHAR (10)     NOT NULL,
    [user1]            CHAR (30)     NOT NULL,
    [user2]            CHAR (30)     NOT NULL,
    [user3]            FLOAT (53)    NOT NULL,
    [user4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL,
    CONSTRAINT [smEmpClass0] PRIMARY KEY CLUSTERED ([Empclassid] ASC) WITH (FILLFACTOR = 90)
);

