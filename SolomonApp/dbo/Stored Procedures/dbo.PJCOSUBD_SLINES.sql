 create procedure PJCOSUBD_SLINES  @parm1 varchar (16) , @parm2 varchar (16) , @parm3 varchar (4)   as
select * from PJCOSUBD
where project       =    @parm1 and
subcontract   =    @parm2 and
sub_line_item like @parm3
order by
project, subcontract, sub_line_item



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOSUBD_SLINES] TO [MSDSL]
    AS [dbo];

