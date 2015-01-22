set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_TipoCulturaHistorico.sql
**		Name: SP_G_TipoCulturaHistorico
**		Desc: Seleciona os registros na tabela TipoCulturaHistorico
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_TipoCulturaHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_TipoCulturaHistorico]
END
GO

CREATE PROCEDURE [dbo].[SP_G_TipoCulturaHistorico]
	@cdTipoCulturaSEQ		bigint
AS


	SELECT
		 A.cdTipoCulturaHistoricoSEQ
		,A.cdTipoCulturaSEQ
		,A.cdTipoCulturaERP
		,A.dsTipoCultura
		,A.cdIndicadorStatusTipoCultura
		,A.wkTipoCultura

		--campos comuns
		,(
			SELECT
				wkDominioCodigoReferenciado
			FROM
				dbo.CodigoReferenciado	(nolock)
			WHERE
				vrDominioCodigoReferenciado	= A.cdIndicadorStatusTipoCultura
			AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORATIVOINATIVO'
		)	as dsIndicadorStatusTipoCultura

		,cdTipoEventoHistorico
		,(
			CASE cdTipoEventoHistorico 
				WHEN 1 THEN 'Inclusão'
				ELSE 'Alteração'
			END	
		)	as dsTipoEventoHistorico 
		,A.dtOcorrenciaHistorico
		,A.cdUsuarioOcorrenciaHistorico
		,(
			SELECT 
				U.dsLoginPessoa
			FROM
				dbo.Pessoa	U	(nolock)
			WHERE
				U.cdPessoaSEQ = A.cdUsuarioOcorrenciaHistorico
		)	as nmUsuario

	FROM
		dbo.TipoCulturaHistorico		A		(nolock)	
	WHERE
		A.cdTipoCulturaSEQ				= @cdTipoCulturaSEQ	



SET QUOTED_IDENTIFIER OFF

