<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Resultado.ascx.cs" Inherits="_SFA_PrincipioAtivo_Resultado" %>

<asp:GridView ID="GridView1" DataKeyNames="cdCooperativaPrincipioAtivoSEQ" runat="server" OnSelectedIndexChanged="GridView_SelectedIndexChanged" AutoGenerateColumns="False">
<Columns>   
    <asp:TemplateField><ItemTemplate><asp:GridViewRowSelector ID="GridViewRowSelector1" runat="server" /></ItemTemplate></asp:TemplateField>        
    <asp:BoundField DataField="dsAgente" HeaderText="Agente" ItemStyle-HorizontalAlign="Left" />
    <asp:BoundField DataField="dsFornecedorPrincipioAtivo" HeaderText="Fornecedor" ItemStyle-HorizontalAlign="Left" Visible="false"/>
    <asp:BoundField DataField="dsTipoProduto" HeaderText="Tipo Produto" />
    <asp:BoundField DataField="dsIndicadorPrincipioAtivo" HeaderText="Pricipio Ativo" Visible="false"/>
    <asp:BoundField DataField="dsIndicadorProdutoAcabado" HeaderText="Produto Acabado" Visible="false" />
</Columns>    
</asp:GridView>
