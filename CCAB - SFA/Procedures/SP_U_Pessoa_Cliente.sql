set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_U_Pessoa_Cliente.sql
**		Name: SP_U_Pessoa_Cliente
**		Desc: Altera um registro na tabela Pessoa - Cliente
**
**		Auth: Convergence
**		Date: 16/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_U_Pessoa_Cliente]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_U_Pessoa_Cliente]
END
GO
 
CREATE PROCEDURE [dbo].[SP_U_Pessoa_Cliente]
	 @cdPessoaSEQ	BIGINT
	,@cdIndicadorTipoAcessoPessoa	INT
	,@dsLoginPessoa	VARCHAR(30) = NULL
	,@cdIndicadorPrimeiroAcessoPessoa	INT
	,@cdIndicadorSenhaBloqueadaPessoa	INT
	,@cdGrupoAcessoSEQ	BIGINT = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT
 
AS

	declare
		 @nmPessoa									varchar(70)
		,@nuCNPJCPFPessoa							varchar(30)
		,@cdIndicadorEnvioEmailPrimeiroAcesso		int
		,@cdSolicitacaoEnvioEmailSEQ				bigint
		,@dsSenhaLoginPessoa						varchar(255)
		,@cdIndicadorPrimeiroAcessoPessoaAnterior	int
		,@nmFoneticoPessoa							varchar(max)




	--Obtenho os dados da pessoa
	select
	     @nmPessoa									= isnull(nmPessoa, '')						
		,@nuCNPJCPFPessoa							= isnull(nuCNPJCPFPessoa, '')				
		,@cdIndicadorEnvioEmailPrimeiroAcesso		= cdIndicadorEnvioEmailPrimeiroAcesso
		,@dsSenhaLoginPessoa						= dbo.FN_DecriptografarSenha(dsSenhaLoginPessoa)
		,@cdIndicadorPrimeiroAcessoPessoaAnterior	= cdIndicadorPrimeiroAcessoPessoa
	from
		dbo.Pessoa
	where
		cdPessoaSEQ	= @cdPessoaSEQ
 
	select
		@nmFoneticoPessoa = dbo.FN_ObterFonetica(@nmPessoa + ' ' + isnull(@dsLoginPessoa,''))

	--atualização
	UPDATE dbo.Pessoa SET
		 cdIndicadorTipoAcessoPessoa = @cdIndicadorTipoAcessoPessoa
		,dsLoginPessoa = @dsLoginPessoa
		,cdIndicadorPrimeiroAcessoPessoa = @cdIndicadorPrimeiroAcessoPessoa
		,cdIndicadorSenhaBloqueadaPessoa = @cdIndicadorSenhaBloqueadaPessoa
		,cdGrupoAcessoSEQ = @cdGrupoAcessoSEQ
		,dtUltimaAlteracao = getdate()
		,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao
		,nmFoneticoPessoa = @nmFoneticoPessoa

	WHERE 
		 cdPessoaSEQ = @cdPessoaSEQ
 
 
	if @cdIndicadorPrimeiroAcessoPessoaAnterior = 2 --Não
	begin
		if @cdIndicadorPrimeiroAcessoPessoa = 1 --Sim
		begin
			UPDATE dbo.Pessoa SET
				dsSenhaLoginPessoa = dbo.FN_CriptografarSenha(dsLoginPessoa)
			WHERE 
				cdPessoaSEQ = @cdPessoaSEQ
		end
	end



	if @cdIndicadorSenhaBloqueadaPessoa = 2 --Não
	begin
		if @cdIndicadorEnvioEmailPrimeiroAcesso = 2 --Não
		begin
			--Envio de Email Inicial, contendo dados para o Primeiro Login
			EXEC SP_I_SolicitacaoEnvioEmail_InclusaoPessoa
				 @cdPessoaSEQ							= @cdPessoaSEQ
				,@nmPessoa								= @nmPessoa
				,@dsLoginPessoa							= @dsLoginPessoa
				,@dsSenhaLoginPessoa					= @dsSenhaLoginPessoa
				,@cdUsuarioUltimaAlteracao				= @cdUsuarioUltimaAlteracao
				,@cdSolicitacaoEnvioEmailSEQ			= @cdSolicitacaoEnvioEmailSEQ

			UPDATE dbo.Pessoa SET
				cdIndicadorEnvioEmailPrimeiroAcesso = 1 --Sim

			WHERE 
				cdPessoaSEQ = @cdPessoaSEQ

		end
	end





/*
-----------------------------------------------
Método C#
 
Parâmetros:
Int64 cdPessoaSEQ, int cdIndicadorTipoAcessoPessoa, string dsLoginPessoa, int cdIndicadorPrimeiroAcessoPessoa, int cdIndicadorSenhaBloqueadaPessoa, Int64 cdGrupoAcessoSEQ, Int64 cdUsuarioUltimaAlteracao
 
Corpo:
		if (cdPessoaSEQ != 0)
		{
			loSqlCommand.Parameters.Add("@cdPessoaSEQ", SqlDbType.BigInt);
			loSqlCommand.Parameters["@cdPessoaSEQ"].Value = cdPessoaSEQ;
		}

			loSqlCommand.Parameters.Add("@cdPessoaERP", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@cdPessoaERP"].Value = cdPessoaERP;

		if (cdIndicadorTipoPerfilPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorTipoPerfilPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorTipoPerfilPessoa"].Value = cdIndicadorTipoPerfilPessoa;
		}

		if (cdIndicadorStatusPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorStatusPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorStatusPessoa"].Value = cdIndicadorStatusPessoa;
		}

		if (cdIndicadorPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorPessoa"].Value = cdIndicadorPessoa;
		}

		if (cdIndicadorTipoAcessoPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorTipoAcessoPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorTipoAcessoPessoa"].Value = cdIndicadorTipoAcessoPessoa;
		}

			loSqlCommand.Parameters.Add("@dsLoginPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@dsLoginPessoa"].Value = dsLoginPessoa;

			loSqlCommand.Parameters.Add("@dsSenhaLoginPessoa", SqlDbType.VarChar, 255);
			loSqlCommand.Parameters["@dsSenhaLoginPessoa"].Value = dsSenhaLoginPessoa;

		if (cdIndicadorPrimeiroAcessoPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorPrimeiroAcessoPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorPrimeiroAcessoPessoa"].Value = cdIndicadorPrimeiroAcessoPessoa;
		}

		if (cdIndicadorSenhaBloqueadaPessoa != 0)
		{
			loSqlCommand.Parameters.Add("@cdIndicadorSenhaBloqueadaPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorSenhaBloqueadaPessoa"].Value = cdIndicadorSenhaBloqueadaPessoa;
		}

		if (nmPessoa.Trim() != "")
		{
			loSqlCommand.Parameters.Add("@nmPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@nmPessoa"].Value = nmPessoa;
		}

			loSqlCommand.Parameters.Add("@nmReduzidoPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nmReduzidoPessoa"].Value = nmReduzidoPessoa;

			loSqlCommand.Parameters.Add("@nmFoneticoPessoa", SqlDbType.VarChar, 8000);
			loSqlCommand.Parameters["@nmFoneticoPessoa"].Value = nmFoneticoPessoa;

			loSqlCommand.Parameters.Add("@nuCNPJCPFPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuCNPJCPFPessoa"].Value = nuCNPJCPFPessoa;

			loSqlCommand.Parameters.Add("@nuIncricaoEstadualPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuIncricaoEstadualPessoa"].Value = nuIncricaoEstadualPessoa;

			loSqlCommand.Parameters.Add("@nuIncricaoMunicipalPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuIncricaoMunicipalPessoa"].Value = nuIncricaoMunicipalPessoa;

			loSqlCommand.Parameters.Add("@nuIncricaoRuralPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuIncricaoRuralPessoa"].Value = nuIncricaoRuralPessoa;

			loSqlCommand.Parameters.Add("@nuRGCedulaEstrangeiroPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuRGCedulaEstrangeiroPessoa"].Value = nuRGCedulaEstrangeiroPessoa;

			loSqlCommand.Parameters.Add("@cdNacionalidadePessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdNacionalidadePessoa"].Value = cdNacionalidadePessoa;

			loSqlCommand.Parameters.Add("@dtNascimentoPessoa", SqlDbType.datetime);
			loSqlCommand.Parameters["@dtNascimentoPessoa"].Value = dtNascimentoPessoa;

			loSqlCommand.Parameters.Add("@cdIndicadorSexoPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorSexoPessoa"].Value = cdIndicadorSexoPessoa;

			loSqlCommand.Parameters.Add("@cdIndicadorEstadoCivilPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdIndicadorEstadoCivilPessoa"].Value = cdIndicadorEstadoCivilPessoa;

			loSqlCommand.Parameters.Add("@cdPaisEnderecoPrincipalPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdPaisEnderecoPrincipalPessoa"].Value = cdPaisEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@enLogradouroEnderecoPrincipalPessoa", SqlDbType.VarChar, 100);
			loSqlCommand.Parameters["@enLogradouroEnderecoPrincipalPessoa"].Value = enLogradouroEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@enBairroEnderecoPrincipalPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@enBairroEnderecoPrincipalPessoa"].Value = enBairroEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@enMunicipioEnderecoPrincipalPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@enMunicipioEnderecoPrincipalPessoa"].Value = enMunicipioEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@cdSiglaEstadoEnderecoPrincipalPessoa", SqlDbType.VarChar, 5);
			loSqlCommand.Parameters["@cdSiglaEstadoEnderecoPrincipalPessoa"].Value = cdSiglaEstadoEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@nuCEPEnderecoPrincipalPessoa", SqlDbType.VarChar, 8);
			loSqlCommand.Parameters["@nuCEPEnderecoPrincipalPessoa"].Value = nuCEPEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@nuCaixaPostalEnderecoPrincipalPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuCaixaPostalEnderecoPrincipalPessoa"].Value = nuCaixaPostalEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@enReferenciaEnderecoPrincipalPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@enReferenciaEnderecoPrincipalPessoa"].Value = enReferenciaEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@cdPaisEnderecoCobrancaPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdPaisEnderecoCobrancaPessoa"].Value = cdPaisEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@enLogradouroEnderecoCobrancaPessoa", SqlDbType.VarChar, 100);
			loSqlCommand.Parameters["@enLogradouroEnderecoCobrancaPessoa"].Value = enLogradouroEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@enComplementoEnderecoCobrancaPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@enComplementoEnderecoCobrancaPessoa"].Value = enComplementoEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@enComplementoEnderecoPrincipalPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@enComplementoEnderecoPrincipalPessoa"].Value = enComplementoEnderecoPrincipalPessoa;

			loSqlCommand.Parameters.Add("@enBairroEnderecoCobrancaPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@enBairroEnderecoCobrancaPessoa"].Value = enBairroEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@enMunicipioEnderecoCobrancaPessoa", SqlDbType.VarChar, 70);
			loSqlCommand.Parameters["@enMunicipioEnderecoCobrancaPessoa"].Value = enMunicipioEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@cdSiglaEstadoEnderecoCobrancaPessoa", SqlDbType.VarChar, 5);
			loSqlCommand.Parameters["@cdSiglaEstadoEnderecoCobrancaPessoa"].Value = cdSiglaEstadoEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@nuCEPEnderecoCobrancaPessoa", SqlDbType.VarChar, 8);
			loSqlCommand.Parameters["@nuCEPEnderecoCobrancaPessoa"].Value = nuCEPEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@nuCaixaPostalEnderecoCobrancaPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@nuCaixaPostalEnderecoCobrancaPessoa"].Value = nuCaixaPostalEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@enReferenciaEnderecoCobrancaPessoa", SqlDbType.VarChar, 30);
			loSqlCommand.Parameters["@enReferenciaEnderecoCobrancaPessoa"].Value = enReferenciaEnderecoCobrancaPessoa;

			loSqlCommand.Parameters.Add("@cdPaisEnderecoEntregaPessoa", SqlDbType.Int);
			loSqlCommand.Parameters["@cdPaisEnderecoEntregaPessoa"].Value = cdPaisEnderecoEntregaPessoa;

			loSqlCommand.Parameters.Add("@enLogradouroEnderecoEntregaPessoa", SqlDbType.VarChar, 100);
			loSqlCommand.Parameters["@enLogradouroEnderecoEntregaPessoa"].Value = enLogradouroE
*/
