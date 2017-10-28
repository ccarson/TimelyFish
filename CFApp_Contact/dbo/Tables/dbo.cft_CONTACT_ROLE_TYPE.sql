CREATE TABLE [dbo].[cft_CONTACT_ROLE_TYPE] (
    [ContactID]       INT          NOT NULL,
    [RoleTypeID]      INT          NOT NULL,
    [CreatedDateTime] DATETIME     CONSTRAINT [DF_cft_CONTACT_ROLE_TYPE_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]       VARCHAR (50) NOT NULL,
    [UpdatedDateTime] DATETIME     NULL,
    [UpdatedBy]       VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_ROLE_TYPE] PRIMARY KEY CLUSTERED ([ContactID] ASC, [RoleTypeID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTACT_ROLE_TYPE_cft_CONTACT] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[cft_CONTACT] ([ContactID]) ON DELETE CASCADE
);

