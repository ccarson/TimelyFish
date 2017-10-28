Create Procedure pCF321TMDateLookup @parm1 varchar (6), @parm2 varchar(10) as 
    Select * from cf321vTMPriceDate Where MillId = @parm1 and DateLookup like @parm2 Order by DateLookup
