set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_SolicitacaoEnvioEmail_InclusaoPessoa
**		Name: SP_I_SolicitacaoEnvioEmail_InclusaoPessoa
**		Desc: Insere os registros na tabela SolicitacaoEnvioEmail
**
**		Auth: Roberto Chaparro
**		Date: Mar 18 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_SolicitacaoEnvioEmail_InclusaoPessoa]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_InclusaoPessoa]
END
GO

CREATE PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_InclusaoPessoa]
	 @cdPessoaSEQ								bigint
	,@nmPessoa									varchar(70)
	,@dsLoginPessoa								varchar(30)
	,@dsSenhaLoginPessoa						varchar(255)
	,@cdUsuarioUltimaAlteracao					bigint

	,@cdSolicitacaoEnvioEmailSEQ				int				OUTPUT
AS


declare
	 @desTemplateEmail				varchar(70)
	,@desTextoTemplateEmail			varchar(8000)
	,@desAssuntoTemplateEmail		varchar(70)

	,@PosicaoTexto					int
	,@desTextoTemplateEmailNovo		varchar(8000)

	,@enPessoaEmail					varchar(70)
	,@desEmailCopiaOculta			varchar(255)
	

	--Obtenho o modelo do e-mail
	SELECT
		 @desTemplateEmail			= desTemplateEmail
		,@desTextoTemplateEmail		= desTextoTemplateEmail
		,@desAssuntoTemplateEmail	= desAssuntoTemplateEmail
		,@desEmailCopiaOculta		= desEmailCopiaOculta
	FROM
		dbo.TemplateEmail
	WHERE
		cdTemplateEmail				= 2 --Envio de Senha Inicial


	--Coloco em mai�sculas
	SELECT
		 @nmPessoa		= upper(@nmPessoa)
		,@dsLoginPessoa	= upper(@dsLoginPessoa)


	--substituo as vari�veis do texto
	SELECT
		 @desTextoTemplateEmailNovo = @desTextoTemplateEmail

		,@PosicaoTexto				= CHARINDEX('#usuario#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#usuario#'), @nmPessoa)				

		,@PosicaoTexto				= CHARINDEX('#login#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#login#'), @dsLoginPessoa)				

		,@PosicaoTexto				= CHARINDEX('#senha#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#senha#'), @dsSenhaLoginPessoa)				


	
	--obtenho o email preferencial da pessoa
	SELECT
		@enPessoaEmail		= isnull(enEmailPrincipalPessoa, '')
	FROM
		dbo.Pessoa
	WHERE
		cdPessoaSEQ			= @cdPessoaSEQ



	INSERT INTO	dbo.SolicitacaoEnvioEmail
		(datSolicitacaoEnvioEmail
		,cdIndicadorStatusSolicitacaoEnvioEmail
		,desSolicitacaoEnvioEmail
		,desEmailSolicitacaoEnvioEmail
		,datEnvioSolicitacaoEnvioEmail
		,desTextoSolicitacaoEnvioEmail
		,desAssuntoSolicitacaoEnvioEmail
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		,desErroEnvioSolicitacaoEnvioEmail
		,desEmailCopiaOculta)
	VALUES
		(getdate()
		,1					--Ativo
		,@desTemplateEmail
		,@enPessoaEmail		--email da pessoa
		,getdate()
		,@desTextoTemplateEmailNovo
		,@desAssuntoTemplateEmail
		,getdate()
		,@cdUsuarioUltimaAlteracao
		,NULL
		,@desEmailCopiaOculta)

	select
		@cdSolicitacaoEnvioEmailSEQ = SCOPE_IDENTITY()

	select
		@cdSolicitacaoEnvioEmailSEQ	as cdSolicitacaoEnvioEmailSEQ


SET QUOTED_IDENTIFIER OFF

