
create proc Batch_P1
	@parm1 varchar(10),
	@parm2 varchar(100)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS

select
	* 
	from
		batch
	where
		cpnyid like @parm1 and
		Status in ('B','S') and
		module ='PA' and
		JrnlType = 'TFR' and 
		cpnyid in  (select cpnyid from dbo.UserAccessCpny(@parm2))

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Batch_P1] TO [MSDSL]
    AS [dbo];

