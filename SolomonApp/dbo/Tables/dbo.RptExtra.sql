CREATE TABLE [dbo].[RptExtra] (
    [RI_ID]        SMALLINT   NOT NULL,
    [ComputerName] CHAR (21)  NOT NULL,
    [DatabaseName] CHAR (20)  NOT NULL,
    [UserID]       CHAR (47)  NOT NULL,
    [parameters]   IMAGE      NOT NULL,
    [tstamp]       ROWVERSION NOT NULL
);

