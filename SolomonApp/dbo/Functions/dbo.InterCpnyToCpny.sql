
create FUNCTION [dbo].[InterCpnyToCpny](@parm1 Varchar(10))
RETURNS  @rtnTable TABLE 
(
    -- columns returned by the function
    
    CpnyID varchar(10) NOT NULL
)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
BEGIN

insert into @rtnTable
SELECT vs_intercompany.ToCompany from vs_intercompany where FromCompany = @Parm1 and Module = 'ZZ'
return
END

