 CREATE PROCEDURE EDSOShipheader_Shipper_CpnyID @parm1 varchar(15), @parm2 varchar(10) AS
select * From edsoshipheader
where shipperid = @parm1 and cpnyid = @Parm2
order by shipperid, cpnyid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSOShipheader_Shipper_CpnyID] TO [MSDSL]
    AS [dbo];

