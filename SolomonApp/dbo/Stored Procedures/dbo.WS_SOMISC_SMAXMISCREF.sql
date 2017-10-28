 create procedure WS_SOMISC_SMAXMISCREF  @parm1 varchar (15), @parm2 varchar(10)   as  
select max(MiscChrgRef) from SOMisc where OrdNbr = @parm1 and CpnyID = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[WS_SOMISC_SMAXMISCREF] TO [MSDSL]
    AS [dbo];

