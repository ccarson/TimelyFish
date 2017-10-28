 Create Proc Bankrec_Select_ARDoc @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 24), @parm4 smalldatetime, @parm5 smalldatetime, @parm6 smalldatetime, @parm7 varchar (1), @parm8 smallint  as
Select b.*, a.* from batch b join ardoc a on b.batnbr = a.batnbr cross join CASetup s
where b.cpnyid = @parm1
and b.bankacct = @parm2
and b.banksub = @parm3
and a.rlsed = 1
and b.battype NOT IN ('C','R')
and a.DocType IN ('PA', 'PP', 'CS', 'NS')
and b.module = 'AR'
AND NOT(b.editscrnnbr = '08030' AND b.Crtd_Prog = '08240')
and ((@parm7 = 'O' and b.dateent between s.accepttransdate and @parm5  and (b.Cleared = 0 or b.DateClr>@parm6))
  or (@parm7 = 'C' and b.cleared = 1 and b.dateclr > @parm4 and (b.dateclr <= @parm6 or @parm8=1 and b.dateent<=@parm5) and
  b.dateent >= s.accepttransdate)
  or (@parm7 = 'B' and ((b.cleared = 0 and b.dateent between s.accepttransdate and @parm5)
                    or (b.cleared = 1 and b.dateclr > @parm4 and (b.dateclr <= @parm6 or b.dateent<=@parm5) and
  b.dateent >= s.accepttransdate)
                       )
     )
     )
order by a.batnbr, a.refnbr, b.dateent


