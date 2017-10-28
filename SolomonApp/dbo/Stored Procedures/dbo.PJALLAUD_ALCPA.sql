
CREATE PROCEDURE PJALLAUD_ALCPA @parm1 varchar (6), @parm2 varchar (2), @parm3 varchar (10), @parm4 int, @parm5 varchar(30) AS

select * from PJALLAUD
where fiscalno = @parm1
  and system_cd = @parm2
  and batch_id = @parm3
  and detail_num = @parm4
  and data2 = @parm5
  and recalc_flag <> 'Y'


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJALLAUD_ALCPA] TO [MSDSL]
    AS [dbo];

