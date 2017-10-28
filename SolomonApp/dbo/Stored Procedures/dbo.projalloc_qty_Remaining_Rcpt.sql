Create procedure projalloc_qty_Remaining_Rcpt @SrcNbr VarChar(15) 
AS
Select * from invprojalloc 
where SrcNbr LIKE @SrcNbr AND
      QtyRemainToIssue > 0.00
      Order By SrcNbr
