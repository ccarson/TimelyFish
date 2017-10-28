 Create Procedure pjactsum_ssuma
@parm1 varchar (4) , @parm2 varchar (16)  , @parm3 varchar (32) , @parm4 varchar (2) , @parm5 varchar (1)  as
select SUM ( pjactsum.amount_bf ),
SUM ( pjactsum.amount_01 ),
SUM ( pjactsum.amount_02 ),
SUM ( pjactsum.amount_03 ),
SUM ( pjactsum.amount_04 ),
SUM ( pjactsum.amount_05 ),
SUM ( pjactsum.amount_06 ),
SUM ( pjactsum.amount_07 ),
SUM ( pjactsum.amount_08 ),
SUM ( pjactsum.amount_09 ),
SUM ( pjactsum.amount_10 ),
SUM ( pjactsum.amount_11 ),
SUM ( pjactsum.amount_12 ),
SUM ( pjactsum.amount_13 ),
SUM ( pjactsum.amount_14 ),
SUM ( pjactsum.amount_15 ),
SUM ( pjactsum.ProjCury_amount_bf ),
SUM ( pjactsum.ProjCury_amount_01 ),
SUM ( pjactsum.ProjCury_amount_02 ),
SUM ( pjactsum.ProjCury_amount_03 ),
SUM ( pjactsum.ProjCury_amount_04 ),
SUM ( pjactsum.ProjCury_amount_05 ),
SUM ( pjactsum.ProjCury_amount_06 ),
SUM ( pjactsum.ProjCury_amount_07 ),
SUM ( pjactsum.ProjCury_amount_08 ),
SUM ( pjactsum.ProjCury_amount_09 ),
SUM ( pjactsum.ProjCury_amount_10 ),
SUM ( pjactsum.ProjCury_amount_11 ),
SUM ( pjactsum.ProjCury_amount_12 ),
SUM ( pjactsum.ProjCury_amount_13 ),
SUM ( pjactsum.ProjCury_amount_14 ),
SUM ( pjactsum.ProjCury_amount_15 ),
SUM ( pjactsum.units_bf ),
SUM ( pjactsum.units_01 ),
SUM ( pjactsum.units_02 ),
SUM ( pjactsum.units_03 ),
SUM ( pjactsum.units_04 ),
SUM ( pjactsum.units_05 ),
SUM ( pjactsum.units_06 ),
SUM ( pjactsum.units_07 ),
SUM ( pjactsum.units_08 ),
SUM ( pjactsum.units_09 ),
SUM ( pjactsum.units_10 ),
SUM ( pjactsum.units_11 ),
SUM ( pjactsum.units_12 ),
SUM ( pjactsum.units_13 ),
SUM ( pjactsum.units_14 ),
SUM ( pjactsum.units_15 )
from pjactsum, pjacct
where pjactsum.fsyear_num = @parm1 and
pjactsum.project = @parm2 and
pjactsum.pjt_entity = @parm3 and
pjactsum.acct =  pjacct.acct  and
pjacct.acct_type like @parm4 and
pjacct.id3_sw like @parm5



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjactsum_ssuma] TO [MSDSL]
    AS [dbo];

