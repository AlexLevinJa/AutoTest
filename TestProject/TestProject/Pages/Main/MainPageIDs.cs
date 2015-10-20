namespace TestProject.Pages.Main.IDs
{
    using TestProject.ControlObjects.Controls;

    class MainPageIDs
    {
        public  ButtonObj btnOpen { private set; get; }
        public  ButtonObj btnSave { private set; get; }
        public  ButtonObj btnClose { private set; get; }
        public  TextBoxObj txtFirstName { private set; get; }
        public  TextBoxObj txtSecondName { private set; get; }
    
        public MainPageIDs()
        {        
            btnOpen.ID = "btnOpenId";
            btnSave.ID = "btnSaveId";
            btnClose.ID = "btnCloseId";
            txtFirstName.ID = "txtFirstNameId";
            txtSecondName.ID = "txtSecondNameId";                       
        }
    }
}