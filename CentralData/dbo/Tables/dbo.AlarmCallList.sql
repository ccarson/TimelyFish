CREATE TABLE [dbo].[AlarmCallList] (
    [AlarmCallListID] INT IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [SiteContactID]   INT NOT NULL,
    [ContactID]       INT NOT NULL,
    [PhoneID]         INT NULL,
    [Rank]            INT NULL,
    CONSTRAINT [PK_AlarmCallList] PRIMARY KEY CLUSTERED ([AlarmCallListID] ASC) WITH (FILLFACTOR = 90)
);

