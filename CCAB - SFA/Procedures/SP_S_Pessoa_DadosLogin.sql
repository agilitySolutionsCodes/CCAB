set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_S_Pessoa_DadosLogin
**		Name: SP_S_Pessoa_DadosLogin
**		Desc: Retorna o Id da pessoa caso encontre seu Login
**
**		Auth: Roberto Chaparro
**		Date: Jan 13 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_Pessoa_DadosLogin]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_Pessoa_DadosLogin]
END
GO

CREATE PROCEDURE [dbo].[SP_S_Pessoa_DadosLogin]
	 @dsLoginPessoa			varchar(30)
	,@dsSenhaLoginPessoa	varchar(255)	= null

AS

declare
	 @cdPessoaSEQ					bigint
	,@cdIndicadorPessoa				int
	,@nmNome						varchar(70)
	,@dsSenhaLoginPessoaRetorno		varchar(255)
	,@cdIndicadorTipoAcessoPessoa	int
	,@cdIndicadorTipoPerfilPessoa	int

	if @dsSenhaLoginPessoa is null
	begin
		SELECT
			 @cdPessoaSEQ					= cdPessoaSEQ
			,@cdIndicadorPessoa				= cdIndicadorPessoa
			,@dsSenhaLoginPessoaRetorno		= dsSenhaLoginPessoa
			,@cdIndicadorTipoAcessoPessoa	= cdIndicadorTipoAcessoPessoa
			,@nmNome						= nmPessoa
			,@cdIndicadorTipoPerfilPessoa	= cdIndicadorTipoPerfilPessoa
		FROM
			dbo.Pessoa (nolock)
		WHERE
			upper(rtrim(ltrim(dsLoginPessoa)))		= upper(rtrim(ltrim(@dsLoginPessoa)))
	end
	else
	begin
		SELECT
			 @cdPessoaSEQ					= cdPessoaSEQ
			,@cdIndicadorPessoa				= cdIndicadorPessoa
			,@dsSenhaLoginPessoaRetorno		= @dsSenhaLoginPessoa
			,@cdIndicadorTipoAcessoPessoa	= cdIndicadorTipoAcessoPessoa
			,@nmNome						= nmPessoa
			,@cdIndicadorTipoPerfilPessoa	= cdIndicadorTipoPerfilPessoa
		FROM
			dbo.Pessoa (nolock)
		WHERE
			upper(rtrim(ltrim(dsLoginPessoa)))		= upper(rtrim(ltrim(@dsLoginPessoa)))
		AND	dsSenhaLoginPessoa						= @dsSenhaLoginPessoa
	end

	IF @cdPessoaSEQ is null
	BEGIN
		select
			 @cdPessoaSEQ					= 0
			,@nmNome						= ''
			,@cdIndicadorTipoAcessoPessoa	= 0
			,@cdIndicadorPessoa				= 0
			,@cdIndicadorTipoPerfilPessoa	= 0
	END



	--Retorno
	SELECT
		 @cdPessoaSEQ					as cdPessoaSEQ		
		,@nmNome						as nmNome 	
		,@dsSenhaLoginPessoaRetorno		as dsSenhaLoginPessoa			
		,@cdIndicadorTipoAcessoPessoa	as cdIndicadorTipoAcessoPessoa
		,@cdIndicadorPessoa				as cdIndicadorPessoa
		,@cdIndicadorTipoPerfilPessoa	as cdIndicadorTipoPerfilPessoa

SET QUOTED_IDENTIFIER OFF

