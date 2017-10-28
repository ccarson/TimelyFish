CREATE TABLE [dbo].[matings] (
    [eventdate]        SMALLDATETIME NULL,
    [event_id]         INT           NULL,
    [identity_id]      INT           NULL,
    [supervisor_id]    INT           NULL,
    [male_identity_id] INT           NULL,
    [site_id]          INT           NULL
);


GO
CREATE NONCLUSTERED INDEX [cfi_matings]
    ON [dbo].[matings]([identity_id] ASC, [site_id] ASC, [eventdate] ASC)
    INCLUDE([event_id]) WITH (FILLFACTOR = 80);

