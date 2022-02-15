import java.util.List;
import java.util.stream.Collectors;
public class Cipher{
    static public String ceasar(String mode,String sentence,int shift){
        if(mode=="m"){
            if(shift<0)return ceasar("r",sentence,-shift);
            List<Integer> list = sentence.chars().boxed().collect(Collectors.toList()); 
            String ret="";
            int a='a';
            for(int i:list)ret+=Character.toString(a+(i-a+shift)%26);
            return ret;
        }
        if(mode=="r"){
            if(shift<0)return ceasar("m",sentence,-shift);
            List<Integer> list = sentence.chars().boxed().collect(Collectors.toList()); 
            String ret="";
            int a='a';
            for(int i:list){
                int p=(i-a-shift)%26;
                if(p<0)p=26+p;
                ret+=Character.toString(a+p);
            }
            return ret;
        }
        return "error";
    }
        static public String vigenere(String mode,String sentence,String key){
            String str=sentence;
            String to="ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQRSTUVWXYZ";
            String abc="abcdefghijklmnopqrstuvwxyz";
            int[] sst;
            int[] kke;
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
            int b=0;
            String ret="";
            if(mode=="m"){
                for(int a=0;a<str.length();a++){
                    if(b==key.length())b=0;
                    ret+=to.charAt(sst[a]+kke[b]);
                    b++;
                }
            }
            if(mode=="r"){
                for(int a=0;a<str.length();a++){
                    if(b==key.length())b=0;
                    if((sst[a]-kke[b])%26>=0)ret+=abc.charAt((sst[a]-kke[b])%26);
                    else ret+=abc.charAt(26+(sst[a]-kke[b])%26);
                    b++;
                }
            }
            return ret;
        }
        static public String substitution(String mode,String sentence,String key){
            String abc="abcdefghijklmnopqrstuvwxyz";
            String ret="";
            if(mode=="m"){
                for(int i=0;i<sentence.length();i++)ret+=key.charAt(abc.indexOf(sentence.charAt(i)));
            }
            if(mode=="r"){
                for(int i=0;i<sentence.length();i++)ret+=abc.charAt(key.indexOf(sentence.charAt(i)));
            }
            return ret;
        }
    }
