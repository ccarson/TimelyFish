CREATE TABLE [dbo].[cftPGStatusUpd] (
    [PigGroupID]    CHAR (10)  NOT NULL,
    [BatNbr]        CHAR (10)  NOT NULL,
    [RefNbr]        CHAR (10)  NOT NULL,
    [OldPGStatusID] CHAR (2)   NOT NULL,
    [NewPGStatusID] CHAR (2)   NOT NULL,
    [tstamp]        ROWVERSION NULL
);


GO
CREATE CLUSTERED INDEX [cftPGStatusUpd0]
    ON [dbo].[cftPGStatusUpd]([PigGroupID] ASC, [BatNbr] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 90);

