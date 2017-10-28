Create procedure projalloc_qty_Remaining_PONbr @PoNbr VarChar(10)
AS
select * from invprojalloc 
Where PONbr LIKE @PoNbr AND
      Srctype = 'POR' AND
      QtyRemainToIssue > 0.00
      Order By PoNbr

