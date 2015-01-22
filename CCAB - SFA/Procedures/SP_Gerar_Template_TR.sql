IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Gerar_Template_TR]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_Gerar_Template_TR]
END
GO

CREATE PROCEDURE [dbo].[SP_Gerar_Template_TR]
	@NomeTabela		varchar(255)
AS

print 'set ANSI_NULLS ON'
print 'set QUOTED_IDENTIFIER ON'

print ''

print '/******************************************************************************'
print '**		File: TR_' + @NomeTabela + '.sql'
print '**		Name: TR_' + @NomeTabela
print '**		Desc: Trigger de históricos da tabela ' + @NomeTabela
print '**'
print '**		Auth: Convergence'
print '**		Date: ' + convert(varchar, getdate(), 103)
print '*******************************************************************************'
print '**		Change History'
print '*******************************************************************************'
print '**		Date:			Author:					Description:'
print '**'
print '*******************************************************************************/'

print ''

print 'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[TR_' + @NomeTabela + ']''))'
print 'BEGIN'
print '	DROP TRIGGER [dbo].[TR_' + @NomeTabela + ']'
print 'END'
print 'GO'

print ''

print 'CREATE TRIGGER [dbo].[TR_' + @NomeTabela + '] ON dbo.' + @NomeTabela
print 'AFTER INSERT, UPDATE'

declare
	 @Nome			varchar(255)
	,@Tipo			varchar(255)
	,@Tamanho		int
	,@Escala		int
	,@Obrigatorio	int
	,@Contador		int
	,@Linha			varchar(max)
	,@LinhaAux		varchar(max)

select
	@Contador = 0


print 'AS'
print ''

print 'declare'
print '	@cdTipoEventoHistorico		int'
print ''

print '	IF EXISTS (SELECT * FROM deleted)	-- Alteração'
print '	BEGIN'
print '		select'
print '			@cdTipoEventoHistorico	= 2'
print '	END'
print '	ELSE'
print '	BEGIN'
print '		select'
print '			@cdTipoEventoHistorico	= 1'
print '	END'
print ''



print '	--inserção'

print '	INSERT INTO ' + @NomeTabela + 'Historico' + char(13) + '	('

declare
	 @Campos		varchar(max)
	,@Valores		varchar(max)
	,@LinhaCampos	varchar(max)
	,@LinhaValores	varchar(max)


select
	 @LinhaCampos	= ''
	,@LinhaValores	= ''
	,@Contador		= 0

--cursor dos campos
DECLARE Cursor_Campos CURSOR FOR 
	select 
		 syscolumns.name		as Nome
		,systypes.name			as Tipo
		,syscolumns.prec		as Tamanho
		,syscolumns.scale		as Escala
		,syscolumns.isnullable	as Obrigatorio

	from 
		 syscolumns
		,sysobjects
		,systypes
	where 
		upper(sysobjects.name) = upper(@NomeTabela + 'historico')
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	order by
		syscolumns.colid

OPEN Cursor_Campos

FETCH NEXT FROM Cursor_Campos 
INTO 
	 @Nome
	,@Tipo
	,@Tamanho
	,@Escala
	,@Obrigatorio

WHILE @@FETCH_STATUS = 0
BEGIN
    
	if @Contador <> 1
	begin
		select
			 @Campos = '		,' + @Nome
			,@Valores = '		,' + @Nome
	end
	else
	begin
		select
			 @Campos = '		 ' + @Nome
			,@Valores = '		 ' + @Nome
	end
	
	select
		 @Valores = replace(@Valores, 'cdTipoEventoHistorico', '@cdTipoEventoHistorico')
		,@Valores = replace(@Valores, 'cdUsuarioOcorrenciaHistorico', 'cdUsuarioUltimaAlteracao')



	if @Contador > 0
	begin
		select
			@LinhaCampos = @LinhaCampos + @Campos + char(13)

		if @Nome <> 'dtOcorrenciaHistorico'
		begin
			select
				@LinhaValores = @LinhaValores + @Valores + char(13)
		end
		else
		begin
			select
				@LinhaValores = @LinhaValores + '		,getdate()' + char(13)
		end
	end

	select
		@Contador = @Contador + 1

    FETCH NEXT FROM Cursor_Campos 
    INTO 
		 @Nome
		,@Tipo
		,@Tamanho
		,@Escala
		,@Obrigatorio
END 
CLOSE Cursor_Campos
DEALLOCATE Cursor_Campos


print @LinhaCampos + '	)'
print '	SELECT' + char(13) + @LinhaValores + char(13) + '	FROM' + char(13) + '		inserted'


