using System;
using System.Windows.Forms;
using System.Collections.Generic;
using System.IO;
class Brainpotato
{
    private string code = "";
    private int ptr = 0;
    private bool iftrue = false;
    private List<int> lis = new List<int>();
    public Brainpotato() { lis.Add(0); }
    public Brainpotato(string code_str)
    {
        this.code = code_str;
        lis.Add(0);
    }
    public void setCode(string code_str) { 
        this.code = code_str;
    }
    public string runCode(string input_str="")
    {
        ptr = 0;
        iftrue = false;
        lis = new List<int>();
        lis.Add(0);
        string ret = "";
        for(int i = 0; i < code.Length; i++)
        {
            char c = code[i];
            switch (c)
            {
                case 'p':
                    ptr++;
                    if (lis.Count-1 < ptr) { lis.Add(0); }
                    break;
                case 'o':
                    ptr--;
                    if(ptr < 0) { ptr = 0; }
                    break;
                case 't':
                    lis[ptr]++;
                    break;
                case 'm':
                    lis[ptr]--;
                    break;
                case 'k':
                    ret+=(char)lis[ptr];
                    break;
                case 'u':
                    if((int)lis[ptr] == 0) {
                        int l = 1;
                        for (int j = i + 1; j < code.Length; j++)
                        {
                            char c2 = code[j];
                            switch (c2)
                            {
                                case 'u':
                                    l++;
                                    break;
                                case 'n':
                                    l--;
                                    break;
                                default:
                                    break;
                            }
                            if (l == 0)
                            {
                                i = j;
                                break;
                            }
                        }
                    }
                    break;
                case 'n':
                    if ((int)lis[ptr] != 0)
                    {
                        int l = 1;
                        for (int j = i - 1; j < code.Length; j--)
                        {
                            char c2 = code[j];
                            switch (c2)
                            {
                                case 'u':
                                    l--;
                                    break;
                                case 'n':
                                    l++;
                                    break;
                                default:
                                    break;
                            }
                            if (l == 0)
                            {
                                i = j;
                                break;
                            }
                        }
                    }
                    break;
                case 'i':
                    if (lis[ptr] > 0)
                    {
                        iftrue = true;
                    }
                    else
                    {
                        iftrue=false;
                        int l= 1;
                        for(int j=i+1;j< code.Length; j++)
                        {
                            char c2 = code[j];
                            switch (c2)
                            {
                                case 'a':
                                    l--;
                                    break;
                                case 'e':
                                    l--;
                                    break;
                                default:
                                    break;
                            }
                            if (l == 0)
                            {
                                i = j;
                                break;
                            }
                        }
                    }
                    break;
                case 'a':
                    break;
                case 'e':
                    if (iftrue)
                    {
                        int l= 1;
                        for (int j = i + 1; j < code.Length; j++)
                        {
                            char c2 = code[j];
                            switch (c2)
                            {
                                case 'a':
                                    l--;
                                    break;
                                default:
                                    break;
                            }
                            if (l == 0)
                            {
                                i = j;
                                break;
                            }
                        }
                    }
                    break;
                case 'c':
                    lis[ptr] *= 2;
                    break;
                case 'h':
                    lis[ptr] /= 2;
                    break;
                case 's':
                    lis[ptr] = (int)input_str[0];
                    input_str=input_str.Substring(1);
                    break;
                default:
                    break;
            }
        }
        return ret;
    }
}
class MainClass : Form
{
    private TextBox tb;
    private TextBox inp;
    private TextBox lb;
    private Button bt;
    private Button fl;
    private Button fls;
    [STAThread]
    public static void Main()
    {
        Application.Run(new MainClass());
    }
    public MainClass()
    {
        this.Text = "BrainPotato";
        this.Width = 600;
        this.Height = 700;
        fl=new Button();
        fl.Text = "ファイルを開く";
        fl.Parent = this;
        fls = new Button();
        fls.Text = "保存する";
        fls.Left = fl.Right;
        fls.Parent = this;
        Label l1=new Label();
        l1.Text = "プログラム";
        l1.Top = fl.Bottom+10;l1.Left=10;l1.Width = Width;
        l1.Parent = this;
        tb = new TextBox();
        tb.Multiline= true;
        tb.Top = l1.Bottom;tb.Left=l1.Left;tb.Width=Width-30;
        tb.Height = 250;
        tb.Parent = this;
        Label l2=new Label();
        l2.Text = "出力";
        l2.Top=tb.Bottom+10;l2.Left=tb.Left;l2.Width=Width;
        l2.Parent = this;
        inp = new TextBox();
        bt = new Button();
        bt.Text = "実行";
        lb = new TextBox();
        lb.Multiline= true;
        lb.Left = 10;
        lb.Top = l2.Bottom;
        lb.Width=Width-30;
        lb.Height = Bottom-l2.Bottom-bt.Height*3-10;
        lb.Parent= this;
        bt.Top = lb.Bottom+10;
        Label l3 = new Label();
        l3.Text = "入力";
        l3.Width = 40;
        l3.Left = 10;
        l3.Top = lb.Bottom+10;
        l3.Parent = this;
        inp.Top=lb.Bottom+10;
        inp.Left = l3.Right;
        bt.Left =500;
        inp.Width = Width - l3.Width - 100-20;
        inp.Parent = this;
        bt.Parent = this;
        bt.Click += new EventHandler(tk);
        fl.Click += new EventHandler(clfl);
        fls.Click += new EventHandler(clfls);
    }
    public void tk(Object s,EventArgs e)
    {
        Brainpotato bp = new Brainpotato();
        bp.setCode(tb.Text);
        lb.Text = bp.runCode(inp.Text);
    }
    public void clfl(Object s,EventArgs e)
    {
        OpenFileDialog ofd = new OpenFileDialog();
        ofd.Filter = "ブレインポテト|*.brpt";
        if(ofd.ShowDialog() == DialogResult.OK)
        {
            StreamReader sr = new StreamReader(ofd.FileName);
            tb.Text = sr.ReadToEnd();
            sr.Close();
        }
    }
    public void clfls(Object s, EventArgs e)
    {
        SaveFileDialog ofd = new SaveFileDialog();
        ofd.Filter = "ブレインポテト|*.brpt";
        if (ofd.ShowDialog() == DialogResult.OK)
        {
            StreamWriter sr = new StreamWriter(ofd.FileName);
            sr.Write(tb.Text);
            sr.Close();
        }
    }
}