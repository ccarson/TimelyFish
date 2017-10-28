CREATE TABLE [dbo].[PStatus] (
    [ExecDate]        SMALLDATETIME NOT NULL,
    [ExecTime]        SMALLDATETIME NOT NULL,
    [InternetAddress] CHAR (21)     NOT NULL,
    [PID]             CHAR (10)     NOT NULL,
    [ProcTime]        INT           NOT NULL,
    [RecordID]        INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SessionCntr]     SMALLINT      NOT NULL,
    [Status]          CHAR (1)      NOT NULL,
    [UserId]          CHAR (47)     NOT NULL,
    [ViewDate]        SMALLDATETIME NOT NULL,
    [zfilename]       CHAR (254)    NOT NULL,
    [tstamp]          ROWVERSION    NOT NULL,
    CONSTRAINT [PStatus0] PRIMARY KEY CLUSTERED ([PID] ASC, [UserId] ASC, [InternetAddress] ASC, [SessionCntr] ASC, [ExecDate] ASC, [ExecTime] ASC, [Status] ASC, [RecordID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [PStatus1]
    ON [dbo].[PStatus]([InternetAddress] ASC, [Status] ASC) WITH (FILLFACTOR = 90);

