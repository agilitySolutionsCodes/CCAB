set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_G_ProdutoMoedaHistorico.sql
**		Name: SP_G_ProdutoMoedaHistorico
**		Desc: Obtem uma lista de registros da tabela ProdutoMoedaHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ProdutoMoedaHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ProdutoMoedaHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_G_ProdutoMoedaHistorico]
	 @cdProdutoMoedaSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdProdutoMoedaHistoricoSEQ
		,HIS.cdProdutoMoedaSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdIndicadorMoedaProduto
		,HIS.cdIndicadorStatusProdutoMoeda
		,HIS.wkProdutoMoeda
		,HIS.dtOcorrenciaHistorico
		,HIS.cdTipoEventoHistorico
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
		ProdutoMoedaHistorico	HIS		(nolock)	

	WHERE 
		cdProdutoMoedaSEQ = @cdProdutoMoedaSEQ
