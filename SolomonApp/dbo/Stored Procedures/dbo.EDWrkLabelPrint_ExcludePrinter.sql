 CREATE Proc EDWrkLabelPrint_ExcludePrinter @PrinterName varchar(20) As
Select * From EDWrkLabelPrint Where PrinterName <> @PrinterName
Order By SiteId, INIFileName,LabelDBPath,LabelFileName,NbrCopy, PrinterName, ShipperId


