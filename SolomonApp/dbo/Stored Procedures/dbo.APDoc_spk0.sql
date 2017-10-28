 create procedure APDoc_spk0 @parm1 varchar (10)  as
select * from APDoc
where    RefNbr  LIKE @parm1
and    DocType =    'VO'
and    Status  =    'A'
order by RefNbr,
DocType



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_spk0] TO [MSDSL]
    AS [dbo];

