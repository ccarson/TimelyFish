CREATE TABLE [dbo].[cftPMGradeQtyTemp] (
    [BatchNbr]             CHAR (10)     NULL,
    [Crtd_DateTime]        SMALLDATETIME NULL,
    [Crtd_Prog]            CHAR (8)      NULL,
    [Crtd_User]            CHAR (10)     NULL,
    [LineNbr]              SMALLINT      NULL,
    [Lupd_Date]            SMALLDATETIME NULL,
    [Lupd_Prog]            CHAR (8)      NULL,
    [Lupd_User]            CHAR (10)     NULL,
    [NoteID]               INT           NULL,
    [PigGradeCatTypeID]    CHAR (2)      NULL,
    [PigGradeSubCatTypeID] CHAR (2)      NULL,
    [Qty]                  SMALLINT      NULL,
    [RefNbr]               CHAR (10)     NULL,
    [tstamp]               ROWVERSION    NULL
);


GO
CREATE CLUSTERED INDEX [cftPMGradeQtyTempEss]
    ON [dbo].[cftPMGradeQtyTemp]([PigGradeCatTypeID] ASC);

