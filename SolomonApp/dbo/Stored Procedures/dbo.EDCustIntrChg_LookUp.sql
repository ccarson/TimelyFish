 Create Proc EDCustIntrChg_LookUp @SenderId varchar(15) As
Select Count(*), Max(CustId) From EDCustIntrChg Where Qualifier = 'ZZ' And Id = @SenderId


