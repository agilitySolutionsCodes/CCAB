set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_Produto.sql
**		Name: SP_I_Produto
**		Desc: Insere um registro na tabela Produto
**
**		Auth: Convergence
**		Date: 11/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_Produto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_Produto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_Produto]
	 @cdProdutoERP	VARCHAR(30)
	,@dsProduto	VARCHAR(70)
	,@dsUnidadeProduto	VARCHAR(30)
	,@qtEmbalagemProduto	NUMERIC(22,6) = NULL
	,@qtPesoLiquidoProduto	NUMERIC(22,6) = NULL
	,@qtPesoBrutoProduto	NUMERIC(22,6) = NULL
	,@cdIndicadorLiberadoPedidoProduto	INT
	,@nuOrdemApresentacaoProduto	INT = NULL
	,@wkProduto	VARCHAR(255) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdProdutoSEQ	BIGINT	OUTPUT
AS
 
	--inserção
	INSERT INTO Produto
	(
	 cdProdutoERP
	,dsProduto
	,dsUnidadeProduto
	,qtEmbalagemProduto
	,qtPesoLiquidoProduto
	,qtPesoBrutoProduto
	,cdIndicadorLiberadoPedidoProduto
	,wkProduto
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	)
	VALUES
	(
	 @cdProdutoERP
	,@dsProduto
	,@dsUnidadeProduto
	,@qtEmbalagemProduto
	,@qtPesoLiquidoProduto
	,@qtPesoBrutoProduto
	,@cdIndicadorLiberadoPedidoProduto
	,@wkProduto
	,getdate()
	,@cdUsuarioUltimaAlteracao
	)
 
	--retornos
	SELECT
		@cdProdutoSEQ = SCOPE_IDENTITY()
	SELECT
		@cdProdutoSEQ as cdProdutoSEQ
