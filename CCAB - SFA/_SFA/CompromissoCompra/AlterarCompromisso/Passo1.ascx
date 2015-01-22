<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Passo1.ascx.cs" Inherits="_SFA_CompromissoCompra_AlterarCompromisso_Passo1" %>

<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Agente:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdAgente" runat="server" Enabled="false"   
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" DataSourceID="ObjectDataSource1" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Origem Faturamento:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdPessoaOrigemFaturamento" runat="server" Enabled="false"    
                    CssClass="campoTexto" DataValueField="cdPessoaOrigemFaturamento" 
                    DataTextField="dsPessoaOrigemFaturamento" DataSourceID="ObjectDataSource5" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Safra:
            </td>
            <td class="tbTd_CinzaClara">

                
                            
                <asp:DropDownList ID="cdCronogramaSafraSEQ" runat="server" Enabled="false"    
                    CssClass="campoTexto" DataValueField="cdCronogramaSafraSEQ" 
                    DataTextField="dsCronogramaSafra" DataSourceID="ObjectDataSource2" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Moeda:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdMoeda" runat="server" Enabled="false"   
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource3" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Nº Compromisso:
            </td>
            <td class="tbTd_CinzaClara">
                <conv:TextBox ID="cdCompromisso" runat="server" Enabled="false" Columns="8"   
                    CssClass="campoTexto" Type="Numeric" DecimalPlaces="0" />
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Situação:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdStatus" runat="server" Enabled="false"  
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" DataSourceID="ObjectDataSource4" />
            </td>
        </tr>
    </table>
</div>

<div style="display: none;">
    <asp:Label ID="lbNomeTela" runat="server" SkinID="normal" />
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="ObterListaPedidoAgente" TypeName="Pessoa">
        <SelectParameters>
            <asp:SessionParameter SessionField="cdUsuario" Name="cdUsuario" Type="Int64" />
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="0" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterLista" TypeName="CronogramaSafra">
        <SelectParameters>
            <asp:Parameter Name="dsCronogramaSafra" DefaultValue=" " Type="String" />
            <asp:Parameter Name="cdIndicadorStatusCronogramaSafra" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="Ano" DefaultValue="" Type="String" />
            <asp:Parameter Name="cdPessoaSEQ" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="cdIndicadorSituacaoCooperativa" DefaultValue="0" Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource> 
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORMOEDA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORSTATUSCOMPROMISSOCOMPRA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="1" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
</div>

<br />
