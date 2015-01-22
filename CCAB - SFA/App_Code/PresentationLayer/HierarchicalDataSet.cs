using System;
using System.Data;
using System.Web.UI;
using System.Collections;
using System.Web.UI.WebControls;

public class HierarchicalDataSet : IHierarchicalDataSource
{
    readonly DataView dataView;
    readonly string idColumnName;
    readonly string parentIdColumnName;
    readonly bool columnIsString;
    readonly object rootParentColumnValue;

    public HierarchicalDataSet(DataSet dataSet, string idColumnName, string parentIdColumnName)
    {
        dataView = dataSet.Tables[0].DefaultView;
        this.idColumnName = idColumnName;
        this.parentIdColumnName = parentIdColumnName;
        rootParentColumnValue = null;

        if (dataSet.Tables[0].Columns[idColumnName].DataType != dataSet.Tables[0].Columns[parentIdColumnName].DataType)
            throw new Exception("As duas colunas devem ter o mesmo tipo");

        columnIsString = dataSet.Tables[0].Columns[idColumnName].DataType == typeof(string);
    }

    public event EventHandler DataSourceChanged;

    public HierarchicalDataSourceView GetHierarchicalView(string viewPath)
    {
        return new DataSourceView(this, viewPath);
    }

    #region métodos de suporte
    
    DataRowView GetParentRow(DataRowView row)
    {
        dataView.RowFilter = GetFilter(idColumnName, row[parentIdColumnName].ToString());
        DataRowView parentRow = dataView[0];
        dataView.RowFilter = "";
        return parentRow;
    }
    
    private string GetFilter(string columnName, string value)
    {
        if (columnIsString)
            return String.Format("[{0}] = '{1}'", columnName, value.Replace("'", "''"));
        else
            return String.Format("[{0}] = {1}", columnName, value);
    }

    string GetChildrenViewPath(string viewPath, DataRowView row)
    {
        return viewPath + "\\" + row[idColumnName].ToString();
    }
    
    bool HasChildren(DataRowView row)
    {
        dataView.RowFilter = GetFilter(parentIdColumnName, row[idColumnName].ToString());
        bool hasChildren = dataView.Count > 0;
        dataView.RowFilter = "";
        return hasChildren;
    }
   
    string GetParentViewPath(string viewPath)
    {
        return viewPath.Substring(0, viewPath.LastIndexOf("\\"));
    }
    
    #endregion

    #region implementação de interfaces

    class DataSourceView : HierarchicalDataSourceView
    {
        readonly HierarchicalDataSet hDataSet;
        readonly string viewPath;

        public DataSourceView(HierarchicalDataSet hDataSet, string viewPath)
        {
            this.hDataSet = hDataSet;
            this.viewPath = viewPath;
        }

        public override IHierarchicalEnumerable Select()
        {
            return new HierarchicalEnumerable(hDataSet, viewPath);
        }
    }

    class HierarchicalEnumerable : IHierarchicalEnumerable
    {
        readonly HierarchicalDataSet hDataSet;
        readonly string viewPath;

        public HierarchicalEnumerable(HierarchicalDataSet hDataSet, string viewPath)
        {
            this.hDataSet = hDataSet;
            this.viewPath = viewPath;
        }

        public IHierarchyData GetHierarchyData(object enumeratedItem)
        {
            DataRowView row = (DataRowView)enumeratedItem;
            return new HierarchyData(hDataSet, viewPath, row);
        }

        public IEnumerator GetEnumerator()
        {
            if (viewPath == "")
            {
                if (hDataSet.rootParentColumnValue != null)
                    hDataSet.dataView.RowFilter = hDataSet.GetFilter(hDataSet.parentIdColumnName, hDataSet.rootParentColumnValue.ToString());
                else
                {
                    if (hDataSet.columnIsString)
                        hDataSet.dataView.RowFilter = String.Format("[{0}] is null or [{0}] = ''",
                                                                    hDataSet.parentIdColumnName);
                    else
                        hDataSet.dataView.RowFilter = String.Format("[{0}] is null or [{0}] = 0",
                                                                    hDataSet.parentIdColumnName);
                }
            }
            else
            {
                string lastID = viewPath.Substring(viewPath.LastIndexOf("\\") + 1);
                hDataSet.dataView.RowFilter = hDataSet.GetFilter(hDataSet.parentIdColumnName, lastID);
            }

            IEnumerator i = hDataSet.dataView.ToTable().DefaultView.GetEnumerator();
            hDataSet.dataView.RowFilter = "";

            return i;
        }
    }
    
    class HierarchyData : IHierarchyData
    {
        readonly HierarchicalDataSet hDataSet;
        readonly DataRowView row;
        readonly string viewPath;

        public HierarchyData(HierarchicalDataSet hDataSet, string viewPath, DataRowView row)
        {
            this.hDataSet = hDataSet;
            this.viewPath = viewPath;
            this.row = row;
        }

        public IHierarchicalEnumerable GetChildren()
        {
            return new HierarchicalEnumerable(hDataSet, hDataSet.GetChildrenViewPath(viewPath, row));
        }

        public IHierarchyData GetParent()
        {
            return new HierarchyData(hDataSet, hDataSet.GetParentViewPath(viewPath), hDataSet.GetParentRow(row));
        }

        public bool HasChildren
        {
            get
            {
                return hDataSet.HasChildren(row);
            }
        }

        public object Item
        {
            get
            {
                return row;
            }
        }

        public string Path
        {
            get
            {
                return viewPath;
            }
        }

        public string Type
        {
            get
            {
                return typeof(DataRowView).ToString();
            }
        }
    }

    #endregion
}

