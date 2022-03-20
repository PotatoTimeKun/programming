using System;
using System.Windows.Forms;
class test : Form
{
    private Label l;
    private Button[] bt=new Button[6];
    private FlowLayoutPanel flp;
    public static void Main()
    {
        Application.Run(new test());
    }
    public test()
    {
        l = new Label();
        Text = "aaaaaaaaaaa";
        Width = 1000;
        Height = 300;
        l.Text = "hello";
        l.Width = Width;
        l.Parent = this;
        l.MouseEnter += new EventHandler(mouen);
        l.MouseLeave += new EventHandler(moule);
        l.MouseMove += new MouseEventHandler(moumo);
        flp = new FlowLayoutPanel();
        flp.Dock = DockStyle.Bottom ;
        for(int i = 0; i < bt.Length; i++)
        {
            bt[i] = new Button();
            bt[i].Text = Convert.ToString(i);
            bt[i].Parent=flp;
        }
        flp.Parent = this;
    }
    public void mouen(Object s,EventArgs a)
    {
        l.Text = "うひょおおおおおお";
    }
    public void moule(Object s,EventArgs a)
    {
        l.Text = "...";
    }
    public void moumo(Object s,EventArgs a)
    {
        l.Text += "お";
    }
}