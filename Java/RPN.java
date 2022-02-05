import java.io.*;
import java.util.regex.*;
import java.util.*;
public class RPN{
    public static void main(String[] args) throws IOException{
        System.out.println("you can use \"1~9.()+-*/\"\nwrite formula");
        BufferedReader read=new BufferedReader(new InputStreamReader(System.in));
        String form=read.readLine();
        System.out.println("="+rp(form));
        System.out.println("="+String.valueOf(rpcal(rp(form))));
    }
    static String rp(String form){
        form="("+form+")";
        Pattern mi=Pattern.compile("\\((-\\d+\\.?\\d*)\\)");
        Matcher mat=mi.matcher(form);
        while(mat.find()){
            form=form.substring(0,mat.start())+"["+mat.group(1)+"]"+form.substring(mat.end());
            mat=mi.matcher(form);
        }
        Pattern tocha=Pattern.compile("[^\\[0-9](\\d+\\.?\\d*)[^\\]0-9]");
        mat=tocha.matcher(form);
        while(mat.find()){
            form=form.substring(0,mat.start(1))+"["+mat.group(1)+"]"+form.substring(mat.end(1));
            mat=tocha.matcher(form);
        }
        form=form.substring(1,form.length()-1);
        boolean stop=false;
        int kaknow=0;
        char[] formc=form.toCharArray();
        StringBuilder ret=new StringBuilder(formc.length),kakst=new StringBuilder(formc.length);
        Deque<Character> sta=new ArrayDeque<>();
        for(char c:formc){
            if(!stop){
                switch(c){
                    case '+':
                    case '-':
                        if(ret.toString().charAt(ret.length()-1)=='['){
                            ret.append(c);
                            break;
                        }
                        if(!sta.isEmpty()){if(sta.getFirst()=='+'||sta.getFirst()=='-')ret.append(sta.removeFirst());}
                        while(!sta.isEmpty()){
                            if(sta.getFirst()=='*'||sta.getFirst()=='/')ret.append(sta.removeFirst());
                            else break;
                        }
                        sta.addFirst(c);
                        break;
                    case '*':
                    case '/':
                        if(!sta.isEmpty()){if(sta.getFirst()=='*'||sta.getFirst()=='/')ret.append(sta.removeFirst());}
                        sta.addFirst(c);
                        break;
                    case '(':
                        stop=true;
                        kaknow=1;
                        break;
                    default:
                        ret.append(c);
                        break;
                }
            }else{
                switch(c){
                    case '(':
                        kaknow++;
                        kakst.append(c);
                        break;
                    case ')':
                        kaknow--;
                        if(kaknow==0){
                            String kakret=rp(kakst.toString());
                            ret.append(kakret);
                            stop=false;
                        }else kakst.append(c);
                        break;
                    default:
                        kakst.append(c);
                        break;
                }
            }
        }
        while(!sta.isEmpty())ret.append(sta.removeFirst());
        form=ret.toString();
        return form;
    }
    static Double rpcal(String form){
        char[] formc=form.toCharArray();
        double ret,val,valf,vall;
        String keep="";
        Deque<String> sta=new ArrayDeque<>();
        for(char c:formc){
            switch(c){
                case '[':
                    keep="[";
                    break;
                case ']':
                    sta.addFirst(keep.substring(1));
                    keep="";
                    break;
                case '+':
                    val=Double.valueOf(sta.removeFirst())+Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(val));
                    break;
                case '-':
                    if(keep=="["){
                        keep+=String.valueOf(c);
                        break;
                    }
                    valf=Double.valueOf(sta.removeFirst());
                    vall=Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(vall-valf));
                    break;
                case '*':
                    val=Double.valueOf(sta.removeFirst())*Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(val));
                    break;
                case '/':
                    valf=Double.valueOf(sta.removeFirst());
                    vall=Double.valueOf(sta.removeFirst());
                    sta.addFirst(String.valueOf(vall/valf));
                    break;
                default:
                    keep+=c;
                    break;
            }
        }
        ret=Double.valueOf(sta.removeFirst());
        return ret;
    }
}