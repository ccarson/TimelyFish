CREATE TABLE [ROYALTY].[GeneticComposition] (
    [genetics_id] INT             NOT NULL,
    [G1_Active]   BIT             NOT NULL,
    [PIC]         DECIMAL (10, 3) NOT NULL,
    [GP]          DECIMAL (10, 3) NOT NULL,
    [NL]          DECIMAL (10, 3) NOT NULL,
    [Other]       DECIMAL (10, 3) NOT NULL,
    [Notes]       VARCHAR (40)    NULL,
    PRIMARY KEY CLUSTERED ([genetics_id] ASC) WITH (FILLFACTOR = 90)
);

