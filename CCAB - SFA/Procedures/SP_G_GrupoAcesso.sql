set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_GrupoAcesso
**		Name: SP_G_GrupoAcesso
**		Desc: Seleciona os registros na tabela GrupoAcesso
**
**		Auth: Roberto Chaparro
**		Date: Jan 14 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoAcesso]
END
GO

CREATE PROCEDURE [dbo].[SP_G_GrupoAcesso]

AS

	SELECT
		 cdGrupoAcessoSEQ
		,dsGrupoAcesso
		,cdIndicadorStatusGrupoAcesso
		,(
			SELECT
				wkDominioCodigoReferenciado
			FROM
				dbo.CodigoReferenciado
			WHERE
				vrDominioCodigoReferenciado	= cdIndicadorStatusGrupoAcesso
			AND	dsDominioCodigoReferenciado	= 'DMESPINDICADORATIVOINATIVO'
		)	as dsIndicadorStatusGrupoAcesso

		,cdSistemaGrupoAcesso
		,wkGrupoAcesso
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		dbo.GrupoAcesso
	ORDER BY
		dsGrupoAcesso


SET QUOTED_IDENTIFIER OFF

