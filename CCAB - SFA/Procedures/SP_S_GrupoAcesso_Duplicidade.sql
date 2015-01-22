set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_GrupoAcesso_Duplicidade
**		Name: SP_S_GrupoAcesso_Duplicidade
**		Desc: Seleciona os registros na tabela GrupoAcesso, para verificação de Duplicidade
**
**		Auth: Roberto Chaparro
**		Date: Jun 3 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_GrupoAcesso_Duplicidade]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_GrupoAcesso_Duplicidade]
END
GO

CREATE PROCEDURE [dbo].[SP_S_GrupoAcesso_Duplicidade]
	@dsGrupoAcesso				varchar(70)
AS

	SELECT
		 cdGrupoAcessoSEQ
	FROM
		dbo.GrupoAcesso
	WHERE
		dsGrupoAcesso				= @dsGrupoAcesso



SET QUOTED_IDENTIFIER OFF

