﻿CREATE TABLE [dbo].[RQDept] (
    [crtd_datetime]    SMALLDATETIME NOT NULL,
    [crtd_prog]        CHAR (8)      NOT NULL,
    [crtd_user]        CHAR (10)     NOT NULL,
    [DeptID]           CHAR (10)     NOT NULL,
    [Description]      CHAR (30)     NOT NULL,
    [DfltDelivAddr1]   CHAR (60)     NOT NULL,
    [DfltDelivAddr2]   CHAR (60)     NOT NULL,
    [DfltDelivAttn]    CHAR (30)     NOT NULL,
    [DfltDelivCity]    CHAR (30)     NOT NULL,
    [DfltDelivCountry] CHAR (3)      NOT NULL,
    [DfltDelivEmail]   CHAR (80)     NOT NULL,
    [DfltDelivFax]     CHAR (30)     NOT NULL,
    [DfltDelivName]    CHAR (60)     NOT NULL,
    [DfltDelivPhone]   CHAR (30)     NOT NULL,
    [DfltDelivState]   CHAR (3)      NOT NULL,
    [DfltDelivZip]     CHAR (10)     NOT NULL,
    [DfltExpAcct]      CHAR (10)     NOT NULL,
    [DfltExpSub]       CHAR (24)     NOT NULL,
    [lupd_datetime]    SMALLDATETIME NOT NULL,
    [lupd_prog]        CHAR (8)      NOT NULL,
    [lupd_user]        CHAR (10)     NOT NULL,
    [NoteID]           INT           NOT NULL,
    [S4Future1]        CHAR (30)     NOT NULL,
    [S4Future2]        CHAR (30)     NOT NULL,
    [S4Future3]        FLOAT (53)    NOT NULL,
    [S4Future4]        FLOAT (53)    NOT NULL,
    [S4Future5]        FLOAT (53)    NOT NULL,
    [S4Future6]        FLOAT (53)    NOT NULL,
    [S4Future7]        SMALLDATETIME NOT NULL,
    [S4Future8]        SMALLDATETIME NOT NULL,
    [S4Future9]        INT           NOT NULL,
    [S4Future10]       INT           NOT NULL,
    [S4Future11]       CHAR (10)     NOT NULL,
    [S4Future12]       CHAR (10)     NOT NULL,
    [User1]            CHAR (30)     NOT NULL,
    [User2]            CHAR (30)     NOT NULL,
    [User3]            FLOAT (53)    NOT NULL,
    [User4]            FLOAT (53)    NOT NULL,
    [User5]            CHAR (10)     NOT NULL,
    [User6]            CHAR (10)     NOT NULL,
    [User7]            SMALLDATETIME NOT NULL,
    [User8]            SMALLDATETIME NOT NULL,
    [UserID]           CHAR (47)     NOT NULL,
    [tstamp]           ROWVERSION    NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RQDept0]
    ON [dbo].[RQDept]([DeptID] ASC);

