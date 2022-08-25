import java.io.BufferedReader;
import java.lang.Math;
import java.io.*;
public class circle {
    static public void main(String args[]) throws IOException {
        System.out.print("r=");
        BufferedReader read=new BufferedReader(new InputStreamReader(System.in));
        String r=read.readLine();
        System.out.print("x=");
        String x=read.readLine();
        System.out.print(menseki(Double.parseDouble(x),Double.parseDouble(r)));
    }
    /**
     * 原点を中心とする半径rの円で、-rからxまでをx軸に垂直な直線で区切った範囲の面積を返す
     * @param x double x座標
     * @param r double 半径
     * @return double 面積
     */
    static public double menseki(double x,double r){
        double s=0;
        if(x>0.0){
            s+=Math.PI*r*r/2;
            s+=2*r*r*(Math.asin(x/r)/2+Math.sin(2*Math.asin(x/r))/4);
            // ∫[0->x]√(r^2-x^2)dx = r^2[t/2+sin(2t)/4][0->arcsin(x/r)]
        }
        else if(x==0.0){
            s=Math.PI*r*r/2.0;
        }
        else{
            s=Math.PI*r*r/2-2*r*r*(Math.asin(-x/r)/2+Math.sin(2.0*Math.asin(-x/r))/4);
        }
        return s;
    }
}
