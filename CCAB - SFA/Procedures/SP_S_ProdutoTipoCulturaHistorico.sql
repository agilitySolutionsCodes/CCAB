set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_ProdutoTipoCulturaHistorico.sql
**		Name: SP_S_ProdutoTipoCulturaHistorico
**		Desc: Obtem um de registro da tabela ProdutoTipoCulturaHistorico
**
**		Auth: Convergence
**		Date: 17/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_ProdutoTipoCulturaHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_ProdutoTipoCulturaHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_ProdutoTipoCulturaHistorico]
	 @cdProdutoTipoCulturaHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdProdutoTipoCulturaHistoricoSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdTipoCulturaSEQ
		,HIS.cdIndicadorStatusProdutoTipoCultura
		,HIS.wkProdutoTipoCultura
		,HIS.dtOcorrenciaHistorico
		,HIS.cdUsuarioOcorrenciaHistorico
		,HIS.cdProdutoTipoCulturaSEQ
		,HIS.cdTipoEventoHistorico

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
		ProdutoTipoCulturaHistorico	HIS		(nolock)	

	WHERE 
		cdProdutoTipoCulturaHistoricoSEQ = @cdProdutoTipoCulturaHistoricoSEQ
