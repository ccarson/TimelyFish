 Create Proc PriceClassesAR_Descr @parm1 varchar (6) as
    Select Descr from PriceClass where PriceClassID = @parm1 and PriceClassType = "C" order by PriceClassType, PriceClassid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PriceClassesAR_Descr] TO [MSDSL]
    AS [dbo];

