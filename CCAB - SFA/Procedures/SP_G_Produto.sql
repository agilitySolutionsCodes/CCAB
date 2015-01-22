/******************************************************************************
**		File: SP_G_Produto
**		Name: SP_G_Produto
**		Desc: Seleciona os registros na tabela Produto
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**		04.05.2010		Ronaldo Mega (RMWA)		Inclusão dos Filtros 
**												Tipo Produto e Fornecedor
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Produto]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Produto]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Produto]
	 @cdProdutoERP						varchar(30)	= null
	,@dsProduto							varchar(70)	= null
	,@cdIndicadorLiberadoPedidoProduto	int			= null
	,@cdTipoProduto						INT			= NULL
	,@cdFornecedorSEQ					BIGINT		= NULL
	
AS

	BEGIN
		
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
			,PES.nmPessoa + ' - ' + PES.cdPessoaERP  nmPessoa
			
			,(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= cdIndicadorLiberadoPedidoProduto 
				AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORSIMNAO'
			)as dsIndicadorLiberadoPedidoProduto 
			
			,(SELECT 
				wkDominioCodigoReferenciado 
			FROM  
				dbo.CodigoReferenciado 
			WHERE 
				vrDominioCodigoReferenciado	= cdTipoProduto 
				AND	dsDominioCodigoReferenciado	= 'DMESPTIPOPRODUTO'
			)as dsTipoProduto  

		FROM  
			dbo.Produto PRO WITH(NOLOCK)  
			LEFT JOIN Pessoa PES WITH(NOLOCK) ON (PES.cdPessoaSEQ = PRO.cdFornecedorSEQ)			
		WHERE 
			cdProdutoSEQ > 0 
			AND (upper(ltrim(rtrim(PRO.cdProdutoERP))) = upper(ltrim(rtrim(@cdProdutoERP))) OR @cdProdutoERP IS NULL)
			AND (upper(ltrim(rtrim(dsProduto))) like '%' + upper(ltrim(rtrim(@dsProduto))) + '%' OR @dsProduto IS NULL)
			AND (PRO.cdIndicadorLiberadoPedidoProduto = @cdIndicadorLiberadoPedidoProduto OR @cdIndicadorLiberadoPedidoProduto IS NULL)
			AND (PRO.cdTipoProduto = @cdTipoProduto OR @cdTipoProduto IS NULL)
			AND (PRO.cdFornecedorSEQ = @cdFornecedorSEQ OR @cdFornecedorSEQ IS NULL)						
		ORDER BY
			PRO.dsProduto




	END

SET QUOTED_IDENTIFIER OFF

/******************************************************************************
** Teste

	SP_G_Produto @dsProduto = 'ULTRA'

******************************************************************************/