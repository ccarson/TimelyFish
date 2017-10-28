CREATE TABLE [dbo].[cft_CONTACT_AUTHORIZED] (
    [ContactID]           INT          NOT NULL,
    [AuthorizedContactID] INT          NOT NULL,
    [CreatedDateTime]     DATETIME     CONSTRAINT [DF_cft_CONTACT_AUTHORIZED_CreatedDateTime] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]           VARCHAR (50) NOT NULL,
    [UpdatedDateTime]     DATETIME     CONSTRAINT [DF_cft_CONTACT_AUTHORIZED_UpdatedDateTime] DEFAULT (getdate()) NULL,
    [UpdatedBy]           VARCHAR (50) NULL,
    CONSTRAINT [PK_cft_CONTACT_AUTHORIZED] PRIMARY KEY CLUSTERED ([ContactID] ASC, [AuthorizedContactID] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_cft_CONTACT_AUTHORIZED_cft_CONTACT] FOREIGN KEY ([ContactID]) REFERENCES [dbo].[cft_CONTACT] ([ContactID]) ON DELETE CASCADE,
    CONSTRAINT [FK_cft_CONTACT_AUTHORIZED_cft_CONTACT1] FOREIGN KEY ([AuthorizedContactID]) REFERENCES [dbo].[cft_CONTACT] ([ContactID])
);

