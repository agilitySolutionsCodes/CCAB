set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_Produto.sql
**		Name: SP_U_Produto
**		Desc: Altera um registro na tabela Produto
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_Produto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_Produto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_Produto]
	 @cdProdutoSEQ	BIGINT
	,@cdProdutoERP	VARCHAR(30)
	,@dsProduto	VARCHAR(70)
	,@dsUnidadeProduto	VARCHAR(30)
	,@qtEmbalagemProduto	NUMERIC(22,6) = NULL
	,@qtPesoLiquidoProduto	NUMERIC(22,6) = NULL
	,@qtPesoBrutoProduto	NUMERIC(22,6) = NULL
	,@cdIndicadorLiberadoPedidoProduto	INT
	,@cdGrupoProdutoSEQ	BIGINT = NULL
	,@wkProduto	VARCHAR(255) = NULL
	,@cdRecnoMicrosiga	BIGINT = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS
 
	--atualização
	UPDATE Produto SET
		 cdProdutoERP = @cdProdutoERP
		,dsProduto = @dsProduto
		,dsUnidadeProduto = @dsUnidadeProduto
		,qtEmbalagemProduto = @qtEmbalagemProduto
		,qtPesoLiquidoProduto = @qtPesoLiquidoProduto
		,qtPesoBrutoProduto = @qtPesoBrutoProduto
		,cdIndicadorLiberadoPedidoProduto = @cdIndicadorLiberadoPedidoProduto
		,cdGrupoProdutoSEQ = @cdGrupoProdutoSEQ
		,wkProduto = @wkProduto
		,cdRecnoMicrosiga = @cdRecnoMicrosiga
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

	WHERE 
		 cdProdutoSEQ = @cdProdutoSEQ
 
 
--	if @cdIndicadorLiberadoPedidoProduto = 1 --Sim
--	begin
--		--Inserção automática
--		exec SP_I_Produto_TipoCultura
--			 @cdProdutoSEQ				= @cdProdutoSEQ
--			,@cdUsuarioUltimaAlteracao	= @cdUsuarioUltimaAlteracao
--	end



/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdProdutoSEQ, string cdProdutoERP, string dsProduto, string dsUnidadeProduto, double qtEmbalagemProduto, double qtPesoLiquidoProduto, double qtPesoBrutoProduto, int cdIndicadorLiberadoPedidoProduto, Int64 cdGrupoProdutoSEQ, string wkProduto, Int64 cdRecnoMicrosiga, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
			loSqlCommand.Parameters.Add("@cdProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdProdutoSEQ"].Value = cdProdutoSEQ;

			loSqlCommand.Parameters.Add("@cdProdutoERP", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@cdProdutoERP"].Value = cdProdutoERP;

			loSqlCommand.Parameters.Add("@dsProduto", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@dsProduto"].Value = dsProduto;

			loSqlCommand.Parameters.Add("@dsUnidadeProduto", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@dsUnidadeProduto"].Value = dsUnidadeProduto;

		if (qtEmbalagemProduto != 0)
		{
			loSqlCommand.Parameters.Add("@qtEmbalagemProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@qtEmbalagemProduto"].Value = qtEmbalagemProduto;
		}

		if (qtPesoLiquidoProduto != 0)
		{
			loSqlCommand.Parameters.Add("@qtPesoLiquidoProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@qtPesoLiquidoProduto"].Value = qtPesoLiquidoProduto;
		}

		if (qtPesoBrutoProduto != 0)
		{
			loSqlCommand.Parameters.Add("@qtPesoBrutoProduto", SqlDbType.Float);
			loSqlCommand.Parameters["@qtPesoBrutoProduto"].Value = qtPesoBrutoProduto;
		}

			loSqlCommand.Parameters.Add("@cdIndicadorLiberadoPedidoProduto", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorLiberadoPedidoProduto"].Value = cdIndicadorLiberadoPedidoProduto;

		if (cdGrupoProdutoSEQ != 0)
		{
			loSqlCommand.Parameters.Add("@cdGrupoProdutoSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdGrupoProdutoSEQ"].Value = cdGrupoProdutoSEQ;
		}

		if (wkProduto.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@wkProduto", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@wkProduto"].Value = wkProduto;
		}

		if (cdRecnoMicrosiga != 0)
		{
			loSqlCommand.Parameters.Add("@cdRecnoMicrosiga", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdRecnoMicrosiga"].Value = cdRecnoMicrosiga;
		}

			loSqlCommand.Parameters.Add("@cdUsuarioUltimaAlteracao", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdUsuarioUltimaAlteracao"].Value = cdUsuarioUltimaAlteracao;

*/
