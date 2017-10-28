
Create Procedure inprojallocDoc_Fetch @parm1 VarChar (15), @parm2 VarChar (10)
AS
SELECT * from inprojallocdoc 
Where RefNbr = @parm1 AND
      CpnyId = @parm2
