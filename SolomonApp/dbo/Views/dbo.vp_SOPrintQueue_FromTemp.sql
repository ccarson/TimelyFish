 
create view vp_SOPrintQueue_FromTemp as
select RptNbr = ReportName, S4Future01 = '', S4Future02 = '', S4Future03 = 0, S4Future04 = 0, S4Future05 = 0, S4Future06 = 0, S4Future07 = '',
S4Future08 = '', S4Future09 = 0, S4Future10 = 0, S4Future11 = ReportName, S4Future12 = '', *
from SOPrintQueue_Temp


 
