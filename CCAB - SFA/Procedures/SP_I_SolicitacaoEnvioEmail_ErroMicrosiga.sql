set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_I_SolicitacaoEnvioEmail_ErroMicroSiga.sql
**		Name: SP_I_SolicitacaoEnvioEmail_ErroMicroSiga
**		Desc: Insere os registros na tabela SolicitacaoEnvioEmail para Erros do Microsiga
**
**		Auth: Roberto Chaparro
**		Date: Mai 22 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_SolicitacaoEnvioEmail_ErroMicroSiga]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_ErroMicroSiga]
END
GO

CREATE PROCEDURE [dbo].[SP_I_SolicitacaoEnvioEmail_ErroMicroSiga]
	 @cdPedidoVendaSEQ							bigint
	,@cdPedidoVendaERPSEQ						bigint
	,@nmPessoa									varchar(70)
	,@enEmail									varchar(70)
	,@Erro										varchar(max)
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

	,@cdAgenteComercialCooperativaPedidoVenda		bigint
	,@cdCronogramaSafraSEQ							bigint
	,@cdIndicadorMoedaPedidoVenda					int
	,@dtEmissaoPedidoVenda							datetime
	,@dtDigitacaoPedidoVenda						datetime
	,@vrTotalMoedaPedidoVenda						numeric(22,4)
	,@dsPessoaOrigemFaturamento						varchar(70)
	,@cdPessoaOrigemFaturamento						bigint
	
	,@dsCronogramaSafra								varchar(30)
	,@dsIndicadorMoedaPedidoVenda					varchar(70)

	,@vrTotalMoedaPedidoVendaERP					numeric(22,4)
	
	--Obtenho o modelo do e-mail
	SELECT
		 @desTemplateEmail			= desTemplateEmail
		,@desTextoTemplateEmail		= desTextoTemplateEmail
		,@desAssuntoTemplateEmail	= desAssuntoTemplateEmail
		,@desEmailCopiaOculta		= desEmailCopiaOculta
	FROM
		dbo.TemplateEmail
	WHERE
		cdTemplateEmail				= 9 --Erro no Microsiga

	--Obtenho os dados do Compromisso
	select
		 @cdAgenteComercialCooperativaPedidoVenda		= cdAgenteComercialCooperativaPedidoVenda	
		,@cdCronogramaSafraSEQ							= cdCronogramaSafraSEQ						
		,@cdIndicadorMoedaPedidoVenda					= cdIndicadorMoedaPedidoVenda	
		,@dtEmissaoPedidoVenda							= dtEmissaoPedidoVenda	
		,@dtDigitacaoPedidoVenda						= dtDigitacaoPedidoVenda
		,@vrTotalMoedaPedidoVenda						= vrTotalMoedaPedidoVenda			
		,@cdPessoaOrigemFaturamento						= cdPessoaOrigemFaturamento
	from
		dbo.PedidoVenda
	where
		cdPedidoVendaSEQ								= @cdPedidoVendaSEQ

	--Obtenho a descrição da Moeada
	select
		@dsIndicadorMoedaPedidoVenda		= wkDominioCodigoReferenciado
	from
		dbo.CodigoReferenciado
	where
		vrDominioCodigoReferenciado				= @cdIndicadorMoedaPedidoVenda
	and	dsDominioCodigoReferenciado				= 'DMESPINDICADORMOEDA'

	--Obtenho a descrição da Origem do Faturamento
	select
		@dsPessoaOrigemFaturamento = nmPessoa
	from
		dbo.Pessoa
	where
		cdPessoaSEQ  = @cdPessoaOrigemFaturamento
		
	--Obtenho a Descrição da Safra
	select
		 @dsCronogramaSafra						= dsCronogramaSafra
	from
		dbo.CronogramaSafra
	where
		cdCronogramaSafraSEQ					= @cdCronogramaSafraSEQ


	--Obtenho o Valor Total do Pedido ERP
	select
		@vrTotalMoedaPedidoVendaERP				= vrTotalMoedaPedidoVendaERP
	from
		dbo.PedidoVendaERP
	where
		cdPedidoVendaERPSEQ						= @cdPedidoVendaERPSEQ
	
--	-- Define Cursor para os agentes envolvidos no e-mail
--	declare @Fetch_Agente	int
--	declare @cdPessoaSEQEmail bigint
--		
--	declare CS_Agente cursor for
--	select	cdPessoaSEQ, isnull(enEmailPrincipalPessoa,'')--, nmPessoa
--	from	Pessoa
--	Where	cdPessoaSEQ = @cdAgenteComercialCooperativaPedidoVenda
--	and     cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Desbloqueada
--	union
--	select  cdPessoaSEQ, isnull(enEmailPrincipalPessoa,'')--, nmPessoa
--	from	Pessoa
--	where	cdEmpresaColaboradorPessoa = @cdAgenteComercialCooperativaPedidoVenda
--	and     cdIndicadorTipoPerfilPessoa = 4		-- Perfil Colaborador Agente
--	and     cdIndicadorSenhaBloqueadaPessoa = 2 -- Senha Desbloqueada
--
--	OPEN CS_Agente
--	FETCH NEXT FROM CS_Agente
--	INTO	 @cdPessoaSEQEmail
--			,@enPessoaEmail
--			--,@nmPessoa
--			
--
--	SET @Fetch_Agente = @@FETCH_STATUS
--	
--	WHILE @Fetch_Agente = 0
--	BEGIN	
--
--		-- Envia e-mail somente se o e-mail estiver cadastrado na base
--		IF @enPessoaEmail <> ''
--		BEGIN
		

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
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dsMoeda#'), @dsIndicadorMoedaPedidoVenda)				

		,@PosicaoTexto				= CHARINDEX('#dtEmissao#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dtEmissao#'), convert(varchar, @dtEmissaoPedidoVenda, 103))				

		,@PosicaoTexto				= CHARINDEX('#nrPedidoSFA#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nrPedidoSFA#'), convert(varchar, @cdPedidoVendaSEQ))				

		--Passar 2 vezes, pois a variável está contida 2 vezes no template
		,@PosicaoTexto				= CHARINDEX('#nrPedidoSFA#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nrPedidoSFA#'), convert(varchar, @cdPedidoVendaSEQ))				

		,@PosicaoTexto				= CHARINDEX('#dtDigitacao#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#dtDigitacao#'), convert(varchar, @dtDigitacaoPedidoVenda, 103))				

		,@PosicaoTexto				= CHARINDEX('#ErroMicrosiga#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#ErroMicrosiga#'), @Erro)				

		,@PosicaoTexto				= CHARINDEX('#nrPedidoERP#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#nrPedidoERP#'), convert(varchar, @cdPedidoVendaERPSEQ))				

		,@PosicaoTexto				= CHARINDEX('#vlTotal#', @desTextoTemplateEmailNovo)
		,@desTextoTemplateEmailNovo	= STUFF(@desTextoTemplateEmailNovo, @PosicaoTexto,len('#vlTotal#'), dbo.FN_FormatarValor(@vrTotalMoedaPedidoVendaERP, 2))				



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
		,@enEmail		--email da pessoa
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
				
				
--		END
--
--		FETCH NEXT FROM CS_Agente
--		INTO	 @cdPessoaSEQEmail
--				,@enPessoaEmail
--				--,@nmPessoa
--
--		SET @Fetch_Agente = @@FETCH_STATUS
--		
--	END
--	
--	CLOSE CS_Agente
--	DEALLOCATE CS_Agente
	
SET QUOTED_IDENTIFIER OFF

