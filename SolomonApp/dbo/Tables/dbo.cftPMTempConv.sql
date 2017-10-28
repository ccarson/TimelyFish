CREATE TABLE [dbo].[cftPMTempConv] (
    [ContactID] CHAR (10) NOT NULL,
    [CpnyID]    CHAR (10) NOT NULL,
    CONSTRAINT [PK_cftPMTempConv] PRIMARY KEY CLUSTERED ([ContactID] ASC, [CpnyID] ASC) WITH (FILLFACTOR = 90)
);

