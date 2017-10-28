CREATE TABLE [dbo].[WrkAPDoc] (
    [AccessNbr] INT       NOT NULL,
    [DocType]   CHAR (2)  NOT NULL,
    [RefNbr]    CHAR (10) NOT NULL,
    CONSTRAINT [WrkAPDoc0] PRIMARY KEY NONCLUSTERED ([AccessNbr] ASC, [DocType] ASC, [RefNbr] ASC) WITH (FILLFACTOR = 80)
);

