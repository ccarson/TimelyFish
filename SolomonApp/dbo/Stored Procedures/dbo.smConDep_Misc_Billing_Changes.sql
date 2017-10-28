 CREATE PROCEDURE smConDep_Misc_Billing_Changes  @parm1 varchar(10), @parm2 varchar(1) AS
        DECLARE @Total float

        IF @parm2 = 'U'
        BEGIN
            select @Total = coalesce(sum(extprice),0)
              from smConMisc
             where ContractID = @parm1
               and status = 'A'

            select @Total = @Total - coalesce(sum(amount-amtapplied),0)
              from smConDeposit
             where ContractID = @parm1
               and status = 'A'
        END
        ELSE
        BEGIN
            select @Total = coalesce(sum(extprice),0)
              from smConMisc
             where ContractID = @parm1
               and status = 'I'

            select @Total = @Total - coalesce(sum(amtapplied),0)
              from smConDeposit
             where ContractID = @parm1
               and status = 'I'

            select @Total = @Total - coalesce(sum(amtapplied),0)
              from smConDeposit
             where ContractID = @parm1
               and status = 'A'
        END

        select @Total


