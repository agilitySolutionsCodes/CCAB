set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificarExclusaoGrupoAcesso.sql
**		Name: SP_S_VerificarExclusaoGrupoAcesso
**		Desc: Verifica Disponibilidade para exclusão do Grupo de Acesso
**
**		Auth: Convergence
**		Date: 3/Jun/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificarExclusaoGrupoAcesso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificarExclusaoGrupoAcesso]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificarExclusaoGrupoAcesso]
	  @cdGrupoAcessoSEQ		bigint
  
AS

	select
		cdPessoaSEQ
	from
		dbo.Pessoa
	where
		cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
 
	union

	select
		cdPessoaSEQ
	from
		dbo.PessoaHistorico
	where
		cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ