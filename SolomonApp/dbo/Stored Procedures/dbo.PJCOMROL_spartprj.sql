 create procedure PJCOMROL_spartprj @parm1 varchar (4) , @parm2 varchar (16) , @parm3 varchar (16), @parm4 varchar(100), @parm5 varchar(10)  as
select sum(amount_bf), sum(amount_01), sum(amount_02),
sum(amount_03), sum(amount_04), sum(amount_05),
sum(amount_06), sum(amount_07), sum(amount_08),
sum(amount_09), sum(amount_10), sum(amount_11),
sum(amount_12), sum(amount_13), sum(amount_14),
sum(amount_15),
sum(units_bf), sum(units_01), sum(units_02),
sum(units_03), sum(units_04), sum(units_05),
sum(units_06), sum(units_07), sum(units_08),
sum(units_09), sum(units_10), sum(units_11),
sum(units_12), sum(units_13), sum(units_14),
sum(units_15), fsyear_num,
sum(ProjCury_amount_bf), sum(ProjCury_amount_01), sum(ProjCury_amount_02),
sum(ProjCury_amount_03), sum(ProjCury_amount_04), sum(ProjCury_amount_05),
sum(ProjCury_amount_06), sum(ProjCury_amount_07), sum(ProjCury_amount_08),
sum(ProjCury_amount_09), sum(ProjCury_amount_10), sum(ProjCury_amount_11),
sum(ProjCury_amount_12), sum(ProjCury_amount_13), sum(ProjCury_amount_14),
sum(ProjCury_amount_15)
from PJCOMROL
where    fsyear_num = @parm1
and    project    like @parm2
and    acct       = @parm3
And Exists(
select project from PJPROJ
where pjproj.CpnyId in (select cpnyid from dbo.UserAccessCpny(@parm4)) and
pjproj.CpnyId like @parm5 and
pjproj.project = pjcomrol.project
) 
group by
fsyear_num


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOMROL_spartprj] TO [MSDSL]
    AS [dbo];

