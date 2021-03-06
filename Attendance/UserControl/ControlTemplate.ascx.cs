﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Attendance.UserControl
{
    public partial class ControlTemplate : System.Web.UI.UserControl
    {
        public event EventHandler DateBind;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public int pageIndex
        { get { return Convert.ToInt32(ViewState["CurrentPage"]); } set { ViewState["CurrentPage"] = value; } }
        public int pageRows
        { get { return Convert.ToInt32(ViewState["pageRows"]); } set { ViewState["pageRows"] = value; } }
        public int pageSize
        { get { return Convert.ToInt32(ViewState["PageSize"]); } set { ViewState["PageSize"] = value; } }
        public int pageCount
        {
            get
            {
                if (pageRows % pageSize == 0)
                    return pageRows / pageSize;
                else
                    return pageRows / pageSize + 1;
            }
        }

        public void SetPager(int row, int size)
        {
            pageIndex = 1;
            pageRows = row;
            pageSize = size;
            SetStuts();
        }
        public void SetStuts()
        {
            btnPrev.Enabled = pageIndex != 1;
            btnNext.Enabled = pageIndex != pageCount;

            ddlIndex.Items.Clear();
            //绑定数据到下拉表
            for (int i = 1; i <= pageCount; i++)
            {
                ListItem li = new ListItem("第" + i + "页", i.ToString());
                ddlIndex.Items.Add(li);
            }
            ddlIndex.SelectedValue = pageIndex.ToString();


            if (pageCount == 0)
                btnsearch.Style.Add("display", "none");
            else
                btnsearch.Style.Add("display", "block");
        }

        protected void btnFirst_Click(object sender, EventArgs e)
        {
            pageIndex = 1;
            if (DateBind != null)
                DateBind(null, null);
            SetStuts();
        }

        protected void btnPrev_Click(object sender, EventArgs e)
        {
            pageIndex--;
            if (DateBind != null)
                DateBind(null, null);
            SetStuts();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            pageIndex++;
            if (DateBind != null)
                DateBind(null, null);
            SetStuts();

        }

        protected void btnLast_Click(object sender, EventArgs e)
        {
            pageIndex = pageCount;
            if (DateBind != null)
                DateBind(null, null);
            SetStuts();
        }

        protected void ddlIndex_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList ddls = sender as DropDownList;
            pageIndex = int.Parse(ddls.SelectedValue);
            if (DateBind != null)
                DateBind(null, null);
            SetStuts();
        }
    }
}