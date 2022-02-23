/**
 * マインクラフトのエンド要塞の位置をエンダーパールの動きから推測します。
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * 
 */

import java.io.*;
class yosai {
    public static void main(String[] args) {
        System.out.println("エンパA,Bについて\nAを投げた位置(x z) Aが落ちた位置(x z) Bを投げた位置(x z) Bが落ちた位置(x z)\nを入力");
        BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
        int a[]=new int[4],b[]=new int[4];
        String as[]=new String[4],bs[]=new String[4];
        try{
            for(int i=0;i<4;i++){
                if(i%2==0)System.out.println("x=");
                else System.out.println("y=");
                as[i]=br.readLine();
            }
            for(int i=0;i<4;i++){
                if(i%2==0)System.out.println("x=");
                else System.out.println("y=");
                bs[i]=br.readLine();
            }
        }catch(Exception e){}
        for(int i=0;i<4;i++) a[i]=Integer.parseInt(as[i]);
        for(int i=0;i<4;i++) b[i]=Integer.parseInt(bs[i]);
        double aa,ap,c,cp;
        aa=(double)(a[3]-a[1])/(double)(a[2]-a[0]);
        ap=(double)(b[3]-b[1])/(double)(b[2]-b[0]);
        c=a[1]-aa*a[0];
        cp=b[1]-ap*b[0];
        int x=(int)((cp-c)/(aa-ap));
        int y=(int)(x*aa+c);
        System.out.println("要塞のおおよその位置はx:"+x+" z:"+y);
    }
}