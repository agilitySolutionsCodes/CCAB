set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_ExcluiCompromissoCompra
**		Name: SP_D_ExcluiCompromissoCompra
**		Desc: Efetua a Exclusao do Compromisso de Compra
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_ExcluiCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_ExcluiCompromissoCompra]
END
GO	

CREATE PROCEDURE [dbo].[SP_D_ExcluiCompromissoCompra]
	 @arCompromissoCompra			varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint
AS


DECLARE 
	 @DELIMITADOR	VARCHAR(100)
	,@S				VARCHAR(8000)

	SELECT 
		@DELIMITADOR = ','

	IF LEN(@arCompromissoCompra) > 0
	BEGIN
		SELECT
			@arCompromissoCompra = @arCompromissoCompra + @DELIMITADOR 
	END

	CREATE TABLE 
		#ARRAY
	(ITEM_ARRAY	VARCHAR(max))

	WHILE LEN(@arCompromissoCompra) > 0
	BEGIN
		SELECT 
			@S = LTRIM(SUBSTRING(@arCompromissoCompra, 1, CHARINDEX(@DELIMITADOR, @arCompromissoCompra) - 1))
	   
		INSERT INTO 
			#ARRAY 
			(ITEM_ARRAY) 
		VALUES 
			(@S)

		SELECT 
			@arCompromissoCompra = SUBSTRING(@arCompromissoCompra, CHARINDEX(@DELIMITADOR, @arCompromissoCompra) + 1, LEN(@arCompromissoCompra))
	END

	-- Exclui Compromisso de Compra

	--CompromissoCompraItemHistorico
	DELETE	CompromissoCompraItemHistorico
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )

	-- CompromissoCompraItem
	DELETE	CompromissoCompraItem
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )

	-- CompromissoCompraHistorico	
	DELETE	CompromissoCompraHistorico
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusCompromissoCompra in (3)
	
	-- CompromissoCompra
	DELETE	CompromissoCompra
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusCompromissoCompra in (3)

	DROP TABLE #ARRAY


SET QUOTED_IDENTIFIER OFF

