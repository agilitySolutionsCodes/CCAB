set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_GrupoAcesso_Permissao
**		Name: SP_S_GrupoAcesso_Permissao
**		Desc: Verifica a Permissão do Item
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_GrupoAcesso_Permissao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_GrupoAcesso_Permissao]
END
GO

CREATE PROCEDURE [dbo].[SP_S_GrupoAcesso_Permissao]
	 @cdGrupoAcessoSEQ					bigint
	,@cdItemMenuSEQ						bigint
	,@cdIndicadorTipoMenuOperacao		int

AS

	select
		 cdGrupoAcessoSEQ
		,cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao
	from
		dbo.GrupoAcessoItemMenuOperacao
		
	where
		cdIndicadorStatusGrupoAcessoItemMenuOperacao		= 1
	and	cdGrupoAcessoSEQ									= @cdGrupoAcessoSEQ
	and	cdItemMenuSEQ										= @cdItemMenuSEQ
	and	cdIndicadorTipoMenuOperacao							= @cdIndicadorTipoMenuOperacao





SET QUOTED_IDENTIFIER OFF

