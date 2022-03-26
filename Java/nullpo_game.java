import java.util.Random;
import java.io.BufferedReader;
import java.io.InputStreamReader;
public class nullpo_game {
    public static void main(String args[]){
        Random r=new Random();
        int i,count=0;
        while(true){
            System.out.println("連続正解数:"+count);
            BufferedReader read=new BufferedReader(new InputStreamReader(System.in));
            try{read.readLine();}catch(Exception e){}
            i=r.nextInt(3);
            if(i==0)throw new NullPointerException();
            System.out.println("正解!");
            count++;
        }
    }
}
