set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_GrupoAcesso_Permissao.sql
**		Name: SP_U_GrupoAcesso_Permissao
**		Desc: Altera um registro na tabela GrupoAcesso, Permissão
**
**		Auth: Convergence
**		Date: 02/06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_GrupoAcesso_Permissao]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_GrupoAcesso_Permissao]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_GrupoAcesso_Permissao]
	 @cdGrupoAcessoSEQ							BIGINT
	,@cdItemMenuSEQ								bigint
	,@cdIndicadorTipoMenuOperacao_Inclusao		bit
	,@cdIndicadorTipoMenuOperacao_Alteracao		bit
	,@cdIndicadorTipoMenuOperacao_Exclusao		bit
	,@cdIndicadorTipoMenuOperacao_Pesquisa		bit
	,@cdIndicadorTipoMenuOperacao_Visualizacao	bit

	,@cdUsuarioUltimaAlteracao					BIGINT
 
AS
 
	declare
		 @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Inclusao		int
		,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Alteracao	int
		,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Exclusao		int
		,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Pesquisa		int
		,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Visualizacao	int



	--Seto os Flags
	if @cdIndicadorTipoMenuOperacao_Inclusao = 1
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Inclusao = 1
	end
	else
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Inclusao = 2
	end
	-------------------------------------------------------------------
	if @cdIndicadorTipoMenuOperacao_Alteracao = 1
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Alteracao = 1
	end
	else
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Alteracao = 2
	end
	-------------------------------------------------------------------
	if @cdIndicadorTipoMenuOperacao_Exclusao = 1
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Exclusao = 1
	end
	else
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Exclusao = 2
	end
	-------------------------------------------------------------------
	if @cdIndicadorTipoMenuOperacao_Pesquisa = 1
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Pesquisa = 1
	end
	else
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Pesquisa = 2
	end
	-------------------------------------------------------------------
	if @cdIndicadorTipoMenuOperacao_Visualizacao = 1
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Visualizacao = 1
	end
	else
	begin
		select
			@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Visualizacao = 2
	end
	-------------------------------------------------------------------


	--INCLUSÃO
	if exists (	select 
					1 
				from 
					dbo.GrupoAcessoItemMenuOperacao
				where
					cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
				and	cdItemMenuSEQ					= @cdItemMenuSEQ
				and cdIndicadorTipoMenuOperacao		= 1) --INCLUSÃO
	begin
		update
			dbo.GrupoAcessoItemMenuOperacao
		set
			cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Inclusao
		where
			cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
		and	cdItemMenuSEQ					= @cdItemMenuSEQ
		and cdIndicadorTipoMenuOperacao		= 1 --INCLUSÃO
	end
	else
	begin
		insert into	dbo.GrupoAcessoItemMenuOperacao
			(cdGrupoAcessoSEQ
			,cdItemMenuSEQ
			,cdIndicadorTipoMenuOperacao
			,cdIndicadorStatusGrupoAcessoItemMenuOperacao
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao)
		values
			(@cdGrupoAcessoSEQ
			,@cdItemMenuSEQ
			,1 --INCLUSÃO
			,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Inclusao
			,getdate()
			,@cdUsuarioUltimaAlteracao)
	end


	--ALTERAÇÃO
	if exists (	select 
					1 
				from 
					dbo.GrupoAcessoItemMenuOperacao
				where
					cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
				and	cdItemMenuSEQ					= @cdItemMenuSEQ
				and cdIndicadorTipoMenuOperacao		= 2) --ALTERAÇÃO
	begin
		update
			dbo.GrupoAcessoItemMenuOperacao
		set
			cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Alteracao
		where
			cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
		and	cdItemMenuSEQ					= @cdItemMenuSEQ
		and cdIndicadorTipoMenuOperacao		= 2 --ALTERAÇÃO
	end
	else
	begin
		insert into	dbo.GrupoAcessoItemMenuOperacao
			(cdGrupoAcessoSEQ
			,cdItemMenuSEQ
			,cdIndicadorTipoMenuOperacao
			,cdIndicadorStatusGrupoAcessoItemMenuOperacao
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao)
		values
			(@cdGrupoAcessoSEQ
			,@cdItemMenuSEQ
			,2 --ALTERAÇÃO
			,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Alteracao
			,getdate()
			,@cdUsuarioUltimaAlteracao)
	end


	--EXCLUSÃO
	if exists (	select 
					1 
				from 
					dbo.GrupoAcessoItemMenuOperacao
				where
					cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
				and	cdItemMenuSEQ					= @cdItemMenuSEQ
				and cdIndicadorTipoMenuOperacao		= 3) --EXCLUSÃO
	begin
		update
			dbo.GrupoAcessoItemMenuOperacao
		set
			cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Exclusao
		where
			cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
		and	cdItemMenuSEQ					= @cdItemMenuSEQ
		and cdIndicadorTipoMenuOperacao		= 3 --EXCLUSÃO
	end
	else
	begin
		insert into	dbo.GrupoAcessoItemMenuOperacao
			(cdGrupoAcessoSEQ
			,cdItemMenuSEQ
			,cdIndicadorTipoMenuOperacao
			,cdIndicadorStatusGrupoAcessoItemMenuOperacao
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao)
		values
			(@cdGrupoAcessoSEQ
			,@cdItemMenuSEQ
			,3 --EXCLUSÃO
			,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Exclusao
			,getdate()
			,@cdUsuarioUltimaAlteracao)
	end


	--PESQUISA
	if exists (	select 
					1 
				from 
					dbo.GrupoAcessoItemMenuOperacao
				where
					cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
				and	cdItemMenuSEQ					= @cdItemMenuSEQ
				and cdIndicadorTipoMenuOperacao		= 4) --PESQUISA
	begin
		update
			dbo.GrupoAcessoItemMenuOperacao
		set
			cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Pesquisa
		where
			cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
		and	cdItemMenuSEQ					= @cdItemMenuSEQ
		and cdIndicadorTipoMenuOperacao		= 4 --PESQUISA
	end
	else
	begin
		insert into	dbo.GrupoAcessoItemMenuOperacao
			(cdGrupoAcessoSEQ
			,cdItemMenuSEQ
			,cdIndicadorTipoMenuOperacao
			,cdIndicadorStatusGrupoAcessoItemMenuOperacao
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao)
		values
			(@cdGrupoAcessoSEQ
			,@cdItemMenuSEQ
			,4 --PESQUISA
			,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Pesquisa
			,getdate()
			,@cdUsuarioUltimaAlteracao)
	end


	--VISUALIZAÇÃO
	if exists (	select 
					1 
				from 
					dbo.GrupoAcessoItemMenuOperacao
				where
					cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
				and	cdItemMenuSEQ					= @cdItemMenuSEQ
				and cdIndicadorTipoMenuOperacao		= 5) --VISUALIZAÇÃO
	begin
		update
			dbo.GrupoAcessoItemMenuOperacao
		set
			cdIndicadorStatusGrupoAcessoItemMenuOperacao = @cdIndicadorStatusGrupoAcessoItemMenuOperacao_Visualizacao
		where
			cdGrupoAcessoSEQ				= @cdGrupoAcessoSEQ
		and	cdItemMenuSEQ					= @cdItemMenuSEQ
		and cdIndicadorTipoMenuOperacao		= 5 --VISUALIZAÇÃO
	end
	else
	begin
		insert into	dbo.GrupoAcessoItemMenuOperacao
			(cdGrupoAcessoSEQ
			,cdItemMenuSEQ
			,cdIndicadorTipoMenuOperacao
			,cdIndicadorStatusGrupoAcessoItemMenuOperacao
			,dtUltimaAlteracao
			,cdUsuarioUltimaAlteracao)
		values
			(@cdGrupoAcessoSEQ
			,@cdItemMenuSEQ
			,5 --VISUALIZAÇÃO
			,@cdIndicadorStatusGrupoAcessoItemMenuOperacao_Visualizacao
			,getdate()
			,@cdUsuarioUltimaAlteracao)
	end
