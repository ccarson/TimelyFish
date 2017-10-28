 create procedure PJRESTIM_SRESHDR @parm1 varchar (16) , @parm2 varchar (32) , @parm3 varchar (16)   as
select * from PJRESTIM
where    project       =     @parm1 and
pjt_entity    =     @parm2 and
acct          =     @parm3
order by project,
pjt_entity,
acct,
lineid DESC,
fiscalno


