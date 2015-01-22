set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_GrupoAcesso_Filtro
**		Name: SP_G_GrupoAcesso_Filtro
**		Desc: Seleciona os registros na tabela GrupoAcesso, para o Filtro
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoAcesso_Filtro]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoAcesso_Filtro]
END
GO

CREATE PROCEDURE [dbo].[SP_G_GrupoAcesso_Filtro]
	 @dsGrupoAcesso					varchar(70)	= null
	,@cdIndicadorStatusGrupoAcesso	int			= null

AS


	select
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

	WHERE
		(@dsGrupoAcesso is null or dsGrupoAcesso like + '%' + ltrim(rtrim(@dsGrupoAcesso)) + '%' ) 
	and (@cdIndicadorStatusGrupoAcesso is null or cdIndicadorStatusGrupoAcesso = @cdIndicadorStatusGrupoAcesso)

	ORDER BY
		dsGrupoAcesso







SET QUOTED_IDENTIFIER OFF

