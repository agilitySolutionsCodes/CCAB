set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_PessoaTabelaPrecoProduto.sql
**		Name: SP_S_PessoaTabelaPrecoProduto
**		Desc: Obtem um registro da tabela PessoaTabelaPrecoProduto
**
**		Auth: Convergence
**		Date: 19/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_PessoaTabelaPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_PessoaTabelaPrecoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_PessoaTabelaPrecoProduto]
	 @cdPessoaTabelaPrecoProdutoSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		 cdPessoaTabelaPrecoProdutoSEQ
		,cdPessoaSEQ
		,cdCronogramaSafraSEQ
		,cdProdutoSEQ
		,cdTipoCulturaSEQ
		,cdCronogramaSafraVencimentoSEQ
		,vrDolarPessoaTabelaPrecoProduto
		,vrRealPessoaTabelaPrecoProduto
		,pcDescontoPontualidadePessoaTabelaPrecoProduto
		,wkPessoaTabelaPrecoProduto
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao

	FROM
		PessoaTabelaPrecoProduto (nolock)
	WHERE 
		cdPessoaTabelaPrecoProdutoSEQ = @cdPessoaTabelaPrecoProdutoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdPessoaTabelaPrecoProdutoSEQ
 
Corpo:
loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;
*/
