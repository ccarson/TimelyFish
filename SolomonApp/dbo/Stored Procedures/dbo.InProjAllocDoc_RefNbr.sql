
create proc InProjAllocDoc_RefNbr @Parm1 varchar(15) as
      Select * from InProjAllocDoc where 
           RefNbr Like @Parm1
      Order By RefNbr
