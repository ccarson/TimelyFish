 Create Proc Vendor_apbalances @parm1 varchar(15), @parm2 varchar(10), @parm3 varChar(1) AS

Select V.*, A.*
FROM Vendor V JOIN AP_Balances A 
              ON V.Vendid = A.Vendid
WHERE V.Vendid LIKE @Parm1 AND
      A.CpnyID = @Parm2 AND
      V.Vend1099 = '1' AND
      V.Vendid <> '' AND
      (SELECT CASE @Parm3 WHEN 'C'  
                  THEN A.CYBox00 + A.CYBox01 + A.CYBox02 + A.CYBox03 + A.CYBox04 + A.CYBox05 +
                       A.CYBox06 + A.CYBox07 + A.CYBox08 + A.CYBox09 + A.CYBox10 + A.CYBox11 + A.CYBox12 + A.CYBox13 + A.CYBox14
                  ELSE A.NYBox00 + A.NYBox01 + A.NYBox02 + A.NYBox03 + A.NYBox04 + A.NYBox05 +
                       A.NYBox06 + A.NYBox07 + A.NYBox08 + A.NYBox09 + A.NYBox10 + A.NYBox11 + A.NYBox12 + A.NYBox13 + A.NYBox14
                  END) <> 0
ORDER BY V.Vendid


GO
GRANT CONTROL
    ON OBJECT::[dbo].[Vendor_apbalances] TO [MSDSL]
    AS [dbo];

