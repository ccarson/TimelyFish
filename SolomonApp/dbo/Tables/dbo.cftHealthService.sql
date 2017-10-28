CREATE TABLE [dbo].[cftHealthService] (
    [Age]           CHAR (10)     NOT NULL,
    [ContactID]     CHAR (6)      NOT NULL,
    [Crtd_DateTime] SMALLDATETIME NOT NULL,
    [Crtd_Prog]     CHAR (8)      NOT NULL,
    [Crtd_User]     CHAR (10)     NOT NULL,
    [Lupd_DateTime] SMALLDATETIME NOT NULL,
    [Lupd_Prog]     CHAR (8)      NOT NULL,
    [Lupd_User]     CHAR (10)     NOT NULL,
    [NoteID]        INT           NOT NULL,
    [Tattoo]        CHAR (100)    NOT NULL,
    [VetContactID]  CHAR (6)      NOT NULL,
    [VetVisitDate]  SMALLDATETIME NOT NULL,
    [tstamp]        ROWVERSION    NULL,
    CONSTRAINT [PK_cftHealthService] PRIMARY KEY NONCLUSTERED ([ContactID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE UNIQUE CLUSTERED INDEX [cftHealthService0]
    ON [dbo].[cftHealthService]([ContactID] ASC) WITH (FILLFACTOR = 90);

