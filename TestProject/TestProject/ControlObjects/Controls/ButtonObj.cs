namespace TestProject.ControlObjects.Controls
{
    class ButtonObj : ContolObjects
    {
        public ButtonObj() { }
        public ButtonObj(string id, string name)
        {
            ID = id;
            Name = name;
        }
        
        public override string ID { set; get; }
        public override string Name { set; get; } 
    }
}