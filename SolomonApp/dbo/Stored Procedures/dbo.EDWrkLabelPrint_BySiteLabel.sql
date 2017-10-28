 CREATE Proc EDWrkLabelPrint_BySiteLabel As
Select * From EDWrkLabelPrint Order By SiteId, INIFileName,LabelDBPath,LabelFileName,NbrCopy, ShipperId


