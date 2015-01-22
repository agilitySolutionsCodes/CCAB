set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_U_BloquearCompromissoCompra
**		Name: SP_U_BloquearCompromissoCompra
**		Desc: Efetua o Bloqueio do Compromisso de Compra
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_BloquearCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_BloquearCompromissoCompra]
END
GO	

CREATE PROCEDURE [dbo].[SP_U_BloquearCompromissoCompra]
	 @arCompromissoCompra			varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint
AS


DECLARE 
	 @DELIMITADOR	VARCHAR(100)
	,@S				VARCHAR(8000)
	,@cdSolicitacaoEnvioEmailSEQ		bigint

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
	EXEC SP_I_SolicitacaoEnvioEmail_BloquearCompromissoCompra
		 @cdCompromissoCompraSEQ				= @S
		,@cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
		,@cdSolicitacaoEnvioEmailSEQ			= @cdSolicitacaoEnvioEmailSEQ


		SELECT 
			@arCompromissoCompra = SUBSTRING(@arCompromissoCompra, CHARINDEX(@DELIMITADOR, @arCompromissoCompra) + 1, LEN(@arCompromissoCompra))
	END

	-- Bloqueia o Compromisso de Compra

	--CompromissoCompraItemHistorico
	UPDATE	CompromissoCompra
	SET		cdIndicadorStatusCompromissoCompra = 6 -- Bloquear Compromisso Compra
	       ,dtUltimaAlteracao = getdate()
	       ,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao 
	WHERE cdCompromissoCompraSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusCompromissoCompra in (5)

	DROP TABLE #ARRAY


SET QUOTED_IDENTIFIER OFF

