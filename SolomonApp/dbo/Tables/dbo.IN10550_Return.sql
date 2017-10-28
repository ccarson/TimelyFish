CREATE TABLE [dbo].[IN10550_Return] (
    [ComputerName]  CHAR (21)     CONSTRAINT [DF_IN10550_Return_ComputerName] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10550_Return_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [ErrorFlag]     CHAR (1)      CONSTRAINT [DF_IN10550_Return_ErrorFlag] DEFAULT (' ') NOT NULL,
    [ErrorInvtId]   CHAR (30)     CONSTRAINT [DF_IN10550_Return_ErrorInvtId] DEFAULT (' ') NOT NULL,
    [ErrorMessage]  CHAR (4)      CONSTRAINT [DF_IN10550_Return_ErrorMessage] DEFAULT (' ') NOT NULL,
    [Process_Flag]  CHAR (1)      CONSTRAINT [DF_IN10550_Return_Process_Flag] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);

