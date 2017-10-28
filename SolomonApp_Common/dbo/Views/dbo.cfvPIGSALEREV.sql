Create View cfvPIGSALEREV
AS
Select s.*
From cftPigSale s
LEFT JOIN cftPigSale AS reverse2 ON s.RefNbr=reverse2.OrigRefNbr
Where s.ARRefNbr<>'' AND s.DocType<>'RE' AND ISNULL(reverse2.RefNbr,'')=''

