 create procedure PJJNTDET_SPK0  @parm1 varchar (15) , @parm2 varchar (16) , @parm3beg smallint , @parm3end smallint   as
select * from PJJNTDET
where    vendid     =        @parm1 and
project    =        @parm2 and
linenbr    between  @parm3beg and @parm3end
order by vendid, project, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJJNTDET_SPK0] TO [MSDSL]
    AS [dbo];

