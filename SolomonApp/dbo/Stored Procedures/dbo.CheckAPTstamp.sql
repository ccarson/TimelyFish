
create procedure CheckAPTstamp @refnbr char (10) as 
declare @holdts1 binary(8)
declare @Doctype Char(2)
declare @Batnbr char (10)

BEGIN
 select @holdts1=max(tstamp), @batnbr=batnbr, @doctype=doctype
  from apdoc where refnbr = @refnbr and docclass = 'N' 
 group by batnbr, doctype
 select @holdts1= Case WHEN max(tstamp)> @holdts1 
                         THEN Max(tstamp)
                       ELSE @holdts1
                  END
   from batch 
  Where Module = 'AP' and BatNbr = @BatNbr
 select @holdts1= Case WHEN max(tstamp)> @holdts1 
                         THEN Max(tstamp)
                       ELSE @holdts1
                  END
   FROM Aptran
  WHERE RefNbr = @RefNbr 
    AND TranType = @Doctype
END

select APtimestamp = @holdts1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[CheckAPTstamp] TO [MSDSL]
    AS [dbo];

