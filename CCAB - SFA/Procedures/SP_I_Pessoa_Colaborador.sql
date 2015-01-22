set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_Pessoa_Colaborador.sql
**		Name: SP_I_Pessoa_Colaborador
**		Desc: Insere um registro na tabela Pessoa - Colaborador
**
**		Auth: Convergence
**		Date: 18/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_Pessoa_Colaborador]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_Pessoa_Colaborador]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_Pessoa_Colaborador]
	 @cdIndicadorTipoPerfilPessoa	INT
	,@dsLoginPessoa	VARCHAR(30) = NULL
	,@nmPessoa	VARCHAR(70)
	,@nuCNPJCPFPessoa	VARCHAR(30) = NULL
	,@enEmailPrincipalPessoa	VARCHAR(70) = NULL
	,@cdEmpresaColaboradorPessoa bigint
	,@cdUsuarioUltimaAlteracao	BIGINT
 
	,@cdPessoaSEQ	BIGINT	OUTPUT
AS
 
	declare
		 @dsSenhaLoginPessoa			varchar(255)
		,@nmFoneticoPessoa				varchar(max)
		,@cdGrupoAcessoSEQ				bigint
		,@cdSolicitacaoEnvioEmailSEQ	bigint


	select
		 @dsSenhaLoginPessoa = dbo.FN_CriptografarSenha(@dsLoginPessoa)
		,@nmFoneticoPessoa = dbo.FN_ObterFonetica(@nmPessoa + ' ' + isnull(@dsLoginPessoa,''))


	if @cdIndicadorTipoPerfilPessoa = 4
	begin
		select
			@cdGrupoAcessoSEQ = 22
	end
	else
	begin
		select
			@cdGrupoAcessoSEQ = 23
	end


	--inserção
	INSERT INTO Pessoa
	(
	 cdIndicadorTipoPerfilPessoa
	,cdIndicadorStatusPessoa
	,cdIndicadorPessoa -- PF
	,cdIndicadorTipoAcessoPessoa -- Comum
	,dsLoginPessoa
	,dsSenhaLoginPessoa -- CPF Cripto
	,cdIndicadorPrimeiroAcessoPessoa -- Sim
	,cdIndicadorSenhaBloqueadaPessoa -- Não
	,nmPessoa
	,nmFoneticoPessoa -- Converter nome + login
	,nuCNPJCPFPessoa
	,enEmailPrincipalPessoa
	,cdEmpresaColaboradorPessoa -- vem do método
	,cdGrupoAcessoSEQ -- Se Perfil = 4 >>> 22 else 23
	,dtUltimaAlteracao
	,cdUsuarioUltimaAlteracao
	,cdIndicadorEnvioEmailPrimeiroAcesso -- Sim
	)
	VALUES
	(
	 @cdIndicadorTipoPerfilPessoa
	,1 -- Ativo
	,1 -- Pessoa Fisica
	,2 -- Usuário Comum
	,@dsLoginPessoa
	,@dsSenhaLoginPessoa
	,1 -- Sim
	,2 -- Não
	,@nmPessoa
	,@nmFoneticoPessoa
	,@nuCNPJCPFPessoa
	,@enEmailPrincipalPessoa
	,@cdEmpresaColaboradorPessoa
	,@cdGrupoAcessoSEQ 
	,getdate()
	,@cdUsuarioUltimaAlteracao
	,1 -- Sim
	)
 

	SELECT
		@cdPessoaSEQ = SCOPE_IDENTITY()


	--Envio de Email Inicial, contendo dados para o Primeiro Login
	EXEC SP_I_SolicitacaoEnvioEmail_InclusaoPessoa
		 @cdPessoaSEQ							= @cdPessoaSEQ
		,@nmPessoa								= @nmPessoa
		,@dsLoginPessoa							= @dsLoginPessoa
		,@dsSenhaLoginPessoa					= @dsLoginPessoa
		,@cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
		,@cdSolicitacaoEnvioEmailSEQ			= @cdSolicitacaoEnvioEmailSEQ



	SELECT
		@cdPessoaSEQ as cdPessoaSEQ
 
 
