
Create Proc vs_SubXRef_Sub_w @parm1 varchar ( 10), @parm2 varchar ( 24) AS
 Select Sub, descr from vs_SubXRef where CpnyID = @parm1 and Active = 1 and sub = @parm2 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[vs_SubXRef_Sub_w] TO [MSDSL]
    AS [dbo];

