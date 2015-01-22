set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

/******************************************************************************
**		File: SP_G_CompromissoCompraValorTotal_TMP
**		Name: SP_G_CompromissoCompraValorTotal_TMP
**		Desc: Retorna o valor total do Compromisso
**
**		Auth: Roberto Chaparro
**		Date: Mar 11 2009 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_G_CompromissoCompraValorTotal_TMP]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_G_CompromissoCompraValorTotal_TMP]
END
GO

CREATE PROCEDURE [dbo].[SP_G_CompromissoCompraValorTotal_TMP]
	 @tmpCompromissoCompraSEQ		bigint
	 
AS

	BEGIN
	

		select	sum(vrTotalMoedaCompromissoCompraItem),
				sum(vrTotalMoedaAbertoCompromissoCompraItem)
		from	tmpCompromissoCompraItem
		where	tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
	
					
	END
		
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO