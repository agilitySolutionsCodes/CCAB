set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_PessoaTabelaPrecoProdutoHistorico.sql
**		Name: SP_S_PessoaTabelaPrecoProdutoHistorico
**		Desc: Obtem um de registro da tabela PessoaTabelaPrecoProdutoHistorico
**
**		Auth: Convergence
**		Date: 19/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_PessoaTabelaPrecoProdutoHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_PessoaTabelaPrecoProdutoHistorico]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_PessoaTabelaPrecoProdutoHistorico]
	 @cdPessoaTabelaPrecoProdutoHistoricoSEQ	BIGINT
 
AS
 
	--seleção
	SELECT
		 HIS.cdPessoaTabelaPrecoProdutoHistoricoSEQ
		,HIS.cdPessoaTabelaPrecoProdutoSEQ
		,HIS.cdPessoaSEQ
		,HIS.cdCronogramaSafraSEQ
		,HIS.cdProdutoSEQ
		,HIS.cdTipoCulturaSEQ
		,HIS.cdCronogramaSafraVencimentoSEQ
		,HIS.vrDolarPessoaTabelaPrecoProduto
		,HIS.vrRealPessoaTabelaPrecoProduto
		,HIS.pcDescontoPontualidadePessoaTabelaPrecoProduto
		,HIS.wkPessoaTabelaPrecoProduto
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
		PessoaTabelaPrecoProdutoHistorico	HIS		(nolock)	

	WHERE 
		cdPessoaTabelaPrecoProdutoHistoricoSEQ = @cdPessoaTabelaPrecoProdutoHistoricoSEQ
