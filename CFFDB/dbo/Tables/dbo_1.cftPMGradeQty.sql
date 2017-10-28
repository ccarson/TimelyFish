CREATE TABLE [dbo].[cftPMGradeQty] (
    [BatchNbr]             CHAR (10)     NOT NULL,
    [Crtd_DateTime]        SMALLDATETIME NULL,
    [Crtd_Prog]            CHAR (8)      NULL,
    [Crtd_User]            CHAR (10)     NULL,
    [LineNbr]              SMALLINT      NOT NULL,
    [Lupd_Date]            SMALLDATETIME NULL,
    [Lupd_Prog]            CHAR (8)      NULL,
    [Lupd_User]            CHAR (10)     NULL,
    [NoteID]               INT           NULL,
    [PigGradeCatTypeID]    CHAR (2)      NULL,
    [PigGradeSubCatTypeID] CHAR (2)      NULL,
    [Qty]                  SMALLINT      NULL,
    [RefNbr]               CHAR (10)     NOT NULL,
    [tstamp]               ROWVERSION    NULL
);

