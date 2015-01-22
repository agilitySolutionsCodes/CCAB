set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_ItemMenu
**		Name: SP_G_ItemMenu
**		Desc: Seleciona os registros na tabela ItemMenu
**
**		Auth: Roberto Chaparro
**		Date: Jan 22 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_ItemMenu]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_ItemMenu]
END
GO

CREATE PROCEDURE [dbo].[SP_G_ItemMenu]
	 @cdPessoaSEQ			bigint
AS

	SELECT
		 cdItemMenuSEQ
		,dsItemMenu
		,cdIndicadorStatusItemMenu
		,cdIndicadorTipoEstruturaItemMenu
		,dsEnderecoChamadaItemMenu
		,wkItemMenu
		,nuOrdemApresentacaoItemMenu
		,cdItemMenuSuperior
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
	FROM
		dbo.ItemMenu
	WHERE cdItemmenuSEQ = cdItemMenuSEQ
	and	cdItemMenuSEQ IN	(
			select distinct 
				cdsistemagrupoacesso as cdItemMenuSEQ -- Primeiro Nivel
			from 
				dbo.GrupoAcesso
			where 
				cdGrupoAcessoSEQ in	(
					select 
						cdGrupoAcessoSEQ
					from 
						dbo.Pessoa
					where 
						cdPessoaSEQ = @cdPessoaSEQ -- codigo da pessoa
					and	cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha não bloqueada
									)
			UNION

			select distinct 
				b.cdItemMenuSuperior -- Segundo Nivel
			from 
				 dbo.GrupoAcessoItemMenuOperacao	a
				,dbo.ItemMenu						b
			where 
				a.cdItemMenuSEQ	= b.cdItemMenuSEQ
			and b.cdIndicadorTipoEstruturaItemMenu in (1,2,3)	
			and b.cdItemMenuSuperior is not null
			and	a.cdIndicadorTipoMenuOperacao = 4 -- Pesquisa
			and a.cdIndicadorStatusGrupoAcessoItemMenuOperacao = 1 -- Ativo

			and a.cdGrupoAcessoSEQ in	(
					select distinct
						a.cdGrupoAcessoSEQ
					from 
						dbo.Pessoa a,
						dbo.GrupoAcessoItemMenuOperacao b
					where 
						a.cdGrupoAcessoSEQ = b.cdGrupoAcessoSEQ
					and	a.cdPessoaSEQ = @cdPessoaSEQ -- codigo da pessoa
					and a.cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Não Bloqueada
					and b.cdIndicadorTipoMenuOperacao = 4 -- Pesquisa
					and b.cdIndicadorStatusGrupoAcessoItemMenuOperacao = 1 -- Ativo					
										)

			UNION
 
			select distinct 
				cdItemMenuSEQ -- Terceiro Nivel
			from 
				dbo.GrupoAcessoItemMenuOperacao
			where 
				cdIndicadorTipoMenuOperacao = 4 -- Pesquisa
			and cdIndicadorStatusGrupoAcessoItemMenuOperacao = 1 -- Ativo
			and	cdGrupoAcessoSEQ in	(
					select distinct
						a.cdGrupoAcessoSEQ
					from 
						dbo.Pessoa a,
						dbo.GrupoAcessoItemMenuOperacao b
					where 
						a.cdGrupoAcessoSEQ = b.cdGrupoAcessoSEQ
					and	a.cdPessoaSEQ = @cdPessoaSEQ -- codigo da pessoa
					and a.cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Nao Bloqueada
					and b.cdIndicadorTipoMenuOperacao = 4 -- Pesquisa
					and b.cdIndicadorStatusGrupoAcessoItemMenuOperacao = 1 -- Ativo
									)
						)
	AND	cdIndicadorTipoEstruturaItemMenu IN (1, 2, 3)
	AND cdIndicadorStatusItemMenu = 1
	
	ORDER BY nuOrdemApresentacaoItemmenu


SET QUOTED_IDENTIFIER OFF

