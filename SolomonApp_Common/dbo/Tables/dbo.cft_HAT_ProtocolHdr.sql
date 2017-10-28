CREATE TABLE [dbo].[cft_HAT_ProtocolHdr] (
    [SPID]          INT           IDENTITY (1, 1) NOT FOR REPLICATION NOT NULL,
    [Name]          VARCHAR (50)  NOT NULL,
    [Desc]          VARCHAR (100) NULL,
    [Active_cde]    VARCHAR (1)   NOT NULL,
    [Crtd_DateTime] DATETIME      DEFAULT (getdate()) NOT NULL,
    [Crtd_Prog]     VARCHAR (8)   DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Crtd_User]     VARCHAR (50)  DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Lupd_DateTime] DATETIME      DEFAULT (getdate()) NOT NULL,
    [Lupd_Prog]     VARCHAR (8)   DEFAULT (substring(host_name(),(1),(8))) NOT NULL,
    [Lupd_User]     VARCHAR (50)  DEFAULT (substring(original_login(),(1),(10))) NOT NULL,
    [Protocol_Type] VARCHAR (10)  DEFAULT ('          ') NOT NULL,
    CONSTRAINT [PK_cft_HAT_ProtocolHdr] PRIMARY KEY CLUSTERED ([SPID] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [idx_cft_HAT_protocolHdr_Ptype_acell_incl]
    ON [dbo].[cft_HAT_ProtocolHdr]([Protocol_Type] ASC, [Active_cde] ASC)
    INCLUDE([SPID]) WITH (FILLFACTOR = 90);

