 Create Procedure APBalances_Vend_InCpny @parm1 varchar ( 15),  @parm2 varchar(47), @parm3 varchar(7), @parm4 varchar(1)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from AP_Balances
where VendID = @parm1
and Cpnyid in

(select Cpnyid
 from vs_share_usercpny
   where userid = @parm2
   and screennumber = @parm3+"00"
   and seclevel >= @parm4)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APBalances_Vend_InCpny] TO [MSDSL]
    AS [dbo];

