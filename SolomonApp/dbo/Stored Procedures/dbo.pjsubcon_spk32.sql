 create Procedure pjsubcon_spk32 @parm1 varchar (10) , @parm2 varchar (15) , @parm3 varchar (1) , @parm4 varchar (4) , @parm5 varchar (16) ,
@parm6 varchar (16) , @parm7 varchar (16) , @parm8 varchar (16) , @parm9 varchar (16) , @parm10 varchar (16) , @parm11 varchar (16) , @parm12 varchar(100), @parm13 varchar(10)
WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select COUNT(*) from pjsubcon, pjproj
where    pjsubcon.project          =    pjproj.project
and      pjproj.manager1           like @parm1
and      pjsubcon.vendid           like @parm2
and      pjsubcon.status_sub       like @parm3
and      pjsubcon.su_id15          =    @parm4
and      pjsubcon.project          like @parm5
and      (pjsubcon.subcontract     like @parm6  or
pjsubcon.subcontract     like @parm7  or
pjsubcon.subcontract     like @parm8  or
pjsubcon.subcontract     like @parm9  or
pjsubcon.subcontract     like @parm10 or
pjsubcon.subcontract     like @parm11
)
and pjsubcon.CpnyId in (select cpnyid from dbo.UserAccessCpny(@parm12)) and pjsubcon.cpnyID like @parm13

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjsubcon_spk32] TO [MSDSL]
    AS [dbo];

