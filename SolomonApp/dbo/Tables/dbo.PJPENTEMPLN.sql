﻿CREATE TABLE [dbo].[PJPENTEMPLN] (
    [Crtd_Datetime]  SMALLDATETIME NOT NULL,
    [Crtd_Prog]      CHAR (8)      NOT NULL,
    [Crtd_User]      CHAR (10)     NOT NULL,
    [Datetime_End]   SMALLDATETIME NOT NULL,
    [Datetime_Start] SMALLDATETIME NOT NULL,
    [Employee]       CHAR (10)     NOT NULL,
    [Hours]          FLOAT (53)    NOT NULL,
    [Lupd_Datetime]  SMALLDATETIME NOT NULL,
    [Lupd_Prog]      CHAR (8)      NOT NULL,
    [Lupd_User]      CHAR (10)     NOT NULL,
    [Noteid]         INT           NOT NULL,
    [Period]         CHAR (6)      NOT NULL,
    [Pjt_entity]     CHAR (32)     NOT NULL,
    [Pl_id01]        CHAR (30)     NOT NULL,
    [Pl_id02]        CHAR (30)     NOT NULL,
    [Pl_id03]        CHAR (16)     NOT NULL,
    [Pl_id04]        CHAR (16)     NOT NULL,
    [Pl_id05]        CHAR (4)      NOT NULL,
    [Pl_id06]        FLOAT (53)    NOT NULL,
    [Pl_id07]        FLOAT (53)    NOT NULL,
    [Pl_id08]        SMALLDATETIME NOT NULL,
    [Pl_id09]        SMALLDATETIME NOT NULL,
    [Pl_id10]        INT           NOT NULL,
    [Project]        CHAR (16)     NOT NULL,
    [S4Future01]     CHAR (30)     NOT NULL,
    [S4Future02]     CHAR (30)     NOT NULL,
    [S4Future03]     FLOAT (53)    NOT NULL,
    [S4Future04]     FLOAT (53)    NOT NULL,
    [S4Future05]     FLOAT (53)    NOT NULL,
    [S4Future06]     FLOAT (53)    NOT NULL,
    [S4Future07]     SMALLDATETIME NOT NULL,
    [S4Future08]     SMALLDATETIME NOT NULL,
    [S4Future09]     INT           NOT NULL,
    [S4Future10]     INT           NOT NULL,
    [S4Future11]     CHAR (10)     NOT NULL,
    [S4Future12]     CHAR (10)     NOT NULL,
    [Status]         CHAR (1)      NOT NULL,
    [Timeslot]       INT           NOT NULL,
    [User1]          CHAR (30)     NOT NULL,
    [User2]          CHAR (30)     NOT NULL,
    [User3]          FLOAT (53)    NOT NULL,
    [User4]          FLOAT (53)    NOT NULL,
    [User5]          CHAR (10)     NOT NULL,
    [User6]          CHAR (10)     NOT NULL,
    [User7]          SMALLDATETIME NOT NULL,
    [User8]          SMALLDATETIME NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [PJPENTEMPLN0] PRIMARY KEY CLUSTERED ([Project] ASC, [Pjt_entity] ASC, [Employee] ASC, [Period] ASC, [Timeslot] ASC)
);
