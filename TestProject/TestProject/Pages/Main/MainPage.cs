namespace TestProject.Pages.Main
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    using con = TestProject.ControlHandler.Controls;
    using obj = TestProject.ControlObjects;
    using TestProject.Pages.Main.IDs;

    class MainPage : IDisposable
    {
        private MainPageIDs conObj;
        private Dictionary<obj.ContolObjects, con.ControlsHandler> pageControls;

        static readonly MainPage initMainPage = new MainPage();

        public MainPage()
        {
            conObj = new MainPageIDs();
            pageControls = new Dictionary<obj.ContolObjects, con.ControlsHandler>();

            pageControls.Add(conObj.btnClose, new con.ButtonHandler(conObj.btnClose.ID));
            pageControls.Add(conObj.btnOpen, new con.ButtonHandler(conObj.btnOpen.ID));
            pageControls.Add(conObj.btnSave, new con.ButtonHandler(conObj.btnSave.ID));
            pageControls.Add(conObj.txtFirstName, new con.ButtonHandler(conObj.txtFirstName.ID));
            pageControls.Add(conObj.txtSecondName, new con.ButtonHandler(conObj.txtSecondName.ID));
        }

        public con.ControlsHandler GetControl(obj.ContolObjects obj)
        {
            con.ControlsHandler res = null;
            if (pageControls.ContainsKey(obj)) return pageControls[obj];

            return res;
        }

        public MainPageIDs ObjectName
        {
            get { return conObj; }
        }

        public static MainPage Content
        {
            get { return initMainPage; }
        }

        public void Dispose() {}
    }
}