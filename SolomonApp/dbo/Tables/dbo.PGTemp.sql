﻿CREATE TABLE [dbo].[PGTemp] (
    [PigGroupID] CHAR (10) NOT NULL,
    [CpnyID]     CHAR (10) NOT NULL,
    CONSTRAINT [pgtemp0] PRIMARY KEY CLUSTERED ([CpnyID] ASC, [PigGroupID] ASC) WITH (FILLFACTOR = 90)
);

