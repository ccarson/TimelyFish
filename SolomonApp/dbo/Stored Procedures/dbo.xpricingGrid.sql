CREATE PROCEDURE [dbo].[xpricingGrid]
	@parm1 varchar (10) As
	Select * from xfuturepricing
	Where PricingID like @parm1
        ORDER BY pricingID
