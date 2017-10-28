 Create procedure PJJNTHDR_SALL  @parm1 varchar (15) , @parm2 varchar (16)   as
select * from PJJNTHDR
where    vendid     LIKE  @parm1 and
project    LIKE  @parm2
order by vendid, project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJJNTHDR_SALL] TO [MSDSL]
    AS [dbo];

