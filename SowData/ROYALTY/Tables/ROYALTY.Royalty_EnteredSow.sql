CREATE TABLE [ROYALTY].[Royalty_EnteredSow] (
    [Period]   VARCHAR (64)    NULL,
    [farmid]   VARCHAR (8)     NOT NULL,
    [SowId]    VARCHAR (21)    NOT NULL,
    [genetics] VARCHAR (20)    NULL,
    [PIC]      DECIMAL (38, 6) NULL,
    [GP]       DECIMAL (38, 6) NULL,
    [NL]       DECIMAL (38, 6) NULL,
    [Other]    DECIMAL (38, 6) NULL
);

