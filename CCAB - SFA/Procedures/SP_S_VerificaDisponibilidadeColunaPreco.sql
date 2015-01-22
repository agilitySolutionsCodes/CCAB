set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDisponibilidadeColunaPreco.sql
**		Name: SP_S_VerificaDisponibilidadeColunaPreco
**		Desc: Verifica Disponibilidade para cadastro de ColunaPreco
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDisponibilidadeColunaPreco]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeColunaPreco]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeColunaPreco]
	  @cdPessoaSEQ	BIGINT
	 ,@cdCronogramaSafraSEQ bigint
  
AS

	declare @dsDisponibilidadeMoeda varchar(max)
	declare @dsDispReal int
	declare @dsDispDolar int
	
	set @dsDisponibilidadeMoeda = ''
	set @dsDispReal = 0
	set @dsDispDolar = 0
			
	-- Verifica se há Compromisso de Compra para a moeda Reais e já esteja liberado
	select  @dsDispReal = cdIndicadorMoedaCompromissoCompra
	from	CompromissoCompra
	Where	cdAgenteComercialCooperativaCompromissoCompra = @cdPessoaSEQ
	and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and     cdIndicadorMoedaCompromissoCompra = 1 -- Real
	and     cdIndicadorStatusCompromissoCompra in (5) -- Liberado
	
	-- Verifica se há Compromisso de Compra para a moeda Dólar
	select  @dsDispDolar = cdIndicadorMoedaCompromissoCompra
	from	CompromissoCompra
	Where	cdAgenteComercialCooperativaCompromissoCompra = @cdPessoaSEQ
	and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and     cdIndicadorMoedaCompromissoCompra = 2 -- Dolar
	and     cdIndicadorStatusCompromissoCompra in (5) -- Liberado

	-- Verifica a moeda Real
	if @dsDispReal = 0
	begin
		set @dsDisponibilidadeMoeda = '3'
	end

	if @dsDispDolar = 0
	begin
		if @dsDisponibilidadeMoeda = ''
		begin
			set @dsDisponibilidadeMoeda = '5'
		end
		else
		begin
			set @dsDisponibilidadeMoeda = @dsDisponibilidadeMoeda + ';5'
		end
	end	
	
	select @dsDisponibilidadeMoeda as dsDisponibilidadeMoeda
	
	