namespace TestProject.ControlObjects.Controls
{
    class TextBoxObj : ContolObjects
    {
        public TextBoxObj() { }
        public TextBoxObj(string id, string name)
        {
            ID = id;
            Name = name;
        }

        public override string ID { set; get; }
        public override string Name { set; get; }
    }
}