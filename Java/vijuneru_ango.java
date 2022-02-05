import java.io.*;
class mkang
{
    public mkang(String k,String s){
        key=k;
        str=s;
        System.out.println("Set\nKey:"+key+"\nString:"+str);
    }
    static final String to="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";
    static final String abc="abcdefghijklmnopqrstuvwxyz";
    protected String key;
    protected String str;
    protected int[] sst;
    protected int[] kke;
    public void mklist(){
        key=key.toLowerCase();
        str=str.toLowerCase();
        kke =new int[key.length()];
        for(int c=0;c<key.length();c++){
            String d=key.substring(c, c+1);
            kke[c]=abc.indexOf(d);
        }
        sst=new int[str.length()];
        for(int f=0;f<str.length();f++){
            String g=str.substring(f,f+1);
            sst[f]=abc.indexOf(g);
        }
    }
    public String mk(){
        mklist();
        int b=0;
        String ret="";
        for(int a=0;a<str.length();a++){
            if(b==key.length()){
                b=0;
            }
            ret+=to.substring(sst[a]+kke[b],sst[a]+kke[b]+1);
            b++;
        }
        return ret;
    }
}
class readang extends mkang{
    readang(String k,String s){
        super(k,s);
    }
    public String mk(){
        mklist();
        int b=0;
        String ret="";
        for(int a=0;a<str.length();a++){
            if(b==key.length()){
                b=0;
            }
            if(sst[a]-kke[b]>-1){
                ret+=abc.substring(sst[a]-kke[b],sst[a]-kke[b]+1);
            }else{
                ret+=abc.substring(26+sst[a]-kke[b],26+sst[a]-kke[b]+1);
            }
            b++;
        }
        return ret;
    };
}
class use
{
    public static void main(String[] args)throws IOException
    {
        BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
        boolean wi=true;
        while(wi==true){
            System.out.println("\nWrite command\nmake  read");
            String com=br.readLine();
            if(com.equalsIgnoreCase("make")){
                System.out.println("Write key");
                String linek = br.readLine();
                System.out.println("Write String");
                String lines=br.readLine();
                mkang ma=new mkang(linek,lines);
                System.out.println("\nReturn:"+ma.mk());
            }
            else if(com.equalsIgnoreCase("read")){
                System.out.println("Write key");
                String linek = br.readLine();
                System.out.println("Write String");
                String lines=br.readLine();
                mkang ma=new readang(linek,lines);
                System.out.println("\nReturn:"+ma.mk());
            }
            else{
                wi=false;
            }
        }
    }
}