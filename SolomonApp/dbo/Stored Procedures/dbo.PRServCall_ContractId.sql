 Create Proc PRServCall_ContractId @parm1 varchar(15), @parm2 varchar(10),
                                  @parm3 varchar(10) as
        Select * from smContract
                where CustId = @parm1
                  and SiteId = @parm2
                  and ContractId like @parm3
                  and Status = 'A'
        Order by CustId,SiteId,ContractId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PRServCall_ContractId] TO [MSDSL]
    AS [dbo];

