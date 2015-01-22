set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_U_LiberaPedidoCCAB
**		Name: SP_U_LiberaPedidoCCAB
**		Desc: Efetua a liberação de Pedidos para a CCAB
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_LiberaPedidoCCAB]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_LiberaPedidoCCAB]
END
GO	

CREATE PROCEDURE [dbo].[SP_U_LiberaPedidoCCAB]
	 @arPedidoVenda					varchar(max)
	,@cdUsuarioUltimaAlteracao		bigint
AS


DECLARE 
	 @DELIMITADOR	VARCHAR(100)
	,@S				VARCHAR(8000)
	,@cdSolicitacaoEnvioEmailSEQ bigint

	SELECT 
		@DELIMITADOR = ','

	IF LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT
			@arPedidoVenda = @arPedidoVenda + @DELIMITADOR 
	END

	CREATE TABLE 
		#ARRAY
	(ITEM_ARRAY	VARCHAR(max))

	WHILE LEN(@arPedidoVenda) > 0
	BEGIN
		SELECT 
			@S = LTRIM(SUBSTRING(@arPedidoVenda, 1, CHARINDEX(@DELIMITADOR, @arPedidoVenda) - 1))
	   
		INSERT INTO 
			#ARRAY 
			(ITEM_ARRAY) 
		VALUES 
			(@S)
		
		-- 	Envia E-mail para os Colaboradores CCAB (Agente Comercial RC)
		--  Inativado temporariamente a pedido da CCAB (JorgeO
		/*
		EXEC SP_I_SolicitacaoEnvioEmail_LiberaPedidoCCAB
			 @cdPedidoVendaSEQ				= @S
			,@cdUsuarioUltimaAlteracao		= @cdUsuarioUltimaAlteracao
			,@cdSolicitacaoEnvioEmailSEQ	= @cdSolicitacaoEnvioEmailSEQ
		*/

		SELECT 
			@arPedidoVenda = SUBSTRING(@arPedidoVenda, CHARINDEX(@DELIMITADOR, @arPedidoVenda) + 1, LEN(@arPedidoVenda))
	END

	-- Atualiza Pedidos
	UPDATE	PedidoVenda
	SET	cdIndicadorStatusPedidoVenda = 2, -- Liberado para a CCAB
		dtEmissaoPedidoVenda = getdate(),
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusPedidoVenda in (1,4) -- 1(Digitado) 4(Rejeitado pela CCAB)

	UPDATE	PedidoVendaItem
	SET	cdIndicadorStatusPedidoVendaItem = 2, -- Liberado para a CCAB
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorStatusPedidoVendaItem in (1,4) -- 1(Digitado) 4(Rejeitado pela CCAB)

	UPDATE	PedidoVendaItemEntrega
	SET	cdIndicadorPedidoVendaItemEntrega = 2, -- Liberado para a CCAB
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorPedidoVendaItemEntrega in (1,4) -- 1(Digitado) 4(Rejeitado pela CCAB)

	UPDATE	PedidoVendaItemCultura
	SET	cdIndicadorPedidoVendaItemCultura = 2, -- Liberado para a CCAB
		dtUltimaAlteracao = getdate(),
		cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
	WHERE cdPedidoVendaSEQ in (	select	ITEM_ARRAY from #ARRAY )
	AND   cdIndicadorPedidoVendaItemCultura in (1,4) -- 1(Digitado) 4(Rejeitado pela CCAB)

	DROP TABLE #ARRAY


SET QUOTED_IDENTIFIER OFF

