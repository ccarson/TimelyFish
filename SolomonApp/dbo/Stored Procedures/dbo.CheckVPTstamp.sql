
create procedure CheckVPTstamp @Batnbr char (10) as 
declare @holdts1 binary(8)

BEGIN
 select @holdts1=tstamp
  from batch where Module = 'VP' and BatNbr = @BatNbr 
 
 
 select @holdts1= Case WHEN max(tstamp)> @holdts1 
                         THEN Max(tstamp)
                       ELSE @holdts1
                  END
   FROM PRtran
  WHERE BatNbr = @BatNbr 
   
END

select VPtimestamp = @holdts1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CheckVPTstamp] TO [MSDSL]
    AS [dbo];

