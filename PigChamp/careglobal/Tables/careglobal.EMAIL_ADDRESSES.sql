CREATE TABLE [careglobal].[EMAIL_ADDRESSES] (
    [group_id]      INT          NOT NULL,
    [email_address] VARCHAR (50) NOT NULL,
    [email_type]    SMALLINT     NOT NULL,
    CONSTRAINT [PK_EMAIL_ADDRESSES] PRIMARY KEY CLUSTERED ([group_id] ASC, [email_address] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_EMAIL_ADDRESSES_EMAIL_GROUPS_0] FOREIGN KEY ([group_id]) REFERENCES [careglobal].[EMAIL_GROUPS] ([group_id]) ON DELETE CASCADE
);

