 create procedure DMG_TermsSelected
	@TermsID 	varchar(2),
	@Applyto 	varchar(1),
	@SOBehavior  	varchar(4),
	@COD		smallint OUTPUT
as
	SELECT	@COD = COD
	FROM 	Terms
	WHERE 	Applyto IN (@Applyto,'B')
	  AND 	((TermsType = 'S' and @SOBehavior in ('CM', 'DM'))
	  or 	(TermsType = TermsType and @SOBehavior NOT in ('CM', 'DM')))
	  AND 	TermsID = @TermsID

	if @@ROWCOUNT = 0 begin
		set @COD = 0
		return 0	--Failure
	end
	else begin
		return 1	--Success
	end


