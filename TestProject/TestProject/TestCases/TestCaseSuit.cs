namespace TestProject
{
    using System;
    using Microsoft.VisualStudio.TestTools.UnitTesting;

    using mPage = TestProject.Pages.Main;

    [TestClass]
    public class TMainForm
    {
        [TestMethod]
        public void Test1()
        {
            using (var mp = mPage.MainPage.Content)
            {
                mp.GetControl(mp.ObjectName.btnOpen).Click();
                mp.GetControl(mp.ObjectName.btnSave).Click();
                mp.GetControl(mp.ObjectName.txtFirstName).Text = "Text 1";
                mp.GetControl(mp.ObjectName.txtSecondName).Text = "Text 2";
                mp.GetControl(mp.ObjectName.btnClose).Click();
            }
        }
    }
}