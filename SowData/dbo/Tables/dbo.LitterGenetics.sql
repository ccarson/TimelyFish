CREATE TABLE [dbo].[LitterGenetics] (
    [LineNbr]     INT        NOT NULL,
    [GenLevel]    INT        NOT NULL,
    [PICWeek]     SMALLINT   NOT NULL,
    [PICYear]     SMALLINT   NOT NULL,
    [GeneticLine] CHAR (10)  NOT NULL,
    [GP]          FLOAT (53) NOT NULL,
    [PIC]         FLOAT (53) NOT NULL,
    [NL]          FLOAT (53) NOT NULL,
    [WgtCount]    INT        NULL
);

