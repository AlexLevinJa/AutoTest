namespace TestProject.ControlHandler.Controls
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    abstract class ControlsHandler
    {
        public abstract void Click();
        public abstract string Text { set;  get; }
    }
}
