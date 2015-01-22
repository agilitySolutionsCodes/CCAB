set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_ProdutoMoeda.sql
**		Name: SP_I_ProdutoMoeda
**		Desc: Insere um registro na tabela ProdutoMoeda
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_ProdutoMoeda]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_ProdutoMoeda]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_ProdutoMoeda]
	 @cdProdutoSEQ	BIGINT
	,@cdIndicadorMoedaProduto	INT
	,@cdIndicadorStatusProdutoMoeda	INT
	,@wkProdutoMoeda	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdProdutoMoedaSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO ProdutoMoeda
	(
	 cdProdutoSEQ
	,cdIndicadorMoedaProduto
	,cdIndicadorStatusProdutoMoeda
	,wkProdutoMoeda
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @cdProdutoSEQ
	,@cdIndicadorMoedaProduto
	,@cdIndicadorStatusProdutoMoeda
	,@wkProdutoMoeda
	,getdate()
	,@cdUsuarioUltimaAlteracao
	)
 
	--retornos
	SELECT
		@cdProdutoMoedaSEQ = SCOPE_IDENTITY()
	SELECT
		@cdProdutoMoedaSEQ as cdProdutoMoedaSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdProdutoSEQ, int cdIndicadorMoedaProduto, int cdIndicadorStatusProdutoMoeda, string wkProdutoMoeda, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

			loSqlCommand.Parameters.Add("@cdIndicadorMoedaProduto", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorMoedaProduto"].Value = cdIndicadorMoedaProduto;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoMoeda", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusProdutoMoeda"].Value = cdIndicadorStatusProdutoMoeda;

		if (wkProdutoMoeda.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkProdutoMoeda", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkProdutoMoeda"].Value = wkProdutoMoeda;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

		loSqlCommand.Parameters.Add("@cdProdutoMoedaSEQ", SqlDbType.BigInt);
		loSqlCommand.Parameters["@cdProdutoMoedaSEQ"].Direction = ParameterDirection.Output;
 
Consistências:
		//Consistências
		if (cdProdutoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorMoedaProduto == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorStatusProdutoMoeda == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
