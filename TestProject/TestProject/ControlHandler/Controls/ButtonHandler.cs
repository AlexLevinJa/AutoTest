namespace TestProject.ControlHandler.Controls
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    using OpenQA.Selenium;
    using OpenQA.Selenium.Chrome;
    using OpenQA.Selenium.Support.UI;    

    class ButtonHandler : TestProject.ControlHandler.Controls.ControlsHandler
    {
        IWebElement item;

        public ButtonHandler(string id)
        {
            using (var driver = new ChromeDriver())
            {
                item = driver.FindElementById(id);
            }            
        }

        public override void Click()
        {
            item.Click();            
        }

        public override string Text 
        {
            set 
            {
                string s = value; // TODO implement;            
            }
            get
            {
                return item.Text;
            }     
        }       
    }
}
