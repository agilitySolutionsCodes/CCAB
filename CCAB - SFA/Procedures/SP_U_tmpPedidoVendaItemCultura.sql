set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVendaItemCultura.sql
**		Name: SP_U_tmpPedidoVendaItemCultura
**		Desc: Altera um registro na tabela tmpPedidoVendaItemCultura
**
**		Auth: Convergence
**		Date: 09/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVendaItemCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemCultura]
	 @tmpPedidoVendaItemCulturaSEQ	BIGINT
	,@tmpPedidoVendaSEQ	BIGINT = NULL
	,@cdPedidoVendaSEQ	BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@cdTipoCulturaSEQ BIGINT = NULL
	,@qtPedidoVendaItemCultura	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
 
AS
 
	--atualização
	UPDATE tmpPedidoVendaItemCultura SET
		 tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		,cdProdutoSEQ = @cdProdutoSEQ
		,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		,cdTipoCulturaSEQ = @cdTipoCulturaSEQ
		,qtPedidoVendaItemCultura = @qtPedidoVendaItemCultura
		,cdIndicadorPedidoVendaItemCultura = 1 -- cdIndicadorPedidoVendaItemcultura (1-Digitado)
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 tmpPedidoVendaItemCulturaSEQ = @tmpPedidoVendaItemCulturaSEQ
 
