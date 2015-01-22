set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_tmpCompromissoCompraItem.sql
**		Name: SP_U_tmpCompromissoCompraItem
**		Desc: Altera um registro na tabela tmpCompromissoCompraItem
**
**		Auth: Convergence
**		Date: 03/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_tmpCompromissoCompraItem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_tmpCompromissoCompraItem]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_tmpCompromissoCompraItem]
	 @tmpCompromissoCompraItemSEQ	BIGINT
	,@tmpCompromissoCompraSEQ BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@cdCronogramaSafraVencimentoSEQ	BIGINT = NULL
	,@qtCompromissoCompraItem	NUMERIC(22,4) = NULL
	,@vrTotalMoedaCompromissoCompraItem	NUMERIC(22,4) = NULL
	,@vrTotalMoedaAbertoCompromissoCompraItem	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
 
AS

	--atualização
	UPDATE tmpCompromissoCompraItem SET
		tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
		,cdProdutoSEQ = @cdProdutoSEQ
		,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem = @qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem = @qtCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem = @qtCompromissoCompraItem * vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem = @qtCompromissoCompraItem * vrUnitarioMoedaCompromissoCompraItem
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 tmpCompromissoCompraItemSEQ = @tmpCompromissoCompraItemSEQ
 
 
