 create proc ADG_Precision_GetPrec
as

	If (select Count(*) from INSetup (NOLOCK)) > 0 and (Select Count(*) from SOSetup (NOLOCK)) > 0
	select	i.DecPlPrcCst,
		i.DecPlQty,
		s.DecPlNonStdQty
	from	INSetup i (NOLOCK),
		SOSetup s (NOLOCK)

	If (select Count(*) from INSetup (NOLOCK)) > 0 and (Select Count(*) from SOSetup (NOLOCK)) = 0
	select	i.DecPlPrcCst,
		i.DecPlQty,
		Convert(smallint, 9) DecPlNonStdQty
	from	INSetup i (NOLOCK)

	If (select Count(*) from INSetup (NOLOCK)) = 0 and (Select Count(*) from SOSetup (NOLOCK)) > 0
	select	Convert(smallint, 9) DecPlPrcCst,
		Convert(smallint, 9) DecPlQty,
		s.DecPlNonStdQty
	from	SOSetup s (NOLOCK)

	If (select Count(*) from INSetup (NOLOCK)) = 0 and (Select Count(*) from SOSetup (NOLOCK)) = 0
		If (select Count(*) from POSetup (NOLOCK)) > 0
		select	DecPlPrcCst,
			DecPlQty,
			Convert(smallint, 9) DecPlNonStdQty
		from	POSetup p (NOLOCK)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


