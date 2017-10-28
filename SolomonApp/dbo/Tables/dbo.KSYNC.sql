﻿CREATE TABLE [dbo].[KSYNC] (
    [SECTION]  VARCHAR (32)  NOT NULL,
    [KEYNAME]  VARCHAR (32)  NOT NULL,
    [KEYVALUE] VARCHAR (254) NULL,
    PRIMARY KEY CLUSTERED ([SECTION] ASC, [KEYNAME] ASC) WITH (FILLFACTOR = 90)
);
