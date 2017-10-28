Create Proc  [dbo].[PRTABLEHEADERAudt_PayTblId2] @parm1 varchar ( 4), @parm2 varchar ( 4) as
       Select * from PRTableHeaderAudt
           where PayTblId like @parm1 and
	     CalYr like @parm2 
           order by PayTblId, calyr, AudtDateSort desc

