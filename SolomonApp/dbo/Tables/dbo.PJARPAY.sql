CREATE TABLE [dbo].[PJARPAY] (
    [applied_amt]    FLOAT (53)    NOT NULL,
    [check_refnbr]   CHAR (10)     NOT NULL,
    [crtd_datetime]  SMALLDATETIME NOT NULL,
    [crtd_prog]      CHAR (8)      NOT NULL,
    [crtd_user]      CHAR (10)     NOT NULL,
    [CustId]         CHAR (15)     NOT NULL,
    [discount_amt]   FLOAT (53)    NOT NULL,
    [doctype]        CHAR (2)      NOT NULL,
    [invoice_refnbr] CHAR (10)     NOT NULL,
    [invoice_type]   CHAR (2)      NOT NULL,
    [lupd_datetime]  SMALLDATETIME NOT NULL,
    [lupd_prog]      CHAR (8)      NOT NULL,
    [lupd_user]      CHAR (10)     NOT NULL,
    [pjt_entity]     CHAR (32)     NOT NULL,
    [Project]        CHAR (16)     NOT NULL,
    [status]         CHAR (1)      NOT NULL,
    [tstamp]         ROWVERSION    NOT NULL,
    CONSTRAINT [pjarpay0] PRIMARY KEY CLUSTERED ([CustId] ASC, [doctype] ASC, [check_refnbr] ASC, [invoice_refnbr] ASC, [invoice_type] ASC, [lupd_datetime] ASC, [applied_amt] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [pjarpay1]
    ON [dbo].[PJARPAY]([status] ASC) WITH (FILLFACTOR = 100);

