
create Proc COMPANY_DBNAME_VS @parm1 varchar ( 50), @parm2 varchar ( 10) 
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
Select * from vs_Company where DatabaseName = @parm1 and CpnyID Like @parm2 and Active = 1 order by cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[COMPANY_DBNAME_VS] TO [MSDSL]
    AS [dbo];

