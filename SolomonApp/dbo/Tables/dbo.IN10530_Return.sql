CREATE TABLE [dbo].[IN10530_Return] (
    [BatNbr]        CHAR (10)     CONSTRAINT [DF_IN10530_Return_BatNbr] DEFAULT (' ') NOT NULL,
    [Batch_Created] CHAR (1)      CONSTRAINT [DF_IN10530_Return_Batch_Created] DEFAULT (' ') NOT NULL,
    [ComputerName]  CHAR (21)     CONSTRAINT [DF_IN10530_Return_ComputerName] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10530_Return_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [ErrorFlag]     CHAR (1)      CONSTRAINT [DF_IN10530_Return_ErrorFlag] DEFAULT (' ') NOT NULL,
    [ErrorInvtId]   CHAR (30)     CONSTRAINT [DF_IN10530_Return_ErrorInvtId] DEFAULT (' ') NOT NULL,
    [ErrorMessage]  CHAR (4)      CONSTRAINT [DF_IN10530_Return_ErrorMessage] DEFAULT (' ') NOT NULL,
    [Process_Flag]  CHAR (1)      CONSTRAINT [DF_IN10530_Return_Process_Flag] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL,
    CONSTRAINT [IN10530_Return0] PRIMARY KEY CLUSTERED ([ComputerName] ASC, [BatNbr] ASC, [ErrorInvtId] ASC, [Process_Flag] ASC) WITH (FILLFACTOR = 90)
);

