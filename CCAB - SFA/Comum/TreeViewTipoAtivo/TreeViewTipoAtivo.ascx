<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TreeViewTipoAtivo.ascx.cs" Inherits="_Comum_TreeViewTipoAtivo" %>

<asp:HiddenField ID="cdTipoAtivoSEQ" runat="server" Value='<%# Bind("cdTipoAtivoSEQ") %>' />
<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Always">
    <ContentTemplate>
        <fieldset style="margin-bottom: 2px">
            <div id="DivContainer" runat="server" style="padding: 5px;">
                <p style="background-color: #808080; color: #ffffff; margin: 0; padding: 0; font-weight: bold">
                    Tipo de Ativo: *</p>
                <asp:Panel ID="Panel1" runat="server" ScrollBars="Vertical">
                    <table width="98%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                            <td colspan="5">
                                <asp:TreeView ID="TreeView1" NodeIndent="10" NodeStyle-VerticalPadding="2" CssClass="treeview"
                                    NodeStyle-HorizontalPadding="2" runat="server" EnableClientScript="true" OnTreeNodeDataBound="TreeView_TreeNodeDataBound"
                                    OnPreRender="TreeView_CollapseExpand" ImageSet="Arrows" CollapseImageToolTip="Fechar {0}"  
                                    ExpandImageToolTip="Abrir {0}">
                                    <SelectedNodeStyle CssClass="treeviewselected" />
                                    <RootNodeStyle CssClass="rootnode" />
                                    <DataBindings>
                                        <asp:TreeNodeBinding DataMember="System.Data.DataRowView" PopulateOnDemand="false"
                                            SelectAction="Select" ValueField="cdTipoAtivoSEQ" TextField="dsTipoAtivo" />
                                    </DataBindings>
                                </asp:TreeView>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </div>
        </fieldset>
        <fieldset>
            <div>
                <p style="background-color: #808080; color: #ffffff; margin: 2px 0; padding: 0; font-weight: bold">
                    Tipo de Ativo Selecionado</p>
                <asp:TextBox CssClass="campoTexto" ID="dsTipoAtivo" ReadOnly="true" BackColor="Gainsboro"
                    runat="server" Text='<%# Bind("dsTipoAtivo") %>' />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Tipo de Ativo não foi selecionado"
                    Text="*" ForeColor="#f6f6f6" EnableClientScript="true" ValidationGroup="Form"
                    ControlToValidate="dsTipoAtivo" />
                <asp:Button runat="server" ID="btLimparTipoAtivo" Visible="false" Text="Limpar" style="height: 20px; width: 60px; vertical-align: middle"  
                    CausesValidation="false" CssClass="button" />
            </div>
        </fieldset>
    </ContentTemplate>
</asp:UpdatePanel>

