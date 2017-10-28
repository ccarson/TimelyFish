CREATE Procedure [dbo].[cfpDeletesmSOAddress]
	@CustID varchar(15)

	AS

	Delete from smsoaddress where custid = @custid


