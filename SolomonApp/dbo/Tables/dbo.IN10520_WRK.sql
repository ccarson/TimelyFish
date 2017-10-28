CREATE TABLE [dbo].[IN10520_WRK] (
    [ClassID]       CHAR (6)      CONSTRAINT [DF_IN10520_WRK_ClassID] DEFAULT (' ') NOT NULL,
    [ComputerName]  CHAR (21)     CONSTRAINT [DF_IN10520_WRK_ComputerName] DEFAULT (' ') NOT NULL,
    [Crtd_DateTime] SMALLDATETIME CONSTRAINT [DF_IN10520_WRK_Crtd_DateTime] DEFAULT (rtrim(CONVERT([varchar](30),CONVERT([smalldatetime],getdate(),0),0))) NOT NULL,
    [InvtID]        CHAR (30)     CONSTRAINT [DF_IN10520_WRK_InvtID] DEFAULT (' ') NOT NULL,
    [tstamp]        ROWVERSION    NOT NULL
);

