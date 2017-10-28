﻿CREATE TABLE [dbo].[cftPGInvWt] (
    [LineNbr] SMALLINT   NOT NULL,
    [Wt]      FLOAT (53) NOT NULL,
    [tstamp]  ROWVERSION NULL,
    CONSTRAINT [cftPGInvWt0] PRIMARY KEY CLUSTERED ([LineNbr] ASC) WITH (FILLFACTOR = 90)
);
