Create Procedure [dbo].[pXF170_cfvBin_PV] @PigGroup varchar (6), @BinNBr varchar (6)  as 
 Select * from [cfvBinGroup]
 Where [PigGroup] = @PigGroup 
 and [BinNbr] Like @BinNBr 
 AND BinTypeDesc <> 'Creep'
 AND [Active] <> 0
 Order by [BinNbr]	