set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_GrupoAcesso_ItemMenu
**		Name: SP_G_GrupoAcesso_ItemMenu
**		Desc: Seleciona os registros na tabela GrupoAcesso, para Item de Menu
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_GrupoAcesso_ItemMenu]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_GrupoAcesso_ItemMenu]
END
GO

CREATE PROCEDURE [dbo].[SP_G_GrupoAcesso_ItemMenu]

AS

	select
		 MEN.cdItemMenuSEQ
		,dbo.FN_ItemMenu_ObterPai_Descricao(MEN.cdItemMenuSEQ)	as dsItemMenu
	from
		dbo.ItemMenu						MEN
		
	where
		MEN.cdIndicadorStatusItemMenu		= 1
	and	MEN.cdIndicadorTipoEstruturaItemMenu	in (3,4)

	order by
		MEN.nuOrdemApresentacaoItemMenu



SET QUOTED_IDENTIFIER OFF

