
create view XDD_vs_CEM_PV
AS

	Select 	Batch.BatNbr,
			Batch.Status,
			Batch.PerPost,
			XDDBatch.KeepDelete,
			XDDBatch.DepDate,
			APDoc.VendID
	from Batch LEFT OUTER JOIN XDDBatch  
	ON Batch.Module = 'AP' and Batch.BatNbr = XDDBatch.BatNbr RIGHT OUTER JOIN APDoc
	ON Batch.BatNbr = APDoc.BatNbr 
	where Batch.Module = 'AP' 
	and ( (Batch.EditScrnNbr = '03620' and Batch.Status IN ('U', 'P')) 
		or (Batch.EditScrnNbr = '03030' and Batch.Status IN ('U', 'P', 'H') and Batch.OrigScrnNbr = 'DD520')) 
	and APDoc.Status <> 'V' 
	and ((XDDBatch.FileType IS NOT NULL and XDDBatch.FileType IN ('E', 'W')) or XDDBatch.FileType IS NULL)

