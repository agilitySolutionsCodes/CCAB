set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_ProdutoTipoCultura.sql
**		Name: SP_G_ProdutoTipoCultura
**		Desc: Obtem registros da tabela ProdutoTipoCultura
**
**		Auth: Convergence
**		Date: 13/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ProdutoTipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ProdutoTipoCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_ProdutoTipoCultura]
AS
 
	--seleção
	SELECT 
		 cdProdutoTipoCulturaSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,cdIndicadorStatusProdutoTipoCultura
		,wkProdutoTipoCultura
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

	FROM
		ProdutoTipoCultura (nolock)
