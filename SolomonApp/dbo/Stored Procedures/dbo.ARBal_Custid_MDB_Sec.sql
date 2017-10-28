 Create Proc ARBal_Custid_MDB_Sec @parm1 varchar ( 15),  @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from AR_Balances where CustID = @parm1 and
	cpnyid in

(select Cpnyid
   from vs_share_usercpny
   where userid = @parm2
   and scrn = @parm3
   and seclevel >= @parm4 )

order by CpnyID, CustID


