 Create Procedure ARDoc_CustID_Rlsed4 @parm1 varchar ( 15), @parm2 varchar ( 6), @parm3 varchar(47), @parm4 varchar(7), @parm5 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from ARDoc, Currncy
Where ARDoc.CuryId = Currncy.CuryId and
ARDoc.CustId = @parm1 and
ARDoc.curyDocBal <> 0 and
ARDoc.DocType <> 'AD' and
ARDoc.Rlsed = 1	 and
ARdoc.PerPost > @parm2 and
ardoc.cpnyid in

(select Cpnyid
 from vs_share_usercpny
   where userid = @parm3
   and scrn = @parm4
   and seclevel >= @parm5)

Order by CustId DESC, DocDate DESC


