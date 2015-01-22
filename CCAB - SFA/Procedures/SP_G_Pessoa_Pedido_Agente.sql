set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_Pessoa_Pedido_Agente
**		Name: SP_G_Pessoa_Pedido_Agente
**		Desc: Seleciona registros de um Agente (Pedidos)
**
**		Auth: Roberto Chaparro
**		Date: Abr 1 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_Pessoa_Pedido_Agente]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_Pessoa_Pedido_Agente]
END
GO

CREATE PROCEDURE [dbo].[SP_G_Pessoa_Pedido_Agente]
	 @cdUsuario				  bigint
	,@cdIndicadorStatusPessoa bigint = null

AS
	
	set nocount on
	
	declare
		@cdIndicadorTipoPerfilPessoa		int

	select
		@cdIndicadorTipoPerfilPessoa = 0

	--Obtenho o perfil do usuário
	select
		@cdIndicadorTipoPerfilPessoa	= cdIndicadorTipoPerfilPessoa
	from
		dbo.Pessoa
	where
		cdPessoaSEQ						= @cdUsuario


	if @cdIndicadorTipoPerfilPessoa = 1 --Cliente
	begin

		CREATE TABLE #Tabela
		(
			 [cdPessoaSEQ]	bigint
			,[nmPessoa]	varchar(max)
			,[cdIndicadorStatusPessoa] bigint
		) 


		insert into #Tabela

		select
			 PES.cdAgenteComercialCooperativaPessoa		as cdPessoaSEQ
			,(
			select distinct
				AGE.nmPessoa + '-' + AGE.cdPessoaERP
			from
				dbo.Pessoa	AGE
			where
				AGE.cdPessoaSEQ = PES.cdAgenteComercialCooperativaPessoa
			) as nmPessoa
			,cdIndicadorStatusPessoa

		from
			dbo.Pessoa	PES
		where
			PES.cdPessoaSEQ							= @cdUsuario

		union

		select
			 PES.cdAgenteComercialRCPessoa		as cdPessoaSEQ
			,(
			select distinct
				AGE.nmPessoa + '-' + AGE.cdPessoaERP
			from
				dbo.Pessoa	AGE
			where
				AGE.cdPessoaSEQ = PES.cdAgenteComercialRCPessoa
			) as nmPessoa
			,cdIndicadorStatusPessoa
		from
			dbo.Pessoa	PES
		where
			PES.cdPessoaSEQ							= @cdUsuario


		--Mostro a tabela
		if @cdIndicadorStatusPessoa is null or @cdIndicadorStatusPessoa = 0
		begin
			select
				*
			from 
				#Tabela
			where
				not cdPessoaSEQ is null
			order by
				nmPessoa
		end
		else
		begin
			select
				*
			from 
				#Tabela
			where
				not cdPessoaSEQ is null
			and cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa
			order by
				nmPessoa
		end
		

	end



	if @cdIndicadorTipoPerfilPessoa = 3 --Vendedor
	begin
		if @cdIndicadorStatusPessoa is null or @cdIndicadorStatusPessoa = 0
		begin
			select
				 cdPessoaSEQ
				,nmPessoa + '-' + cdPessoaERP	as nmPessoa
			from
				dbo.Pessoa
			where
				cdPessoaSEQ = @cdUsuario
			order by
				nmPessoa
		end
		else
		begin
			select
				 cdPessoaSEQ
				,nmPessoa + '-' + cdPessoaERP	as nmPessoa
			from
				dbo.Pessoa
			where
				cdPessoaSEQ = @cdUsuario
			and cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa
			order by
				nmPessoa
		end
	end


	if @cdIndicadorTipoPerfilPessoa = 4 --Colaborador Agente
	begin
		if @cdIndicadorStatusPessoa is null or @cdIndicadorStatusPessoa = 0
		begin
			select
				 PES.cdEmpresaColaboradorPessoa		as cdPessoaSEQ
				,(
				select distinct
					AGE.nmPessoa + '-' + AGE.cdPessoaERP
				from
					dbo.Pessoa	AGE
				where
					AGE.cdPessoaSEQ = PES.cdEmpresaColaboradorPessoa
				) as nmPessoa
			from
				dbo.Pessoa	PES
			where
				PES.cdPessoaSEQ							= @cdUsuario
			order by
				nmPessoa
		end
		else
		begin 
			select
				 PES.cdEmpresaColaboradorPessoa		as cdPessoaSEQ
				,(
				select distinct
					AGE.nmPessoa + '-' + AGE.cdPessoaERP
				from
					dbo.Pessoa	AGE
				where
					AGE.cdPessoaSEQ = PES.cdEmpresaColaboradorPessoa
				) as nmPessoa
			from
				dbo.Pessoa	PES
			where
				PES.cdPessoaSEQ							= @cdUsuario
			and cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa
			order by
				nmPessoa
		end

	end


	if (@cdIndicadorTipoPerfilPessoa = 2 or @cdIndicadorTipoPerfilPessoa = 5) --Colaborador CCAB
	begin
	
		if @cdIndicadorStatusPessoa is null or @cdIndicadorStatusPessoa = 0
		begin
			select
				 cdPessoaSEQ
				,nmPessoa 	+ '-' + cdPessoaERP as nmPessoa
			from
				dbo.Pessoa
			where
				cdIndicadorTipoPerfilPessoa = 3	--Agente Comercial
			order by
				nmPessoa
		end
		else
		begin
			select
				 cdPessoaSEQ
				,nmPessoa + '-' + cdPessoaERP 	as nmPessoa
			from
				dbo.Pessoa
			where
				cdIndicadorTipoPerfilPessoa = 3	--Agente Comercial
			and cdIndicadorStatusPessoa = @cdIndicadorStatusPessoa
			order by
				nmPessoa
		end

	end

	set nocount off

