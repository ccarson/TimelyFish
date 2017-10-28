Create Procedure xTempScaleTkt_Open as 
    Select * from xTempScaleTkt Where Status = 'O' Order by TktNbr
