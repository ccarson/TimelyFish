 Create Proc ED850Header_ByUpdateStatus @UpdateStatus varchar(2) As
Select * From ED850Header Where UpdateStatus = @UpdateStatus


