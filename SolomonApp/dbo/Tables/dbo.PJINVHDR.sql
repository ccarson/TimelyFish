CREATE TABLE [dbo].[PJINVHDR] (
    [approver_id]       CHAR (10)     NOT NULL,
    [ar_post_code]      CHAR (4)      NOT NULL,
    [ASID]              INT           NOT NULL,
    [BaseCuryId]        CHAR (4)      NOT NULL,
    [batch_id]          CHAR (10)     NOT NULL,
    [begin_date]        SMALLDATETIME NOT NULL,
    [CpnyId]            CHAR (10)     NOT NULL,
    [crtd_datetime]     SMALLDATETIME NOT NULL,
    [crtd_prog]         CHAR (8)      NOT NULL,
    [crtd_user]         CHAR (10)     NOT NULL,
    [CuryEffDate]       SMALLDATETIME NOT NULL,
    [CuryId]            CHAR (4)      NOT NULL,
    [CuryMultDiv]       CHAR (1)      NOT NULL,
    [CuryRate]          FLOAT (53)    NOT NULL,
    [CuryRateType]      CHAR (6)      NOT NULL,
    [Curygross_amt]     FLOAT (53)    NOT NULL,
    [Curyother_amt]     FLOAT (53)    NOT NULL,
    [Curypaid_amt]      FLOAT (53)    NOT NULL,
    [Curyretention_amt] FLOAT (53)    NOT NULL,
    [Curytax_amt]       FLOAT (53)    NOT NULL,
    [customer]          CHAR (15)     NOT NULL,
    [docdesc]           CHAR (30)     NOT NULL,
    [doctype]           CHAR (2)      NOT NULL,
    [draft_num]         CHAR (10)     NOT NULL,
    [end_date]          SMALLDATETIME NOT NULL,
    [end_period]        CHAR (6)      NOT NULL,
    [fiscalno]          CHAR (6)      NOT NULL,
    [gross_amt]         FLOAT (53)    NOT NULL,
    [ih_id01]           CHAR (30)     NOT NULL,
    [ih_id02]           CHAR (30)     NOT NULL,
    [ih_id03]           CHAR (16)     NOT NULL,
    [ih_id04]           CHAR (16)     NOT NULL,
    [ih_id05]           CHAR (4)      NOT NULL,
    [ih_id06]           FLOAT (53)    NOT NULL,
    [ih_id07]           FLOAT (53)    NOT NULL,
    [ih_id08]           SMALLDATETIME NOT NULL,
    [ih_id09]           SMALLDATETIME NOT NULL,
    [ih_id10]           SMALLINT      NOT NULL,
    [ih_id11]           CHAR (30)     NOT NULL,
    [ih_id12]           CHAR (30)     NOT NULL,
    [ih_id13]           CHAR (4)      NOT NULL,
    [ih_id14]           CHAR (20)     NOT NULL,
    [ih_id15]           CHAR (10)     NOT NULL,
    [ih_id16]           CHAR (10)     NOT NULL,
    [ih_id17]           CHAR (10)     NOT NULL,
    [ih_id18]           CHAR (4)      NOT NULL,
    [ih_id19]           FLOAT (53)    NOT NULL,
    [ih_id20]           SMALLDATETIME NOT NULL,
    [invoice_date]      SMALLDATETIME NOT NULL,
    [invoice_num]       CHAR (10)     NOT NULL,
    [invoice_type]      CHAR (4)      NOT NULL,
    [inv_attach_cd]     CHAR (4)      NOT NULL,
    [inv_format_cd]     CHAR (4)      NOT NULL,
    [inv_status]        CHAR (2)      NOT NULL,
    [last_bill_date]    SMALLDATETIME NOT NULL,
    [lupd_datetime]     SMALLDATETIME NOT NULL,
    [lupd_prog]         CHAR (8)      NOT NULL,
    [lupd_user]         CHAR (10)     NOT NULL,
    [noteid]            INT           NOT NULL,
    [other_amt]         FLOAT (53)    NOT NULL,
    [paid_amt]          FLOAT (53)    NOT NULL,
    [preparer_id]       CHAR (10)     NOT NULL,
    [project_billwith]  CHAR (16)     NOT NULL,
    [retention_amt]     FLOAT (53)    NOT NULL,
    [ShipperID]         CHAR (15)     DEFAULT (' ') NOT NULL,
    [slsperid]          CHAR (10)     NOT NULL,
    [start_period]      CHAR (6)      NOT NULL,
    [tax_amt]           FLOAT (53)    NOT NULL,
    [WSID]              INT           NOT NULL,
    [tstamp]            ROWVERSION    NOT NULL,
    CONSTRAINT [pjinvhdr0] PRIMARY KEY CLUSTERED ([draft_num] ASC) WITH (FILLFACTOR = 90)
);


GO
CREATE NONCLUSTERED INDEX [pjinvhdr1]
    ON [dbo].[PJINVHDR]([invoice_num] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvhdr2]
    ON [dbo].[PJINVHDR]([inv_status] ASC) WITH (FILLFACTOR = 90);


GO
CREATE NONCLUSTERED INDEX [pjinvhdr3]
    ON [dbo].[PJINVHDR]([project_billwith] ASC) WITH (FILLFACTOR = 90);

