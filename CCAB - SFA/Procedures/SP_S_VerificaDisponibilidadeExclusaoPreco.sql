

set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_S_VerificaDisponibilidadeExclusaoPreco.sql
**		Name: SP_S_VerificaDisponibilidadeExclusaoPreco
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
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_S_VerificaDisponibilidadeExclusaoPreco]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeExclusaoPreco]
END
GO
 
CREATE PROCEDURE [dbo].[SP_S_VerificaDisponibilidadeExclusaoPreco]
	  @cdPessoaSEQ	BIGINT
	 ,@cdCronogramaSafraSEQ bigint
  
AS

	select	cdCompromissoCompraSEQ
	from	CompromissoCompra
	Where	cdAgenteComercialCooperativaCompromissoCompra = @cdPessoaSEQ
	and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ


	
	