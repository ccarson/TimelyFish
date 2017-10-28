 Create Procedure pjactrol_ssuma @parm1 varchar (4) , @parm2 varchar (16)  , @parm3 varchar (2) , @parm4 varchar (1)  as
select SUM ( pjactrol.amount_bf ),
SUM ( pjactrol.amount_01 ),
SUM ( pjactrol.amount_02 ),
SUM ( pjactrol.amount_03 ),
SUM ( pjactrol.amount_04 ),
SUM ( pjactrol.amount_05 ),
SUM ( pjactrol.amount_06 ),
SUM ( pjactrol.amount_07 ),
SUM ( pjactrol.amount_08 ),
SUM ( pjactrol.amount_09 ),
SUM ( pjactrol.amount_10 ),
SUM ( pjactrol.amount_11 ),
SUM ( pjactrol.amount_12 ),
SUM ( pjactrol.amount_13 ),
SUM ( pjactrol.amount_14 ),
SUM ( pjactrol.amount_15 ),
SUM ( pjactrol.units_bf ),
SUM ( pjactrol.units_01 ),
SUM ( pjactrol.units_02 ),
SUM ( pjactrol.units_03 ),
SUM ( pjactrol.units_04 ),
SUM ( pjactrol.units_05 ),
SUM ( pjactrol.units_06 ),
SUM ( pjactrol.units_07 ),
SUM ( pjactrol.units_08 ),
SUM ( pjactrol.units_09 ),
SUM ( pjactrol.units_10 ),
SUM ( pjactrol.units_11 ),
SUM ( pjactrol.units_12 ),
SUM ( pjactrol.units_13 ),
SUM ( pjactrol.units_14 ),
SUM ( pjactrol.units_15 ),
SUM ( pjactrol.ProjCury_amount_bf ),
SUM ( pjactrol.ProjCury_amount_01 ),
SUM ( pjactrol.ProjCury_amount_02 ),
SUM ( pjactrol.ProjCury_amount_03 ),
SUM ( pjactrol.ProjCury_amount_04 ),
SUM ( pjactrol.ProjCury_amount_05 ),
SUM ( pjactrol.ProjCury_amount_06 ),
SUM ( pjactrol.ProjCury_amount_07 ),
SUM ( pjactrol.ProjCury_amount_08 ),
SUM ( pjactrol.ProjCury_amount_09 ),
SUM ( pjactrol.ProjCury_amount_10 ),
SUM ( pjactrol.ProjCury_amount_11 ),
SUM ( pjactrol.ProjCury_amount_12 ),
SUM ( pjactrol.ProjCury_amount_13 ),
SUM ( pjactrol.ProjCury_amount_14 ),
SUM ( pjactrol.ProjCury_amount_15 )
from pjactrol, pjacct
where pjactrol.fsyear_num = @parm1 and
pjactrol.project = @parm2 and
pjactrol.acct =  pjacct.acct  and
pjacct.acct_type like @parm3 and
pjacct.id3_sw like @parm4



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjactrol_ssuma] TO [MSDSL]
    AS [dbo];

