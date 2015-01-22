set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_U_LiberaCompromissoCompra
**		Name: SP_U_LiberaCompromissoCompra
**		Desc: Efetua a Liberacao do Compromisso de Compra
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_LiberaCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_LiberaCompromissoCompra]
END
GO	

CREATE PROCEDURE [dbo].[SP_U_LiberaCompromissoCompra]
	 @arCompromissoCompra			varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint
AS




DECLARE 
	 @DELIMITADOR					VARCHAR(100)
	,@S								VARCHAR(8000)
	,@cdSolicitacaoEnvioEmailSEQ	bigint

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

	--Envio de Email Inicial, contendo dados para o Primeiro Login
	EXEC SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra
		 @cdCompromissoCompraSEQ				= @S
		,@cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
		,@cdSolicitacaoEnvioEmailSEQ			= @cdSolicitacaoEnvioEmailSEQ


		SELECT 
			@arCompromissoCompra = SUBSTRING(@arCompromissoCompra, CHARINDEX(@DELIMITADOR, @arCompromissoCompra) + 1, LEN(@arCompromissoCompra))
	END

	-- Libera Compromisso de Compra

	--CompromissoCompraItemHistorico
	UPDATE	CompromissoCompra
	SET		cdIndicadorStatusCompromissoCompra = 5 -- Liberado para a Cooperativa
	       ,dtUltimaAlteracao = getdate()
	       ,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao 
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusCompromissoCompra in (3,6)

	DROP TABLE #ARRAY


SET QUOTED_IDENTIFIER OFF

