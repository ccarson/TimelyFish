 CREATE Proc EDWrkPOToSO_CountBad @AccessNbr smallint As
Select Count(*) From EDWrkPOToSO Where POQty <> SOQty And AccessNbr = @AccessNbr


