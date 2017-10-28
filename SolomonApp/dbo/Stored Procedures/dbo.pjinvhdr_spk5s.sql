 Create Procedure pjinvhdr_spk5s @parm1 varchar (10) , @parm2 smalldatetime , @parm3 varchar (10) , @parm4 varchar (24), @parm5 varchar(6), @parm6 varchar(4)  as
-- Parm1 = Invoice Date Cutoff
-- Parm2 = Biller ID or '%' if not specified
-- Parm3 = gl subaccount
-- Parm4 = fiscal period
-- Parm6 = bill cury id
SELECT
h.draft_num, h.invoice_date, h.project_billwith, h.inv_status, h.Customer,
b.project, b.biller,
p.project, p.gl_subacct
FROM
pjinvhdr h, pjbill b, pjproj p
WHERE
h.project_billwith = b.project and
p.project = b.project and
h.cpnyid =  @parm1 and
h.invoice_date <=  @parm2 and
h.inv_status = 'PR' and
b.biller like @parm3 and
p.gl_subacct Like @parm4 and
h.fiscalno = @parm5 and
p.billcuryid = @parm6
ORDER BY
h.inv_status



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjinvhdr_spk5s] TO [MSDSL]
    AS [dbo];

