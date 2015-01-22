set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDisponibilidadeCompromisso.sql
**		Name: SP_S_VerificaDisponibilidadeCompromisso
**		Desc: Verifica Disponibilidade para cadastro de Compromisso
**
**		Auth: Convergence
**		Date: 10/03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDisponibilidadeCompromisso]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeCompromisso]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeCompromisso]
	  @cdAgenteComercialCooperativaCompromissoCompra	BIGINT
	 ,@cdCronogramaSafraSEQ bigint
	 ,@cdIndicadorMoedaCompromissoCompra bigint
	 ,@cdPessoaOrigemFaturamento bigint
  
AS
 
	--seleção
	SELECT 
		cdCompromissoCompraSEQ
	FROM
		CompromissoCompra (nolock)
	WHERE 
		cdAgenteComercialCooperativaCompromissoCompra = @cdAgenteComercialCooperativaCompromissoCompra
	and cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
	and cdIndicadorMoedaCompromissoCompra = @cdIndicadorMoedaCompromissoCompra
	and cdPessoaOrigemFaturamento = @cdPessoaOrigemFaturamento
