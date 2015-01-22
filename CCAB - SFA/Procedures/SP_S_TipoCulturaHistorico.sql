set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_TipoCulturaHistorico.sql
**		Name: SP_S_TipoCulturaHistorico
**		Desc: Seleciona um registro na tabela TipoCulturaHistorico
**
**		Auth: Roberto Chaparro
**		Date: Mar 10 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_TipoCulturaHistorico]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_TipoCulturaHistorico]
END
GO

CREATE PROCEDURE [dbo].[SP_S_TipoCulturaHistorico]
	 @cdTipoCulturaHistoricoSEQ				bigint
AS

	
	SELECT
		 A.cdTipoCulturaHistoricoSEQ
		,A.cdTipoCulturaSEQ
		,A.cdTipoCulturaERP
		,A.cdIndicadorStatusTipoCultura
		,A.dsTipoCultura
		,A.wkTipoCultura

		--campos comuns
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
		A.cdTipoCulturaHistoricoSEQ		= @cdTipoCulturaHistoricoSEQ	





SET QUOTED_IDENTIFIER OFF

