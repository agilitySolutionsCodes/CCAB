set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_ProdutoHistorico.sql
**		Name: SP_S_ProdutoHistorico
**		Desc: Obtem um de registro da tabela ProdutoHistorico
**
**		Auth: Convergence
**		Date: 11/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_ProdutoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_ProdutoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_ProdutoHistorico]
	 @cdProdutoHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdProdutoHistoricoSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdProdutoERP
		,HIS.dsProduto
		,HIS.dsUnidadeProduto
		,HIS.qtEmbalagemProduto
		,HIS.qtPesoLiquidoProduto
		,HIS.qtPesoBrutoProduto
		,HIS.cdIndicadorLiberadoPedidoProduto
		,HIS.wkProduto
		,HIS.cdTipoEventoHistorico
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico

		,(
			CASE cdTipoEventoHistorico 
				WHEN 1 THEN 'Inclusão'
				ELSE 'Alteração'
			END	
		)	as dsTipoEventoHistorico 


		,(
			SELECT 
				USU.dsLoginPessoa
			FROM
				dbo.Pessoa	USU	(nolock)
			WHERE
				USU.cdPessoaSEQ = HIS.cdUsuarioOcorrenciaHistorico
		)	as nmUsuario


	FROM
		ProdutoHistorico	HIS		(nolock)	

	WHERE 
		cdProdutoHistoricoSEQ = @cdProdutoHistoricoSEQ
