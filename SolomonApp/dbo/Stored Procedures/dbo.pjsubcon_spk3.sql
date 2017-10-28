 Create Procedure pjsubcon_spk3 @parm1 varchar (10) , @parm2 varchar (15) , @parm3 varchar (1) , @parm4 varchar (4) , @parm5 varchar (16) , @parm6 varchar (16)  as
select * from pjsubcon, pjproj
where    pjsubcon.project          =    pjproj.project
and      pjproj.manager1           like @parm1
and      pjsubcon.vendid           like @parm2
and      pjsubcon.status_sub       like @parm3
and      pjsubcon.su_id15          =    @parm4
and      pjsubcon.project          like @parm5
and      pjsubcon.subcontract      like @parm6
order by
pjsubcon.project,
pjsubcon.subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pjsubcon_spk3] TO [MSDSL]
    AS [dbo];

