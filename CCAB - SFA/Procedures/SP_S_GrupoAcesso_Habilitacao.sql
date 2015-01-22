set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_GrupoAcesso_Habilitacao
**		Name: SP_S_GrupoAcesso_Habilitacao
**		Desc: Verifica a Habilitação do Item
**
**		Auth: Roberto Chaparro
**		Date: Jun 2 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_GrupoAcesso_Habilitacao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_GrupoAcesso_Habilitacao]
END
GO

CREATE PROCEDURE [dbo].[SP_S_GrupoAcesso_Habilitacao]
	 @cdItemMenuSEQ						bigint
	,@cdIndicadorTipoMenuOperacao		int

AS

	select
		 cdItemMenuSEQ
		,cdIndicadorTipoMenuOperacao
	from
		dbo.ItemMenuOperacao
		
	where
		cdIndicadorStatusMenuOperacao		= 1
	and	cdItemMenuSEQ						= @cdItemMenuSEQ
	and	cdIndicadorTipoMenuOperacao			= @cdIndicadorTipoMenuOperacao




SET QUOTED_IDENTIFIER OFF

