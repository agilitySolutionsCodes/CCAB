set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_ProdutoMoeda.sql
**		Name: SP_S_ProdutoMoeda
**		Desc: Obtem um registro da tabela ProdutoMoeda
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_ProdutoMoeda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_ProdutoMoeda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_ProdutoMoeda]
	 @cdProdutoMoedaSEQ	BIGINT
 
 
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
	WHERE 
		cdProdutoMoedaSEQ = @cdProdutoMoedaSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdProdutoMoedaSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Value = cdProdutoMoedaSEQ;
*/
