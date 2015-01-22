set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra.sql
**		Name: SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra
**		Desc: Insere os registros na tabela SolicitacaoEnvioEmail
**
**		Auth: Roberto Chaparro
**		Date: Abr 27 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra]
END
GO

CREATE PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_LiberacaoCompromissoCompra]
	 @cdCompromissoCompraSEQ					bigint
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

	,@cdAgenteComercialCooperativaCompromissoCompra		bigint
	,@cdCronogramaSafraSEQ								bigint
	,@cdIndicadorMoedaCompromissoCompra					int
	,@dtEmissaoCompromissoCompra						datetime
	,@vrTotalMoedaCompromissoCompra						numeric(22,4)
	,@dsPessoaOrigemFaturamento							varchar(70)
	,@cdPessoaOrigemFaturamento							bigint
	
	,@nmPessoa											varchar(70)
	,@dsCronogramaSafra									varchar(30)
	,@dsIndicadorMoedaCompromissoCompra					varchar(70)
	,@dtLimiteLiberacaoPVCronogramaSafra				datetime


	--Obtenho o modelo do e-mail
	SELECT
		 @desTemplateEmail			= desTemplateEmail
		,@desTextoTemplateEmail		= desTextoTemplateEmail
		,@desAssuntoTemplateEmail	= desAssuntoTemplateEmail
		,@desEmailCopiaOculta		= desEmailCopiaOculta
	FROM
		dbo.TemplateEmail
	WHERE
		cdTemplateEmail				= 3 --Liberação de Comprimisso

	--Obtenho os dados do Compromisso
	select
		 @cdAgenteComercialCooperativaCompromissoCompra		= cdAgenteComercialCooperativaCompromissoCompra	
		,@cdCronogramaSafraSEQ								= cdCronogramaSafraSEQ						
		,@cdIndicadorMoedaCompromissoCompra					= cdIndicadorMoedaCompromissoCompra			
		,@dtEmissaoCompromissoCompra						= dtEmissaoCompromissoCompra		
		,@vrTotalMoedaCompromissoCompra						= vrTotalMoedaCompromissoCompra					
		,@cdPessoaOrigemFaturamento							= cdPessoaOrigemFaturamento
	from
		dbo.CompromissoCompra
	where
		cdCompromissoCompraSEQ								= @cdCompromissoCompraSEQ

	--Obtenho a Descrição e Data Limite da Safra
	select
		 @dsCronogramaSafra						= dsCronogramaSafra
		,@dtLimiteLiberacaoPVCronogramaSafra	= dtLimiteLiberacaoPVCronogramaSafra
	from
		dbo.CronogramaSafra
	where
		cdCronogramaSafraSEQ					= @cdCronogramaSafraSEQ

	--Obtenho a descrição da Moeada
	select
		@dsIndicadorMoedaCompromissoCompra		= wkDominioCodigoReferenciado
	from
		dbo.CodigoReferenciado
	where
		vrDominioCodigoReferenciado				= @cdIndicadorMoedaCompromissoCompra
	and	dsDominioCodigoReferenciado				= 'DMESPINDICADORMOEDA'

	--Obtenho a descrição da Origem do Faturamento
	select
		@dsPessoaOrigemFaturamento = nmPessoa
	from
		dbo.Pessoa
	where
		cdPessoaSEQ  = @cdPessoaOrigemFaturamento
	
	-- Define Cursor para os agentes envolvidos no e-mail
	declare @Fetch_Agente	int
	declare @cdPessoaSEQEmail bigint
		
	declare CS_Agente cursor for
	select	cdPessoaSEQ, isnull(enEmailPrincipalPessoa,''), nmPessoa
	from	Pessoa
	Where	cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
	and     cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Desbloqueada
	union
	select  cdPessoaSEQ, isnull(enEmailPrincipalPessoa,''), nmPessoa
	from	Pessoa
	where	cdEmpresaColaboradorPessoa = @cdAgenteComercialCooperativaCompromissoCompra
	and     cdIndicadorTipoPerfilPessoa = 4		-- Perfil Colaborador Agente
	and     cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Desbloqueada

	OPEN CS_Agente
	FETCH NEXT FROM CS_Agente
	INTO	 @cdPessoaSEQEmail
			,@enPessoaEmail
			,@nmPessoa
			

	SET @Fetch_Agente = @@FETCH_STATUS
	
	WHILE @Fetch_Agente = 0
	BEGIN	

		-- Envia e-mail somente se o e-mail estiver cadastrado na base
		IF @enPessoaEmail <> ''
		BEGIN
		
			--substituo as variáveis do texto
			SELECT
				 @desTextoTemplateEmailNovo = @desTextoTemplateEmail

				,@PosicaoTexto				= CHARINDEX('#nmAgente#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nmAgente#'), @nmPessoa)				

				,@PosicaoTexto				= CHARINDEX('#dsSafra#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dsSafra#'), @dsCronogramaSafra)				

				,@PosicaoTexto				= CHARINDEX('#OrigemFaturamento#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#OrigemFaturamento#'), @dsPessoaOrigemFaturamento)				

				,@PosicaoTexto				= CHARINDEX('#dsMoeda#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dsMoeda#'), @dsIndicadorMoedaCompromissoCompra)				

				,@PosicaoTexto				= CHARINDEX('#nrCompromisso#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nrCompromisso#'), convert(varchar, @cdCompromissoCompraSEQ))				

				,@PosicaoTexto				= CHARINDEX('#dtEmissao#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dtEmissao#'), convert(varchar, @dtEmissaoCompromissoCompra, 103))				

				,@PosicaoTexto				= CHARINDEX('#vlTotal#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#vlTotal#'), dbo.FN_FormatarValor(@vrTotalMoedaCompromissoCompra, 2))				

				,@PosicaoTexto				= CHARINDEX('#nrCompromissoTexto#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nrCompromissoTexto#'), convert(varchar, @cdCompromissoCompraSEQ))				

				,@PosicaoTexto				= CHARINDEX('#dtLimiteEnvioPedido#', @desTextoTemplateEmailNovo)
				,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dtLimiteEnvioPedido#'), convert(varchar, @dtLimiteLiberacaoPVCronogramaSafra, 103))				

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
				
				
		END

		FETCH NEXT FROM CS_Agente
		INTO	 @cdPessoaSEQEmail
				,@enPessoaEmail
				,@nmPessoa

		SET @Fetch_Agente = @@FETCH_STATUS
		
	END
	
	CLOSE CS_Agente
	DEALLOCATE CS_Agente
	
SET QUOTED_IDENTIFIER OFF

