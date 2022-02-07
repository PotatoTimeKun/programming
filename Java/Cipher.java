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
}
