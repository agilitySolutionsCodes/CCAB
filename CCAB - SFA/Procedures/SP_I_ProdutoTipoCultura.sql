set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_ProdutoTipoCultura.sql
**		Name: SP_I_ProdutoTipoCultura
**		Desc: Insere um registro na tabela ProdutoTipoCultura
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_ProdutoTipoCultura]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_ProdutoTipoCultura]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_ProdutoTipoCultura]
	 @cdProdutoSEQ	BIGINT
	,@cdTipoCulturaSEQ	BIGINT
	,@cdIndicadorStatusProdutoTipoCultura	INT
	,@wkProdutoTipoCultura	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdProdutoTipoCulturaSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO ProdutoTipoCultura
	(
	 cdProdutoSEQ
	,cdTipoCulturaSEQ
	,cdIndicadorStatusProdutoTipoCultura
	,wkProdutoTipoCultura
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @cdProdutoSEQ
	,@cdTipoCulturaSEQ
	,@cdIndicadorStatusProdutoTipoCultura
	,@wkProdutoTipoCultura
	,getdate()
	,@cdUsuarioUltimaAlteracao
	)
 
	--retornos
	SELECT
		@cdProdutoTipoCulturaSEQ = SCOPE_IDENTITY()
	SELECT
		@cdProdutoTipoCulturaSEQ as cdProdutoTipoCulturaSEQ
 
 
/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdProdutoSEQ, Int64 cdTipoCulturaSEQ, int cdIndicadorStatusProdutoTipoCultura, string wkProdutoTipoCultura, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

			loSqlCommand.Parameters.Add("@cdTipoCulturaSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdTipoCulturaSEQ"].Value = cdTipoCulturaSEQ;

			loSqlCommand.Parameters.Add("@cdIndicadorStatusProdutoTipoCultura", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusProdutoTipoCultura"].Value = cdIndicadorStatusProdutoTipoCultura;

		if (wkProdutoTipoCultura.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkProdutoTipoCultura", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkProdutoTipoCultura"].Value = wkProdutoTipoCultura;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

		loSqlCommand.Parameters.Add("@cdProdutoTipoCulturaSEQ", SqlDbType.BigInt);
		loSqlCommand.Parameters["@cdProdutoTipoCulturaSEQ"].Direction = ParameterDirection.Output;
 
Consistências:
		//Consistências:
		if (cdProdutoSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdTipoCulturaSEQ == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdIndicadorStatusProdutoTipoCultura == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

		if (cdUsuarioUltimaAlteracao == 0)
		{
			return " " + moPadrao.MensagemObrigatorio;
		}

*/
