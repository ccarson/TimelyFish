CREATE TABLE [caredata].[VETERINARIANS] (
    [vet_id]           INT          IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [vet_company_id]   INT          NULL,
    [initials]         VARCHAR (4)  NOT NULL,
    [last_name]        VARCHAR (30) NULL,
    [first_name]       VARCHAR (30) NULL,
    [description]      VARCHAR (30) NULL,
    [synonym]          VARCHAR (5)  NULL,
    [disabled]         BIT          CONSTRAINT [DF_VETERINARIANS_disabled] DEFAULT ((0)) NOT NULL,
    [email]            VARCHAR (40) NULL,
    [creation_date]    DATETIME     CONSTRAINT [DF_VETERINARIANS_creation_date] DEFAULT (getdate()) NOT NULL,
    [created_by]       VARCHAR (15) CONSTRAINT [DF_VETERINARIANS_created_by] DEFAULT ('SYSTEM') NOT NULL,
    [last_update_date] DATETIME     NULL,
    [last_update_by]   VARCHAR (15) NULL,
    [deletion_date]    DATETIME     NULL,
    [deleted_by]       VARCHAR (15) NULL,
    CONSTRAINT [PK_VETERINARIANS] PRIMARY KEY CLUSTERED ([vet_id] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_VETERINARIANS_VET_COMPANIES_0] FOREIGN KEY ([vet_company_id]) REFERENCES [caredata].[VET_COMPANIES] ([vet_company_id]) ON DELETE CASCADE ON UPDATE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IDX_VETERINARIANS_0]
    ON [caredata].[VETERINARIANS]([initials] ASC, [deletion_date] ASC) WITH (FILLFACTOR = 90);

