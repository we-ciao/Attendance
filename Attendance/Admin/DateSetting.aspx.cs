﻿using BLL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entity;

namespace Attendance
{
    public partial class DateSetting : System.Web.UI.Page
    {
        AttendanceManagement Atten = new AttendanceManagement();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                for (int i = DateTime.Now.Year - 3; i <= DateTime.Now.Year + 3; i++)
                    DropDownListYear.Items.Add(i.ToString());
                DropDownListYear.SelectedValue = DateTime.Now.Year.ToString();
                DropDownListMonth.SelectedValue = DateTime.Now.Month.ToString();
                gdvinfo.DataBind();
            }
        }

        protected void BtnShow_Click(object sender, EventArgs e)
        {
            int year = int.Parse(DropDownListYear.SelectedValue);
            int month = int.Parse(DropDownListMonth.SelectedValue);
            List<AttendanceSetting> list = new List<AttendanceSetting>();
            Dictionary<DateTime, int> dic = Atten.DateInfo(year, month);

            for (int i = 1; i <= DateTime.DaysInMonth(year, month); i++)
            {
                DateTime time = Convert.ToDateTime(year + "-" + month + "-" + i);
                AttendanceSetting ats = new AttendanceSetting();
                ats.Date = time;
                ats.Status = dic.ContainsKey(time) ? dic[time] : 0;
                list.Add(ats);
            }
            gdvinfo.DataSource = list;
            gdvinfo.DataBind();
            BtnSave.Visible = true;
        }

        protected void gdvinfo_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                DateTime time = Convert.ToDateTime(e.Row.Cells[0].Text);
                e.Row.Cells[1].Text = time.ToString("dddd", new System.Globalization.CultureInfo("zh-cn"));
                DropDownList ddl = e.Row.Cells[2].FindControl("DropDownListState") as DropDownList;
                ddl.SelectedValue = (e.Row.DataItem as AttendanceSetting).Status.ToString();
            }
        }

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            Atten.DeleteDate(gdvinfo.Rows[0].Cells[0].Text);

            List<string  > list = new List<string >(); 
            foreach (GridViewRow dr in gdvinfo.Rows)
            {
                string date = gdvinfo.Rows[dr.RowIndex].Cells[0].Text;
                string status = (gdvinfo.Rows[dr.RowIndex].Cells[2].FindControl("DropDownListState") as DropDownList).SelectedValue;
                list.Add("INSERT INTO AttendanceSetting VALUES ( '" + date + "', '" + status + "')");
            }
            Atten.ChangeDateStatus(list);

            LabTip.Visible = true;
        }
    }
}