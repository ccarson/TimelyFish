create procedure PJPROJMX_SPK1L  @parm1 varchar (16), @parm2 varchar (32), @parm3 varchar (16) as
select  PJPROJMX.*, PJPTDROL.* from PJPROJMX, PJPTDROL
where    pjprojmx.project     =    @parm1 and
         pjprojmx.pjt_entity  =    @parm2 and
	   pjprojmx.acct	      like @parm3 and
	   pjprojmx.project     *= pjptdrol.project and
         pjprojmx.acct        *= pjptdrol.acct

order by pjprojmx.project, pjprojmx.pjt_entity, pjprojmx.acct
