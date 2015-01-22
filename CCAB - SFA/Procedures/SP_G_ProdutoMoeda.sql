set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_ProdutoMoeda.sql
**		Name: SP_G_ProdutoMoeda
**		Desc: Obtem registros da tabela ProdutoMoeda
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ProdutoMoeda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ProdutoMoeda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_ProdutoMoeda]
AS
 
	--seleção
	SELECT 
		 cdProdutoMoedaSEQ
		,cdProdutoSEQ
		,cdIndicadorMoedaProduto
		,cdIndicadorStatusProdutoMoeda
		,wkProdutoMoeda
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

	FROM
		ProdutoMoeda (nolock)
