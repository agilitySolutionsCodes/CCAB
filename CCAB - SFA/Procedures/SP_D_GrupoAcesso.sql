set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_D_GrupoAcesso
**		Name: SP_D_GrupoAcesso
**		Desc: Exclui o registro da tabela GrupoAcesso
**
**		Auth: Roberto Chaparro
**		Date: Jun 3 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_GrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_D_GrupoAcesso]
END
GO

CREATE PROCEDURE [dbo].[SP_D_GrupoAcesso]
	 @cdGrupoAcessoSEQ						bigint
AS


	--Hist�rico
	DELETE 
		dbo.GrupoAcessoItemMenuOperacaoHistorico
	WHERE
		cdGrupoAcessoSEQ						= @cdGrupoAcessoSEQ
		

	--Principal
	DELETE 
		dbo.GrupoAcessoItemMenuOperacao
	WHERE
		cdGrupoAcessoSEQ						= @cdGrupoAcessoSEQ





	--Hist�rico
	DELETE 
		dbo.GrupoAcessoHistorico
	WHERE
		cdGrupoAcessoSEQ						= @cdGrupoAcessoSEQ
		

	--Principal
	DELETE 
		dbo.GrupoAcesso
	WHERE
		cdGrupoAcessoSEQ						= @cdGrupoAcessoSEQ




