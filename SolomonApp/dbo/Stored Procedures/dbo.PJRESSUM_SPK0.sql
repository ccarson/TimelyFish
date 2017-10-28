 create procedure PJRESSUM_SPK0 @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16) , @parm4 smallint   as
select * from PJRESSUM
where    project        =    @parm1 and
pjt_entity     =    @parm2 and
acct           =    @parm3 and
lineID         =    @parm4
order by project,
pjt_entity,
acct,
lineID DESC


