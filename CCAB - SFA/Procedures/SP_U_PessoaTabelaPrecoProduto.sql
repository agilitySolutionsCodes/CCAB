set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_PessoaTabelaPrecoProduto.sql
**		Name: SP_U_PessoaTabelaPrecoProduto
**		Desc: Altera um registro na tabela PessoaTabelaPrecoProduto
**
**		Auth: Convergence
**		Date: 19/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_PessoaTabelaPrecoProduto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_PessoaTabelaPrecoProduto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_PessoaTabelaPrecoProduto]
	 @cdPessoaTabelaPrecoProdutoSEQ	BIGINT
	,@cdPessoaSEQ	BIGINT
	,@cdCronogramaSafraSEQ	BIGINT
	,@cdProdutoSEQ	BIGINT
	,@cdCronogramaSafraVencimentoSEQ	BIGINT
	,@vrDolarPessoaTabelaPrecoProduto	NUMERIC(22,4)
	,@vrRealPessoaTabelaPrecoProduto	NUMERIC(22,4)
	,@pcDescontoPontualidadePessoaTabelaPrecoProduto	NUMERIC(8,4)
	,@wkPessoaTabelaPrecoProduto	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS
 
	--atualização
	UPDATE PessoaTabelaPrecoProduto SET
		 cdPessoaSEQ = @cdPessoaSEQ
		,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		,cdProdutoSEQ = @cdProdutoSEQ
		,cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
		,vrDolarPessoaTabelaPrecoProduto = @vrDolarPessoaTabelaPrecoProduto
		,vrRealPessoaTabelaPrecoProduto = @vrRealPessoaTabelaPrecoProduto
		,pcDescontoPontualidadePessoaTabelaPrecoProduto = @pcDescontoPontualidadePessoaTabelaPrecoProduto
		,wkPessoaTabelaPrecoProduto = @wkPessoaTabelaPrecoProduto
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 cdPessoaTabelaPrecoProdutoSEQ = @cdPessoaTabelaPrecoProdutoSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdPessoaTabelaPrecoProdutoSEQ, Int64 cdPessoaSEQ, Int64 cdCronogramaSafraSEQ, Int64 cdProdutoSEQ, Int64 cdTipoCulturaSEQ, Int64 cdCronogramaSafraVencimentoSEQ, double vrDolarPessoaTabelaPrecoProduto, double vrRealPessoaTabelaPrecoProduto, double pcDescontoPontualidadePessoaTabelaPrecoProduto, string wkPessoaTabelaPrecoProduto, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdPessoaTabelaPrecoProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdPessoaTabelaPrecoProdutoSEQ"].Value = cdPessoaTabelaPrecoProdutoSEQ;

			loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;

			loSqlCommand.Parameters.Add("@cdCronogramaSafraSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdCronogramaSafraSEQ"].Value = cdCronogramaSafraSEQ;

			loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

			loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

			loSqlCommand.Parameters.Add("@cdCronogramaSafraVencimentoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdCronogramaSafraVencimentoSEQ"].Value = cdCronogramaSafraVencimentoSEQ;

			loSqlCommand.Parameters.Add("@vrDolarPessoaTabelaPrecoProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@vrDolarPessoaTabelaPrecoProduto"].Value = vrDolarPessoaTabelaPrecoProduto;

			loSqlCommand.Parameters.Add("@vrRealPessoaTabelaPrecoProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@vrRealPessoaTabelaPrecoProduto"].Value = vrRealPessoaTabelaPrecoProduto;

			loSqlCommand.Parameters.Add("@pcDescontoPontualidadePessoaTabelaPrecoProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@pcDescontoPontualidadePessoaTabelaPrecoProduto"].Value = pcDescontoPontualidadePessoaTabelaPrecoProduto;

		if (wkPessoaTabelaPrecoProduto.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkPessoaTabelaPrecoProduto", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkPessoaTabelaPrecoProduto"].Value = wkPessoaTabelaPrecoProduto;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

 
Consistências:
		//Consistências
		if (cdPessoaTabelaPrecoProdutoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdPessoaSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdCronogramaSafraSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdProdutoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdTipoCulturaSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdCronogramaSafraVencimentoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (vrDolarPessoaTabelaPrecoProduto == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (vrRealPessoaTabelaPrecoProduto == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (pcDescontoPontualidadePessoaTabelaPrecoProduto == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
