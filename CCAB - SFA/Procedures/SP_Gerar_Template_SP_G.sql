IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_Gerar_Template_SP_G]'))
BEGIN
	DROP PROCEDURE [dbo].[SP_Gerar_Template_SP_G]
END
GO

CREATE PROCEDURE [dbo].[SP_Gerar_Template_SP_G]
	@NomeTabela		varchar(255)
AS

print 'set ANSI_NULLS ON'
print 'set QUOTED_IDENTIFIER ON'

print ''

print '/******************************************************************************'
print '**		File: SP_G_' + @NomeTabela + '.sql'
print '**		Name: SP_G_' + @NomeTabela
print '**		Desc: Obtem registros da tabela ' + @NomeTabela
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

print 'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''[dbo].[SP_G_' + @NomeTabela + ']''))'
print 'BEGIN'
print '	DROP PROCEDURE [dbo].[SP_G_' + @NomeTabela + ']'
print 'END'
print 'GO'

print ''

print 'CREATE PROCEDURE [dbo].[SP_G_' + @NomeTabela + ']'

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
	,@Linha = ''

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
		upper(sysobjects.name) = upper(@NomeTabela)
	and sysobjects.id = syscolumns.id
	and (sysobjects.xtype='U' or sysobjects.xtype='S')
	and syscolumns.xtype = systypes.xtype
	and syscolumns.colid = 1
		

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
    
	if @Contador = 0 
	begin
		select
			@Linha = '	 @' + @Nome
	end

	
	select
		 @Tipo = upper(@Tipo)
		,@Linha = @Linha + '	' + upper(@Tipo)


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

--print @Linha
--print ''
--print @LinhaAux + '	OUTPUT'

print 'AS'
print ''

print '	--seleção'

print '	SELECT ' 

declare
	 @Campos		varchar(max)
	,@LinhaCampos	varchar(max)
	,@LinhaWhere	varchar(max)



select
	 @LinhaCampos	= ''
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
		upper(sysobjects.name) = upper(@NomeTabela)
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
    
	if @Contador = 0
	begin
		select
			 @Campos		= '		 ' + @Nome
			,@LinhaWhere	= '	WHERE ' + char(13) + '		' + @Nome + ' = @' + @Nome
	end
	else
	begin
		select
			@Campos = '		,' + @Nome
	end


	select
		@LinhaCampos = @LinhaCampos + @Campos + char(13)

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


print @LinhaCampos 

print '	FROM'

print '		' + @NomeTabela + ' (nolock)'

--print @LinhaWhere