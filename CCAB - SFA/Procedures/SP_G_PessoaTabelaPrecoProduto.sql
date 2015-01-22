set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_PessoaTabelaPrecoProduto.sql
**		Name: SP_G_PessoaTabelaPrecoProduto
**		Desc: Obtem registros da tabela PessoaTabelaPrecoProduto
**
**		Auth: Convergence
**		Date: 19/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_PessoaTabelaPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_PessoaTabelaPrecoProduto]
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
