CREATE TABLE [ROYALTY].[Royalty_GPDetail] (
    [seqno]       INT             NULL,
    [period]      VARCHAR (64)    NULL,
    [farmid]      VARCHAR (8)     NULL,
    [sowid]       VARCHAR (12)    NULL,
    [eventid]     BIGINT          NOT NULL,
    [semenid]     VARCHAR (10)    NULL,
    [sowgenetics] VARCHAR (20)    NULL,
    [litter]      CHAR (50)       NULL,
    [D_PIC]       DECIMAL (38, 6) NULL,
    [D_GP]        DECIMAL (38, 6) NULL,
    [D_NL]        DECIMAL (38, 6) NULL,
    [D_Other]     DECIMAL (38, 6) NULL,
    [S_PIC]       DECIMAL (10, 3) NULL,
    [S_GP]        DECIMAL (10, 3) NULL,
    [S_NL]        DECIMAL (10, 3) NULL,
    [S_Other]     DECIMAL (10, 3) NULL
);

