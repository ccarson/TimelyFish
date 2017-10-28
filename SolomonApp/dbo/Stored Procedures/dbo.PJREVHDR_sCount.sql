 create procedure  PJREVHDR_sCount @parm1 varchar (16) as
select count(*) from pjrevhdr
where
project like @parm1 and
revisiontype = 'cr' and
status in ('I','C','R')


