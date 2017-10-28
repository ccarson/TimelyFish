 CREATE PROCEDURE EDSOShipline_All  @Parm1 varchar(10),@parm2 varchar(15) as Select * from SOShipLine where cpnyid like @parm1 and shipperid like @parm2 order by cpnyid,shipperid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipline_All] TO [MSDSL]
    AS [dbo];

