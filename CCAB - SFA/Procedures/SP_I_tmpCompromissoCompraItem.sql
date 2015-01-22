set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
 
/******************************************************************************
**		File: SP_I_tmpCompromissoCompraItem.sql
**		Name: SP_I_tmpCompromissoCompraItem
**		Desc: Insere um registro na tabela tmpCompromissoCompraItem
**
**		Auth: Convergence
**		Date: 03/04/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:					Description:
**
*******************************************************************************/
 
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_I_tmpCompromissoCompraItem]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_I_tmpCompromissoCompraItem]
END
GO
 
CREATE PROCEDURE [dbo].[SP_I_tmpCompromissoCompraItem]
	@tmpCompromissoCompraSEQ	BIGINT = NULL
	,@cdProdutoSEQ	BIGINT = NULL
	,@cdCronogramaSafraSEQ	BIGINT = NULL
	,@cdCronogramaSafraVencimentoSEQ	BIGINT = NULL
	,@qtCompromissoCompraItem	NUMERIC(22,4) = NULL
	,@qtAbertoCompromissoCompraItem	NUMERIC(22,4) = NULL
	,@cdUsuarioUltimaAlteracao	BIGINT = NULL
	
	,@cdAgenteComercialCooperativaCompromissoCompra BIGINT
 
	,@tmpCompromissoCompraItemSEQ	BIGINT	OUTPUT
	
AS

	-- Variaveis para busca do Preço
	declare @cdIndicadorMoedaCompromissoCompra int
	declare @vrUnitarioMoedaCompromissoCompraItem	NUMERIC(22,4) 
	declare @vrTotalMoedaCompromissoCompraItem	NUMERIC(22,4) 
	
	-- Busca a Moeda no Compromisso de Compra
	set @cdIndicadorMoedaCompromissoCompra = 0
	select @cdIndicadorMoedaCompromissoCompra = cdIndicadorMoedaCompromissoCompra
	from tmpCompromissoCompra
	where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
	
	IF @cdIndicadorMoedaCompromissoCompra = 0
	BEGIN
		RAISERROR ('5004 - Erro na Busca da Moeda',16,1)
		RETURN	
	END	
	
	-- Busca Valor Unitário do produto
	IF @cdIndicadorMoedaCompromissoCompra = 1 -- Real
	begin
		SET @vrUnitarioMoedaCompromissoCompraItem = 0
		select	@vrUnitarioMoedaCompromissoCompraItem = vrRealPessoaTabelaPrecoProduto
		from	PessoaTabelaPrecoProduto
		where	cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
		and     cdProdutoSEQ = @cdProdutoSEQ
		and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

		IF @vrUnitarioMoedaCompromissoCompraItem = 0
		BEGIN
			RAISERROR ('5003 - Erro na Busca do Valor Unitario Real',16,1)
			RETURN	
		END
	end
	else -- Dolar
	begin
		SET @vrUnitarioMoedaCompromissoCompraItem = 0
		select	@vrUnitarioMoedaCompromissoCompraItem = vrDolarPessoaTabelaPrecoProduto
		from	PessoaTabelaPrecoProduto
		where	cdPessoaSEQ = @cdAgenteComercialCooperativaCompromissoCompra
		and     cdProdutoSEQ = @cdProdutoSEQ
		and     cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and     cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ

		IF @vrUnitarioMoedaCompromissoCompraItem = 0
		BEGIN
			RAISERROR ('5003 - Erro na Busca do Valor Unitario Dólar',16,1)
			RETURN	
		END
	end
	
	SET @vrTotalMoedaCompromissoCompraItem = @qtCompromissoCompraItem * @vrUnitarioMoedaCompromissoCompraItem
	
	-- Verifica se o Registro já existe na base (problema do refresh)
	if not exists ( select	1
					from tmpCompromissoCompraItem
					where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
					and   cdProdutoSEQ = @cdProdutoSEQ
					and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
					and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ)
	begin
 
		--inserção
		INSERT INTO tmpCompromissoCompraItem
		(
		 cdCompromissoCompraItemSEQ
		,tmpCompromissoCompraSEQ
		,cdCompromissoCompraSEQ
		,cdProdutoSEQ
		,cdCronogramaSafraSEQ
		,cdCronogramaSafraVencimentoSEQ
		,qtCompromissoCompraItem
		,qtAbertoCompromissoCompraItem
		,vrUnitarioMoedaCompromissoCompraItem
		,vrTotalMoedaCompromissoCompraItem
		,vrTotalMoedaAbertoCompromissoCompraItem
		,dtUltimaAlteracao
		,cdUsuarioUltimaAlteracao
		)
		VALUES
		(
		0 -- cdCompromissoCompraItemSEQ
		,@tmpCompromissoCompraSEQ
		,0 -- cdCompromissoCompraSEQ
		,@cdProdutoSEQ
		,@cdCronogramaSafraSEQ
		,@cdCronogramaSafraVencimentoSEQ
		,@qtCompromissoCompraItem
		,@qtCompromissoCompraItem -- @qtAbertoCompromissoCompraItem
		,@vrUnitarioMoedaCompromissoCompraItem
		,@vrTotalMoedaCompromissoCompraItem
		,@vrTotalMoedaCompromissoCompraItem -- @vrTotalMoedaAbertoCompromissoCompraItem
		,getdate()
		,@cdUsuarioUltimaAlteracao
		)
 
		--retornos
		SELECT
			@tmpCompromissoCompraItemSEQ = SCOPE_IDENTITY()
		SELECT
			@tmpCompromissoCompraItemSEQ as tmpCompromissoCompraItemSEQ

	end 
	
	else
	
	begin
	
		-- Seleciona a Chave para o Update
		select	@tmpCompromissoCompraItemSEQ = tmpCompromissoCompraItemSEQ
		from tmpCompromissoCompraItem
		where tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
		and   cdProdutoSEQ = @cdProdutoSEQ
		and   cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
		and   cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ	
	
		--atualização
		UPDATE tmpCompromissoCompraItem SET
			tmpCompromissoCompraSEQ = @tmpCompromissoCompraSEQ
			,cdProdutoSEQ = @cdProdutoSEQ
			,cdCronogramaSafraSEQ = @cdCronogramaSafraSEQ
			,cdCronogramaSafraVencimentoSEQ = @cdCronogramaSafraVencimentoSEQ
			,qtCompromissoCompraItem = @qtCompromissoCompraItem
			,qtAbertoCompromissoCompraItem = @qtCompromissoCompraItem
			,vrTotalMoedaCompromissoCompraItem = @qtCompromissoCompraItem * vrUnitarioMoedaCompromissoCompraItem
			,vrTotalMoedaAbertoCompromissoCompraItem = @qtCompromissoCompraItem * vrUnitarioMoedaCompromissoCompraItem
			,dtUltimaAlteracao = getdate()
			,cdUsuarioUltimaAlteracao = @cdUsuarioUltimaAlteracao

		WHERE 
			 tmpCompromissoCompraItemSEQ = @tmpCompromissoCompraItemSEQ
	
	end 

