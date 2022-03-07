using System.Windows.Forms;
using System.Drawing;
using System;

class first{
    static Label l = new Label();
    public static void Main(){
        int[] a = new int[10] {1,1,1,1,1,1,1,1,1,1};
        foreach (int i in a) { Console.WriteLine(i); }
        int[,] b = new int[10, 5];
        Form fm=new Form();
        fm.Text="test";
        
        l.Text="Texxxxxxxxxxxxxxxxxxxxxxxt";
        l.Parent=fm;
        PictureBox p=new PictureBox();
        p.Image = Image.FromFile("C:\\Users\\TOSHIBA\\GitHub\\programming\\Csharp\\test\\test1.jpg");
        p.Top=(fm.Height-p.Height)/2;
        p.Left=(fm.Width-p.Width)/2;
        p.Parent=fm;
        fm.Click += new EventHandler(fm_cl);
        Application.Run(fm);
    }
    public static void fm_cl(Object obj, EventArgs e) {
        l.Text = "a";
    }
}
class cl
{
    protected int c;
    int pr { set { c = value; }get { return c; } }
    virtual public void f (){ }
}
class cl2 : cl
{
    private int p;
    override public void f() { int a; }
}
abstract public class cl3
{
    virtual public void f() { int a; }
    abstract public void f2();
}
interface inf{
    int b();
}
class s : Form
{
    public static void Maindo()
    {
        Application.Run(new s());
    }
    public s()
    {
        this.Text = "a";
    }
}