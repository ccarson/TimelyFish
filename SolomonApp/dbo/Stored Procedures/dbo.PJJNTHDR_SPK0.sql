 create procedure PJJNTHDR_SPK0  @parm1 varchar (15) , @parm2 varchar (16)   as
select * from PJJNTHDR
where    vendid     =     @parm1 and
project    LIKE  @parm2
order by vendid, project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJJNTHDR_SPK0] TO [MSDSL]
    AS [dbo];

