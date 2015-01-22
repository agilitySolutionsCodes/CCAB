set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpPedidoVendaItemEntrega.sql
**		Name: SP_U_tmpPedidoVendaItemEntrega
**		Desc: Altera um registro na tabela tmpPedidoVendaItemEntrega
**
**		Auth: Convergence
**		Date: 09/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpPedidoVendaItemEntrega]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemEntrega]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpPedidoVendaItemEntrega]
	 @tmpPedidoVendaItemEntregaSEQ	BIGINT
	,@tmpPedidoVendaSEQ	BIGINT = NULL
	,@cdPedidoVendaSEQ	BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@dtAnoMesPedidoVendaItemEntrega datetime = NULL
	,@qtPedidoVendaItemEntrega	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
 
AS
 
	--atualização
	UPDATE tmpPedidoVendaItemEntrega SET
		 tmpPedidoVendaSEQ = @tmpPedidoVendaSEQ
		,cdProdutoSEQ = @cdProdutoSEQ
		,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		,dtAnoMesPedidoVendaItemEntrega = @dtAnoMesPedidoVendaItemEntrega
		,qtPedidoVendaItemEntrega = @qtPedidoVendaItemEntrega
		,cdIndicadorPedidoVendaItemEntrega = 1 -- cdIndicadorPedidoVendaItemEntrega (1-Digitado)
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 tmpPedidoVendaItemEntregaSEQ = @tmpPedidoVendaItemEntregaSEQ
 
