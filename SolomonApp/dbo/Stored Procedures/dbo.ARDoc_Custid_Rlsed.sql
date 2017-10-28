 Create Procedure ARDoc_Custid_Rlsed @parm1 varchar ( 15), @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from ARDoc, Currncy
Where ARDoc.CuryId = Currncy.CuryId and
ARDoc.CustId = @parm1 and
ARDoc.Rlsed = 1 and
ARDoc.cpnyid in

(select Cpnyid
 from vs_share_usercpny
   where userid = @parm2
   and scrn = @parm3
   and seclevel >= @parm4)

Order by CustId DESC, DocDate DESC


