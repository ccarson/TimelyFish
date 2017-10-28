 Create Proc  PRTABLEHEADERAudt_PayTblId @parm1 varchar ( 4) as
       Select * from PRTableHeaderAudt
           where PayTblId like @parm1
	     
           order by PayTblId

