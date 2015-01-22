set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa
**		Name: SP_G_Pessoa
**		Desc: Seleciona registros na tabela Pessoa
**
**		Auth: Roberto Chaparro
**		Date: Mar 11 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa]
	 @cdIndicadorTipoPerfilPessoa		int
	,@cdPessoaERP						varchar(30)		= null
	,@dsLoginPessoa						varchar(30)		= null
	,@nuCNPJCPFPessoa					varchar(30)		= null
	,@nmFoneticoPessoa					varchar(8000)	= null
	,@cdIndicadorStatusPessoa			int				= null
	,@cdIndicadorSenhaBloqueadaPessoa	int				= null

AS

DECLARE
	@lsComando		varchar(max)


	select
		 @lsComando = 'SELECT ' 

		,@lsComando = @lsComando + '	  PES.cdPessoaSEQ'
		,@lsComando = @lsComando + '	 ,PES.cdPessoaERP'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorTipoPerfilPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorStatusPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorTipoAcessoPessoa'
		,@lsComando = @lsComando + '	 ,PES.dsLoginPessoa'
		,@lsComando = @lsComando + '	 ,PES.dsSenhaLoginPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorPrimeiroAcessoPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorSenhaBloqueadaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmReduzidoPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmFoneticoPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCNPJCPFPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoEstadualPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoMunicipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuInscricaoRuralPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuRGCedulaEstrangeiroPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdNacionalidadePessoa'
		,@lsComando = @lsComando + '	 ,PES.dtNascimentoPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorSexoPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdIndicadorEstadoCivilPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enLogradouroEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enComplementoEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enBairroEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enMunicipioEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdSiglaEstadoEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCEPEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuCaixaPostalEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.enReferenciaEnderecoEntregaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefonePrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefoneFAXPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdPaisTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuDDDTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.nuTelefoneCelularPessoa'
		,@lsComando = @lsComando + '	 ,PES.enEmailPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmContatoPrincipalPessoa'
		,@lsComando = @lsComando + '	 ,PES.nmContatoCobrancaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdEmpresaColaboradorPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdAgenteComercialRCPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdAgenteComercialCooperativaPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdAgenteComercialCCABPessoa'
		,@lsComando = @lsComando + '	 ,PES.cdGrupoAcessoSEQ'
		,@lsComando = @lsComando + '	 ,PES.dtUltimaAlteracao'
		,@lsComando = @lsComando + '	 ,PES.cdUsuarioUltimaAlteracao'


		,@lsComando = @lsComando + ' FROM '
		,@lsComando = @lsComando + '	dbo.Pessoa				PES '

		,@lsComando = @lsComando + 'WHERE '
		,@lsComando = @lsComando + '	PES.cdPessoaSEQ	> 0 '

		,@lsComando = @lsComando + 'AND cdIndicadorTipoPerfilPessoa = ' + convert(varchar, @cdIndicadorTipoPerfilPessoa)


		IF NOT @cdPessoaERP is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.cdPessoaERP))) = ''' 
				,@lsComando = @lsComando + upper(ltrim(rtrim(@cdPessoaERP)))
				,@lsComando = @lsComando + '''' 
		END	

		IF NOT @dsLoginPessoa is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.dsLoginPessoa))) = ''' 
				,@lsComando = @lsComando + upper(ltrim(rtrim(@dsLoginPessoa)))
				,@lsComando = @lsComando + '''' 
		END	

		IF NOT @nuCNPJCPFPessoa is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.nuCNPJCPFPessoa))) = ''' 
				,@lsComando = @lsComando + upper(ltrim(rtrim(@nuCNPJCPFPessoa)))
				,@lsComando = @lsComando + '''' 
		END	

		IF NOT @nmFoneticoPessoa is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.nmFoneticoPessoa))) like ''' 
				,@lsComando = @lsComando + upper(ltrim(rtrim(@nmFoneticoPessoa)))
				,@lsComando = @lsComando + '%' + '''' 
		END

		IF NOT @cdIndicadorStatusPessoa is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 PES.cdIndicadorStatusPessoa = ' 
				,@lsComando = @lsComando + convert(varchar,@cdIndicadorStatusPessoa)
				,@lsComando = @lsComando + ' ' 
		END

		IF NOT @cdIndicadorSenhaBloqueadaPessoa is null
		BEGIN
			select
				 @lsComando = @lsComando + 'AND	 PES.cdIndicadorSenhaBloqueadaPessoa = ' 
				,@lsComando = @lsComando + convert(varchar,@cdIndicadorSenhaBloqueadaPessoa)
				,@lsComando = @lsComando + ' ' 
		END



--
--	IF NOT @dsLoginPessoa is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PES.dsLoginPessoa))) = ''' 
--			,@lsComando = @lsComando + upper(ltrim(rtrim(@dsLoginPessoa)))
--			,@lsComando = @lsComando + '''' 
--	END
--
--	IF NOT @nuCNPJPessoaJuridica is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	 PJU.nuCNPJPessoaJuridica = ' 
--			,@lsComando = @lsComando + convert(varchar,@nuCNPJPessoaJuridica)
--			,@lsComando = @lsComando + ' ' 
--	END
--
--	IF NOT @nmRazaoSocialPessoaJuridica is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	 upper(ltrim(rtrim(PJU.nmRazaoSocialPessoaJuridica))) like ''' 
--			,@lsComando = @lsComando + upper(ltrim(rtrim(@nmRazaoSocialPessoaJuridica)))
--			,@lsComando = @lsComando + '%' + '''' 
--	END
--
--	IF NOT @cdIndicadorTipoPessoaPerfil is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	EXISTS	( '
--			,@lsComando = @lsComando + '		SELECT '
--			,@lsComando = @lsComando + '			cdPessoaSEQ '
--			,@lsComando = @lsComando + '		FROM '
--			,@lsComando = @lsComando + '			dbo.PessoaPerfil '
--			,@lsComando = @lsComando + '		WHERE '
--			,@lsComando = @lsComando + '			cdPessoaSEQ = PES.cdPessoaSEQ '
--			,@lsComando = @lsComando + 'AND	 cdIndicadorTipoPessoaPerfil = ' 
--			,@lsComando = @lsComando + convert(varchar, @cdIndicadorTipoPessoaPerfil)
--			,@lsComando = @lsComando + '				) '
--	END
--
--
--	IF NOT @cdIndicadorSenhaBloqueadaPessoa is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	 PES.cdIndicadorSenhaBloqueadaPessoa = ' 
--			,@lsComando = @lsComando + convert(varchar,@cdIndicadorSenhaBloqueadaPessoa)
--			,@lsComando = @lsComando + ' ' 
--	END
--
--	IF NOT @cdPessoaSEQ is null
--	BEGIN
--		select
--			 @lsComando = @lsComando + 'AND	 PES.cdPessoaSEQ = ' 
--			,@lsComando = @lsComando + convert(varchar,@cdPessoaSEQ)
--			,@lsComando = @lsComando + ' ' 
--	END


	select
		 @lsComando = @lsComando + 'ORDER BY '
		,@lsComando = @lsComando + '	PES.nmPessoa '



	EXEC(@lsComando)
	--print @lsComando

SET QUOTED_IDENTIFIER OFF

