CREATE TABLE [dbo].[CopyProjectAndTasksBad] (
    [CopyProj]    CHAR (16)  NOT NULL,
    [NewProj]     CHAR (16)  NOT NULL,
    [TableID]     CHAR (20)  NOT NULL,
    [UserID]      CHAR (47)  NOT NULL,
    [UserAddress] CHAR (47)  NOT NULL,
    [tstamp]      ROWVERSION NOT NULL,
    CONSTRAINT [CopyProjectAndTasksBad0] PRIMARY KEY CLUSTERED ([CopyProj] ASC, [NewProj] ASC, [UserAddress] ASC, [UserID] ASC)
);

