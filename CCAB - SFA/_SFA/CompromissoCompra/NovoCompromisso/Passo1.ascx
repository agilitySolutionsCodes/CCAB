<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Passo1.ascx.cs" Inherits="_SFA_CompromissoCompra_NovoCompromisso_Passo1" %>

<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Agente:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdAgente" runat="server" AutoPostBack="true"    
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" DataSourceID="ObjectDataSource1" 
                    OnPreRender="cdAgente_PreRender" 
                    OnSelectedIndexChanged="cdAgente_SelectedIndexChanged"/>
            </td>
        </tr>
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Safra:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdCronogramaSafraSEQ" runat="server" AutoPostBack="true"    
                    CssClass="campoTexto" DataValueField="cdCronogramaSafraSEQ" 
                    DataTextField="dsCronogramaSafra" DataSourceID="ObjectDataSource2" 
                    OnSelectedIndexChanged="cdSafra_SelectedIndexChanged" 
                    onprerender="cdCronogramaSafraSEQ_PreRender" />
            </td>
        </tr>
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Origem Faturamento:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdPessoaOrigemFaturamento" runat="server" AutoPostBack="true"    
                    CssClass="campoTexto"  
                    OnSelectedIndexChanged="cdOrigemFaturamento_SelectedIndexChanged" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Moeda:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdMoeda" runat="server" AutoPostBack="true"   
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource3" 
                    OnSelectedIndexChanged="cdMoeda_SelectedIndexChanged" />
            </td>
        </tr>
    </table>
</div>

<div style="display: none;">
    <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaPedidoAgente" TypeName="Pessoa">
        <SelectParameters>
            <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuario" Type="Int64" />
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="1" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CronogramaSafra">
        <SelectParameters>
            <asp:Parameter Name="dsCronogramaSafra" DefaultValue=" " Type="String" />
            <asp:Parameter Name="cdIndicadorStatusCronogramaSafra" DefaultValue="1" Type="Int64" />
            <asp:Parameter Name="Ano" DefaultValue="" Type="String" />
            <asp:Parameter Name="cdPessoaSEQ" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="cdIndicadorSituacaoCooperativa" DefaultValue="1" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource> 
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORMOEDA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="1" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>

<br />
