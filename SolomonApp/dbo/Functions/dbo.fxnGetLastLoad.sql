
CREATE Function [dbo].[fxnGetLastLoad]
	(@ThisTrailer as varchar(3), @ThisDate as smalldatetime, @ThisLoadTime as smalldatetime)
RETURNS integer

AS
BEGIN
DECLARE @ReturnID as integer

IF @ThisTrailer='' or @ThisLoadTime='1/1/1900 00:00:00'
	BEGIN
		SET @ReturnID=NULL
	END
ELSE
	BEGIN
		DECLARE @ID as integer, @LoadTime as smalldatetime, @TrailerWashFlg as smallint
			
		DECLARE Movement CURSOR FAST_FORWARD FOR 
		Select ID,LoadingTime,TrailerWashFlag from cftPM WITH (NOLOCK)
			where MovementDate=@ThisDate and PigTrailerID=@ThisTrailer and LoadingTime>=@ThisLoadTime
			order by LoadingTime,ArrivalTime ASC
		
		OPEN Movement
		
		FETCH NEXT FROM Movement INTO @ID ,@LoadTime, @TrailerWashFlg
		Set @ReturnID=@ID
		WHILE @@FETCH_STATUS = 0
		BEGIN
			IF @TrailerWashFlg=0 or @LoadTime=@ThisLoadTime
				BEGIN SET @ReturnID=@ID   
				FETCH NEXT FROM Movement INTO @ID ,@LoadTime, @TrailerWashFlg
			END
			ELSE
			BREAK
		END
		

		CLOSE Movement
		DEALLOCATE Movement
				
	END

RETURN @ReturnID 

END



GO
GRANT CONTROL
    ON OBJECT::[dbo].[fxnGetLastLoad] TO [MSDSL]
    AS [dbo];

