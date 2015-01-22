set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_ItemMenu_Seguranca
**		Name: SP_G_ItemMenu_Seguranca
**		Desc: Seleciona os registros na tabela ItemMenu
**
**		Auth: Roberto Chaparro
**		Date: Jan 29 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ItemMenu_Seguranca]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ItemMenu_Seguranca]
END
GO

CREATE PROCEDURE [dbo].[SP_G_ItemMenu_Seguranca]
	 @cdPessoaSEQ			bigint
AS

	select distinct 
		 GAI.cdItemMenuSEQ
		,GAI.cdIndicadorTipoMenuOperacao
		,IMN.dsNomeFuncionalidade
	from
		dbo.Pessoa			PGA
	inner join
		dbo.GrupoAcessoItemMenuOperacao	GAI
	on
		PGA.cdGrupoAcessoSEQ			= GAI.cdGrupoAcessoSEQ

	inner join
		dbo.ItemMenuOperacao			IMO
	on	
		GAI.cdItemMenuSEQ				= IMO.cdItemMenuSEQ
	and	GAI.cdIndicadorTipoMenuOperacao = IMO.cdIndicadorTipoMenuOperacao

	inner join
		dbo.ItemMenu					IMN
	on
		IMO.cdItemMenuSEQ				= IMN.cdItemMenuSEQ

	where
		PGA.cdPessoaSEQ										= @cdPessoaSEQ
	and	PGA.cdIndicadorSenhaBloqueadaPessoa					= 2 --Não
	and	GAI.cdIndicadorStatusGrupoAcessoItemMenuOperacao	= 1
	and IMO.cdIndicadorStatusMenuOperacao					= 1
	and	IMN.cdIndicadorStatusItemMenu						= 1

	order by
		IMN.dsNomeFuncionalidade

SET QUOTED_IDENTIFIER OFF

