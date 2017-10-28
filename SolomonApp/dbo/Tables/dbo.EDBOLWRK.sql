﻿CREATE TABLE [dbo].[EDBOLWRK] (
    [BOLClass] CHAR (20)  CONSTRAINT [DF_EDBOLWRK_BOLClass] DEFAULT (' ') NOT NULL,
    [BOLDesc]  CHAR (30)  CONSTRAINT [DF_EDBOLWRK_BOLDesc] DEFAULT (' ') NOT NULL,
    [BOLNbr]   CHAR (20)  CONSTRAINT [DF_EDBOLWRK_BOLNbr] DEFAULT (' ') NOT NULL,
    [HazMat]   CHAR (1)   CONSTRAINT [DF_EDBOLWRK_HazMat] DEFAULT (' ') NOT NULL,
    [NbrPkg]   FLOAT (53) CONSTRAINT [DF_EDBOLWRK_NbrPkg] DEFAULT ((0)) NOT NULL,
    [Weight]   FLOAT (53) CONSTRAINT [DF_EDBOLWRK_Weight] DEFAULT ((0)) NOT NULL,
    [tstamp]   ROWVERSION NOT NULL,
    CONSTRAINT [EDBOLWRK0] PRIMARY KEY CLUSTERED ([BOLNbr] ASC, [BOLClass] ASC) WITH (FILLFACTOR = 90)
);
