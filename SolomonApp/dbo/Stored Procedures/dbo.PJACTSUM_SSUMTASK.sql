 create procedure PJACTSUM_SSUMTASK @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (32) , @parm4 varchar (16)  as
select SUM (amount_bf ),
SUM (amount_01 ),
SUM (amount_02 ),
SUM (amount_03 ),
SUM (amount_04 ),
SUM (amount_05 ),
SUM (amount_06 ),
SUM (amount_07 ),
SUM (amount_08 ),
SUM (amount_09 ),
SUM (amount_10 ),
SUM (amount_11 ),
SUM (amount_12 ),
SUM (amount_13 ),
SUM (amount_14 ),
SUM (amount_15 ),
SUM (units_bf ),
SUM (units_01 ),
SUM (units_02 ),
SUM (units_03 ),
SUM (units_04 ),
SUM (units_05 ),
SUM (units_06 ),
SUM (units_07 ),
SUM (units_08 ),
SUM (units_09 ),
SUM (units_10 ),
SUM (units_11 ),
SUM (units_12 ),
SUM (units_13 ),
SUM (units_14 ),
SUM (units_15 ),
SUM (ProjCury_amount_bf ),
SUM (ProjCury_amount_01 ),
SUM (ProjCury_amount_02 ),
SUM (ProjCury_amount_03 ),
SUM (ProjCury_amount_04 ),
SUM (ProjCury_amount_05 ),
SUM (ProjCury_amount_06 ),
SUM (ProjCury_amount_07 ),
SUM (ProjCury_amount_08 ),
SUM (ProjCury_amount_09 ),
SUM (ProjCury_amount_10 ),
SUM (ProjCury_amount_11 ),
SUM (ProjCury_amount_12 ),
SUM (ProjCury_amount_13 ),
SUM (ProjCury_amount_14 ),
SUM (ProjCury_amount_15 )
from PJACTSUM
where    fsyear_num = @parm1
and   project    = @parm2
and   pjt_entity like @parm3
and   acct       = @parm4
group by fsyear_num,
project,
substring(pjt_entity, 1, charindex('%', @parm3) - 1),
acct
order by fsyear_num,
project,
substring(pjt_entity, 1, charindex('%', @parm3) - 1),
acct



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJACTSUM_SSUMTASK] TO [MSDSL]
    AS [dbo];

