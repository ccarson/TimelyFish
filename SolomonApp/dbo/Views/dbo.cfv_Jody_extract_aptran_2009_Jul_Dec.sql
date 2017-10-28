
 
create VIEW [dbo].[cfv_Jody_extract_aptran_2009_Jul_Dec]
AS
SELECT 
     a.BatNbr AS [Batch Number],
     a.RefNbr AS [Reference Number], a.VendId AS [Vendor ID], 
     CASE WHEN CHARINDEX('~', v.Name) > 0 THEN CONVERT(CHAR(60), 
       LTRIM(SUBSTRING(v.Name, 1, CHARINDEX('~',v.Name) - 1)) + ', ' + LTRIM(RTRIM(SUBSTRING(v.Name, CHARINDEX('~',v.Name) + 1, 60)))) ELSE v.Name END AS [Vendor Name], 
     a.trantype AS [Transaction Type],
      a.TranDesc AS [Transaction Description], convert(date,a.TranDate) AS [Transaction Date], 
      a.TranAmt AS [Transaction Amount], 
     convert(date,a.Crtd_DateTime) AS [Create Date]
     ,a.Crtd_User AS [Create User],
      a.DrCr AS [Debit/Credit], 
     b.invcnbr, b.invcdate
FROM    Aptran a with (nolock)
        INNER JOIN Vendor v with (nolock) ON a.VendID = v.VendId
        INNER JOIN Apdoc b with (nolock) ON a.batnbr = b.batnbr
        and a.RefNbr = b.RefNbr 
  where 1=1
  and a.TranDate >='2009-07-01' 
  and a.TranDate < '2010-01-01'			--<'2013-01-01'


