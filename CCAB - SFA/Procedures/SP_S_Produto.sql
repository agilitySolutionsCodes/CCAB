/******************************************************************************
**		File: SP_S_Produto.sql
**		Name: SP_S_Produto
**		Desc: Obtem um registro da tabela Produto
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		04.05.2010		Ronaldo Mega			Inserçao dos Campos Tipo 
**												Produto e Fornecedor					
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Produto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Produto]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_Produto]
	 @cdProdutoSEQ	BIGINT
 
 
AS
 
	--seleção
	SELECT 
		 PRO.cdProdutoSEQ
		,PRO.cdProdutoERP
		,PRO.dsProduto
		,PRO.dsUnidadeProduto
		,PRO.qtEmbalagemProduto
		,PRO.qtPesoLiquidoProduto
		,PRO.qtPesoBrutoProduto
		,PRO.cdIndicadorLiberadoPedidoProduto
		,PRO.wkProduto
		,PRO.dtUltimaAlteracao
		,PRO.cdUsuarioUltimaAlteracao
		,PES.nmPessoa + ' - ' + PES.cdPessoaERP nmPessoa
		
		,(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= cdTipoProduto 
				AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
			)as dsTipoProduto 

	FROM
		Produto PRO (nolock)
		LEFT JOIN Pessoa PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = PRO.cdFornecedorSEQ)	
	WHERE 
		cdProdutoSEQ = @cdProdutoSEQ
