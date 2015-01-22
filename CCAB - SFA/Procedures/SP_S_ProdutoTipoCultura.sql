set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_ProdutoTipoCultura.sql
**		Name: SP_S_ProdutoTipoCultura
**		Desc: Obtem um registro da tabela ProdutoTipoCultura
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_ProdutoTipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_ProdutoTipoCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_ProdutoTipoCultura]
	 @cdProdutoTipoCulturaSEQ	BIGINT
 
 
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
	WHERE 
		cdProdutoTipoCulturaSEQ = @cdProdutoTipoCulturaSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdProdutoTipoCulturaSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Value = cdProdutoTipoCulturaSEQ;
*/
