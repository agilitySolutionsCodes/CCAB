﻿<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Passo1.ascx.cs" Inherits="_SFA_PedidoVenda_NovoPedido_Passo1" %>
<%@ Register TagPrefix="uc" TagName="Formulario" Src="~/_SFA/Cadastros/Cliente/Formulario.ascx" %>

<div>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tbGenerica_01">
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Agente:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdAgente" runat="server" AutoPostBack="true"    
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" 
                    OnSelectedIndexChanged="cdAgente_SelectedIndexChanged" 
                    onprerender="cdAgente_PreRender1"/>
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Safra:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdCronogramaSafraSEQ" runat="server" AutoPostBack="true"   
                    CssClass="campoTexto" DataValueField="cdCronogramaSafraSEQ" 
                    DataTextField="dsCronogramaSafra" 
                    OnSelectedIndexChanged="cdSafra_SelectedIndexChanged" />
            </td>
        </tr>
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Tipo Produto:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="dropDownListRegraProduto" Width="155" runat="server" 
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado" 
                    DataTextField="wkDominioCodigoReferenciado" AutoPostBack="True" 
                    onselectedindexchanged="dropDownListRegraProduto_SelectedIndexChanged"/>
            </td>
        </tr>
        
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Origem Faturamento:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdPessoaOrigemFaturamento" runat="server" AutoPostBack="true"    
                    CssClass="campoTexto" DataValueField="cdIndicadorSituacaoOrigemFaturamento" 
                    DataTextField="dsFaturamento" Width="470"
                    OnSelectedIndexChanged="cdOrigemFaturamento_SelectedIndexChanged" />
            </td>
        </tr>
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Tipo Pedido:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="dropDownListTipoPedido" runat="server" AutoPostBack="true"   
                    CssClass="campoTexto" DataValueField="vrDominioCodigoReferenciado"  
                    DataTextField="wkDominioCodigoReferenciado" OnSelectedIndexChanged="dropDownListTipoPedido_SelectedIndexChanged" />
            </td>
        </tr>
        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Cliente:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdClienteFaturamento" runat="server" AutoPostBack="true"   
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" DataSourceID="ObjectDataSource2" 
                    OnSelectedIndexChanged="cdClienteFaturamento_SelectedIndexChanged" 
                    Enabled="false" />
                &nbsp;&nbsp;
                <asp:LinkButton runat="server" ID="LinkClienteFaturamento"  
                    Text="Ver detalhe" OnClick="ClienteFaturamento_Link" 
                    Font-Size="Smaller" Enabled="false" /> 
            </td>
        </tr>
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Local de Entrega:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdClienteEntrega" runat="server" AutoPostBack="true"  
                    CssClass="campoTexto" DataValueField="cdPessoaSEQ" Width="470"  
                    DataTextField="nmPessoa" 
                    OnSelectedIndexChanged="cdClienteEntrega_SelectedIndexChanged"  
                    Enabled="false" />
                &nbsp;&nbsp;
                <asp:LinkButton runat="server" ID="LinkClienteEntrega"  
                    Text="Ver detalhe" OnClick="ClienteEntrega_Link" 
                    Font-Size="Smaller" Enabled="false" /> 
            </td>
        </tr>        
        <tr>
            <td class="tbTd_cinzaEscura" nowrap>
                Moeda:
            </td>
            <td class="tbTd_CinzaClara">
                <asp:DropDownList ID="cdMoeda" runat="server" AutoPostBack="true" 
                    CssClass="campoTexto" DataValueField="cdIndicadorMoedaCompromissoCompra" 
                    DataTextField="dsIndicadorMoedaCompromissoCompra" 
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
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" SelectMethod="ObterListaPedidoClienteFaturamento" TypeName="Pessoa">
        <SelectParameters>
            <asp:ControlParameter ControlID="cdAgente" PropertyName="SelectedValue" Name="cdAgente" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" SelectMethod="ObterListaPedidoClienteEntrega" TypeName="Pessoa">
        <SelectParameters>
            <asp:ControlParameter ControlID="cdClienteFaturamento" PropertyName="SelectedValue" Name="cdCliente" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" SelectMethod="ObterLista" TypeName="CronogramaSafra">
        <SelectParameters>
            <asp:Parameter Name="dsCronogramaSafra" DefaultValue=" " Type="String" />
            <asp:Parameter Name="cdIndicadorStatusCronogramaSafra" DefaultValue="1" Type="Int64" />
            <asp:Parameter Name="Ano" DefaultValue="" Type="String" />
            <asp:Parameter Name="cdPessoaSEQ" DefaultValue="0" Type="Int64" />
            <asp:Parameter Name="cdIndicadorSituacaoCooperativa" DefaultValue="1" Type="Int32" />            
        </SelectParameters>
    </asp:ObjectDataSource> 
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" SelectMethod="ObterMoeda" TypeName="CompromissoCompra">
        <SelectParameters>
            <asp:ControlParameter ControlID="cdAgente" PropertyName="SelectedValue" Name="cdAgenteComercialCooperativaCompromissoCompra" Type="Int64" />
            <asp:ControlParameter ControlID="cdCronogramaSafraSEQ" PropertyName="SelectedValue" Name="cdCronogramaSafraSEQ" Type="Int64" />
            <asp:ControlParameter ControlID="cdPessoaOrigemFaturamento" PropertyName="SelectedValue" Name="cdPessoaOrigemFaturamento" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" SelectMethod="ObterListaOrigemFaturamento" TypeName="Pessoa">
        <SelectParameters>
            <asp:Parameter Name="cdIndicadorStatusPessoa" DefaultValue="1" Type="Int64" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="dataSourceTipoProduto" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="ObjectDataSourcePrincipioAtivo" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTOPRECO1" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="ObjectDataSourceProdutoAcabado" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPTIPOPRODUTOPRECO2" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="objectDataSourceTipoPedido" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOPEDIDO" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    <asp:ObjectDataSource ID="objectDataSourceTipoPedidoVenda" runat="server" SelectMethod="ObterLista" TypeName="CodigoReferenciado">
        <SelectParameters>
            <asp:Parameter Name="dsDominioCodigoReferenciado" DefaultValue="DMESPINDICADORTIPOPEDIDOVENDA" Type="String" />
        </SelectParameters>
    </asp:ObjectDataSource>
    
    
    
</div>

<br />

<!-- Formulário de Edição -->
<div>
    <asp:Panel ID="Panel1" runat="server" Width="890" Style="display: none; background: #FFFFFF; padding: 10px;">
        <uc:Formulario ID="Formulario1" runat="server" />    
    </asp:Panel>
</div> 