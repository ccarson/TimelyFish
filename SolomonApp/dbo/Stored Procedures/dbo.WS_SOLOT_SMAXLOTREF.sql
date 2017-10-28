 create procedure WS_SOLOT_SMAXLOTREF  @parm1 varchar (15), @parm2 varchar(10), @parm3 varchar(5), @parm4 varchar(5)   as  
select max(LotSerRef) from solot where OrdNbr = @parm1 and CpnyID = @parm2 and LineRef = @parm3 and SchedRef = @parm4

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOLOT_SMAXLOTREF] TO [MSDSL]
    AS [dbo];

