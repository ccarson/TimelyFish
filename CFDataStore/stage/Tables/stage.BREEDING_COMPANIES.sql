CREATE TABLE [stage].[BREEDING_COMPANIES] (
    [ID]               BIGINT       IDENTITY (1, 1) NOT NULL,
    [breeding_id]      INT          NOT NULL,
    [shortname]        VARCHAR (12) NOT NULL,
    [longname]         VARCHAR (30) NOT NULL,
    [disabled]         BIT          NOT NULL,
    [system]           BIT          NOT NULL,
    [synonym]          VARCHAR (5)  NULL,
    [creation_date]    DATETIME     NOT NULL,
    [created_by]       VARCHAR (15) NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_BREEDING_COMPANIES] PRIMARY KEY CLUSTERED ([breeding_id] ASC)
);

