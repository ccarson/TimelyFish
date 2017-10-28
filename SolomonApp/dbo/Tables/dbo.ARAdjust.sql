CREATE TABLE [dbo].[ARAdjust] (
    [AdjAmt]          FLOAT (53)    NOT NULL,
    [AdjBatNbr]       CHAR (10)     NOT NULL,
    [AdjdDocType]     CHAR (2)      NOT NULL,
    [AdjDiscAmt]      FLOAT (53)    NOT NULL,
    [AdjdRefNbr]      CHAR (10)     NOT NULL,
    [AdjgDocDate]     SMALLDATETIME NOT NULL,
    [AdjgDocType]     CHAR (2)      NOT NULL,
    [AdjgPerPost]     CHAR (6)      NOT NULL,
    [AdjgRefNbr]      CHAR (10)     NOT NULL,
    [Crtd_DateTime]   SMALLDATETIME NOT NULL,
    [Crtd_Prog]       CHAR (8)      NOT NULL,
    [Crtd_User]       CHAR (10)     NOT NULL,
    [CuryAdjdAmt]     FLOAT (53)    NOT NULL,
    [CuryAdjdCuryId]  CHAR (4)      NOT NULL,
    [CuryAdjdDiscAmt] FLOAT (53)    NOT NULL,
    [CuryAdjdMultDiv] CHAR (1)      NOT NULL,
    [CuryAdjdRate]    FLOAT (53)    NOT NULL,
    [CuryAdjgAmt]     FLOAT (53)    NOT NULL,
    [CuryAdjgDiscAmt] FLOAT (53)    NOT NULL,
    [CuryRGOLAmt]     FLOAT (53)    NOT NULL,
    [CustId]          CHAR (15)     NOT NULL,
    [DateAppl]        SMALLDATETIME NOT NULL,
    [LUpd_DateTime]   SMALLDATETIME NOT NULL,
    [LUpd_Prog]       CHAR (8)      NOT NULL,
    [LUpd_User]       CHAR (10)     NOT NULL,
    [PC_Status]       CHAR (1)      NOT NULL,
    [PerAppl]         CHAR (6)      NOT NULL,
    [ProjectID]       CHAR (16)     NOT NULL,
    [RecordID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [S4Future01]      CHAR (30)     NOT NULL,
    [S4Future02]      CHAR (30)     NOT NULL,
    [S4Future03]      FLOAT (53)    NOT NULL,
    [S4Future04]      FLOAT (53)    NOT NULL,
    [S4Future05]      FLOAT (53)    NOT NULL,
    [S4Future06]      FLOAT (53)    NOT NULL,
    [S4Future07]      SMALLDATETIME NOT NULL,
    [S4Future08]      SMALLDATETIME NOT NULL,
    [S4Future09]      INT           NOT NULL,
    [S4Future10]      INT           NOT NULL,
    [S4Future11]      CHAR (10)     NOT NULL,
    [S4Future12]      CHAR (10)     NOT NULL,
    [TaskID]          CHAR (32)     NOT NULL,
    [User1]           CHAR (30)     NOT NULL,
    [User2]           CHAR (30)     NOT NULL,
    [User3]           FLOAT (53)    NOT NULL,
    [User4]           FLOAT (53)    NOT NULL,
    [User5]           CHAR (10)     NOT NULL,
    [User6]           CHAR (10)     NOT NULL,
    [User7]           SMALLDATETIME NOT NULL,
    [User8]           SMALLDATETIME NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [ARAdjust0] PRIMARY KEY CLUSTERED ([AdjdRefNbr] ASC, [RecordID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [ARAdjust2]
    ON [dbo].[ARAdjust]([CustId] ASC, [AdjdDocType] ASC, [AdjdRefNbr] ASC, [AdjgDocDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARAdjust3]
    ON [dbo].[ARAdjust]([CustId] ASC, [AdjgDocType] ASC, [AdjgRefNbr] ASC, [AdjgDocDate] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARAdjust4]
    ON [dbo].[ARAdjust]([AdjBatNbr] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARAdjust5]
    ON [dbo].[ARAdjust]([S4Future11] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [ARAdjust6]
    ON [dbo].[ARAdjust]([RecordID] ASC) WITH (FILLFACTOR = 100);

