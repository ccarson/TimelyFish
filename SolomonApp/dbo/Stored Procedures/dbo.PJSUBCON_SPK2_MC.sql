 create Procedure PJSUBCON_SPK2_MC @parm1 varchar (10) , @parm2 varchar (15) , @parm3 varchar (1) , @parm4 varchar (4), 
 @parm5 varchar(10), @parm6 varchar(100), @parm7 varchar (16)  
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select * from pjsubcon, pjproj
where    pjsubcon.project          =    pjproj.project
and      pjproj.manager1           like @parm1
and      pjsubcon.vendid           like @parm2
and      pjsubcon.status_sub       like @parm3
and      pjsubcon.su_id15          =    @parm4
and		 pjproj.cpnyID			   like @parm5
and      pjsubcon.project          like @parm7
and pjproj.CpnyId in

(select cpnyid from dbo.UserAccessCpny(@parm6))
  
order by
pjsubcon.project,
pjsubcon.subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SPK2_MC] TO [MSDSL]
    AS [dbo];

