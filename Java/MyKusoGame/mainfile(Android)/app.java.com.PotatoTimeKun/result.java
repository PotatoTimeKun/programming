package com.PotatoTimeKun;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Random;

public class result extends AppCompatActivity {
    public static int chara=13;
    public static int point=0;
    public static int getc=0;
    public static int geti=0;
    public static int geti2[]={-1,-1,-1};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        Button fnbt=findViewById(R.id.fnbt);
        fnbt.setOnClickListener(new fnli());
        Intent intent=getIntent();
        point=intent.getIntExtra("point",0);
        TextView txpo=findViewById(R.id.point);
        txpo.setText(String.valueOf(point)+"点");
        String high="";
        try {
            InputStream in;
            String buf;
            int i=0;
            in = openFileInput("data.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
            while ((buf = reader.readLine()) != null) {
                if(i==0)high=buf;
                if(i==1)chara=Integer.valueOf(buf);
                i++;
            }
        } catch (IOException e) {}
        TextView txhi=findViewById(R.id.high);
        txhi.setText("過去最高点："+high+"点");
        getc=charagacha();
        geti=itemgacha();
        ImageView img=findViewById(R.id.charaimg);
        TextView cn=findViewById(R.id.charaname);
        TextView cd=findViewById(R.id.charadetails);
        switch (getc){
            case 0:
                img.setBackgroundResource(R.drawable.p1);
                cn.setText("ポテト君(クソ)");
                cd.setText("初期値を12にする");
                break;
            case 1:
                img.setBackgroundResource(R.drawable.n1);
                cn.setText("コッニ(クソ)");
                cd.setText("かなりたまに負効果ボタンを1つ無効化");
                break;
            case 2:
                img.setBackgroundResource(R.drawable.h1);
                cn.setText("ヘァドン(クソ)");
                cd.setText("もらえるアイテム数がたまに2個になる");
                break;
            case 3:
                img.setBackgroundResource(R.drawable.pa1);
                cn.setText("1本のパスタ(クソ)");
                cd.setText("かなりたまに良効果ボタンが更に良くなる");
                break;
            case 4:
                img.setBackgroundResource(R.drawable.p2);
                cn.setText("フライドポテト君(まだマシ)");
                cd.setText("初期値を20にする");
                break;
            case 5:
                img.setBackgroundResource(R.drawable.n2);
                cn.setText("角をアゴに生やしたコッニ(まだマシ)");
                cd.setText("たまに負効果ボタンが1つ無効化");
                break;
            case 6:
                img.setBackgroundResource(R.drawable.h2);
                cn.setText("3本指のヘァドン(まだマシ)");
                cd.setText("もらえるアイテム数が2個になる");
                break;
            case 7:
                img.setBackgroundResource(R.drawable.pa2);
                cn.setText("10本のパスタ(まだマシ)");
                cd.setText("たまに良効果ボタンが更に良くなる");
                break;
            case 8:
                img.setBackgroundResource(R.drawable.p3);
                cn.setText("真のポテト君(クソレア)");
                cd.setText("初期値を100にする");
                break;
            case 9:
                img.setBackgroundResource(R.drawable.n3);
                cn.setText("ココッニッニ(クソレア)");
                cd.setText("たまに負効果ボタンが最大2つ無効化");
                break;
            case 10:
                img.setBackgroundResource(R.drawable.h3);
                cn.setText("ドンドドン，ヘァァ！(クソレア)");
                cd.setText("もらえるアイテム数が4個になる");
                break;
            case 11:
                img.setBackgroundResource(R.drawable.pa3);
                cn.setText("虚数本のパスタ(クソレア)");
                cd.setText("割とよく良効果ボタンが更に良くなる");
                break;
            case 12:
                img.setBackgroundResource(R.drawable.p4);
                cn.setText("パスタ食ってるコッニコニのポテト君(マジレア)");
                cd.setText("クソレアキャラの機能を全て持ち合わせている");
                break;
        }
        ImageView iimg=findViewById(R.id.itemimg);
        TextView ina=findViewById(R.id.itemname);
        switch (geti){
            case 0:
                iimg.setBackgroundResource(R.drawable.p);
                ina.setText("じゃがいも");
                break;
            case 1:
                iimg.setBackgroundResource(R.drawable.c);
                ina.setText("お茶");
                break;
            case 2:
                iimg.setBackgroundResource(R.drawable.s);
                ina.setText("シャー芯");
                break;
            case 3:
                iimg.setBackgroundResource(R.drawable.k);
                ina.setText("金の髪の毛");
                break;
        }
        Random random=new Random();
        if(chara==2 && random.nextInt(3)==1){
            geti2[0]=itemgacha();
            TextView ina2=findViewById(R.id.itemname2);
            switch (geti2[0]){
                case 0:
                    ina2.setText("ボーナス：じゃがいも");
                    break;
                case 1:
                    ina2.setText("ボーナス：お茶");
                    break;
                case 2:
                    ina2.setText("ボーナス：シャー芯");
                    break;
                case 3:
                    ina2.setText("ボーナス：金の髪の毛");
                    break;
            }
        }
        if(chara==6){
            geti2[0]=itemgacha();
            TextView ina2=findViewById(R.id.itemname2);
            switch (geti2[0]){
                case 0:
                    ina2.setText("ボーナス：じゃがいも");
                    break;
                case 1:
                    ina2.setText("ボーナス：お茶");
                    break;
                case 2:
                    ina2.setText("ボーナス：シャー芯");
                    break;
                case 3:
                    ina2.setText("ボーナス：金の髪の毛");
                    break;
            }
        }
        if(chara==10||chara==12){
            geti2[0]=itemgacha();
            TextView ina2=findViewById(R.id.itemname2);
            switch (geti2[0]){
                case 0:
                    ina2.setText("ボーナス：じゃがいも");
                    break;
                case 1:
                    ina2.setText("ボーナス：お茶");
                    break;
                case 2:
                    ina2.setText("ボーナス：シャー芯");
                    break;
                case 3:
                    ina2.setText("ボーナス：金の髪の毛");
                    break;
            }
            geti2[1]=itemgacha();
            TextView ina3=findViewById(R.id.itemname3);
            switch (geti2[1]){
                case 0:
                    ina3.setText("ボーナス：じゃがいも");
                    break;
                case 1:
                    ina3.setText("ボーナス：お茶");
                    break;
                case 2:
                    ina3.setText("ボーナス：シャー芯");
                    break;
                case 3:
                    ina3.setText("ボーナス：金の髪の毛");
                    break;
            }
            geti2[2]=itemgacha();
            TextView ina4=findViewById(R.id.itemname4);
            switch (geti2[2]){
                case 0:
                    ina4.setText("ボーナス：じゃがいも");
                    break;
                case 1:
                    ina4.setText("ボーナス：お茶");
                    break;
                case 2:
                    ina4.setText("ボーナス：シャー芯");
                    break;
                case 3:
                    ina4.setText("ボーナス：金の髪の毛");
                    break;
            }
        }
    }
    private class fnli implements View.OnClickListener{
        @Override
        public void onClick(View view){
            String st="";
            try {
                InputStream in;
                OutputStream out;
                String buf;
                int i=0;
                in = openFileInput("data.txt");
                BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                while ((buf = reader.readLine()) != null) {
                    if(i==0 && Integer.valueOf(buf)<point)st+=String.valueOf(point);
                    else if(i==6+getc)st+="1";
                    else if(i==2+geti)st+=String.valueOf(Integer.valueOf(buf)+1);
                    else st+=buf;
                    if(i!=19)st+="\n";
                    i++;
                }
                out = openFileOutput("data.txt", MODE_PRIVATE);
                PrintWriter wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                wri.write(st);
                wri.close();
                out.close();
                in.close();
                reader.close();
                for(int j=0;j<3;j++){
                    st="";
                    i=0;
                    in = openFileInput("data.txt");
                    reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                    while ((buf = reader.readLine()) != null) {
                        if(i==0 && Integer.valueOf(buf)<point)st+=String.valueOf(point);
                        else if(i==6+getc)st+="1";
                        else if(i==2+geti2[j] && geti2[j]!=-1)st+=String.valueOf(Integer.valueOf(buf)+1);
                        else st+=buf;
                        if(i!=19)st+="\n";
                        i++;
                    }
                    in.close();
                    reader.close();
                    out = openFileOutput("data.txt", MODE_PRIVATE);
                    wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                    wri.write(st);
                    wri.close();
                    out.close();
                }
                out = openFileOutput("data.txt", MODE_PRIVATE);
                wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                wri.write(st);
                wri.close();
            } catch (IOException e) {}
            finish();
        }
    }
    private int charagacha(){
        int ret=0,p=point;
        Random random=new Random();
        if(p<=99){
            int v=random.nextInt(1000);
            if(v<=237)ret=0;
            if(v>=238 && v<=475)ret=1;
            if(v>=476 && v<=712)ret=2;
            if(v>=713 && v<=949)ret=3;
            if(v>=950 && v<=962)ret=4;
            if(v>=963 && v<=974)ret=5;
            if(v>=975 && v<=986)ret=6;
            if(v>=987 && v<=998)ret=7;
            if(v==999)ret= 8+random.nextInt(4);
        }
        else if(p<=199){
            int v=random.nextInt(1000);
            if(v<=225)ret=0;
            if(v>=226 && v<=450)ret=1;
            if(v>=451 && v<=675)ret=2;
            if(v>=676 && v<=899)ret=3;
            if(v>=900 && v<=922)ret=4;
            if(v>=923 && v<=943)ret=5;
            if(v>=944 && v<=966)ret=6;
            if(v>=967 && v<=988)ret=7;
            if(v>=989 && v<=999)ret= 8+random.nextInt(4);
        }
        else if(p<=299){
            int v=random.nextInt(1000);
            if(v<=199)ret=0;
            if(v>=200 && v<=399)ret=1;
            if(v>=400 && v<=599)ret=2;
            if(v>=600 && v<=799)ret=3;
            if(v>=800 && v<=849)ret=4;
            if(v>=850 && v<=874)ret=5;
            if(v>=875 && v<=924)ret=6;
            if(v>=925 && v<=949)ret=7;
            if(v>=950 && v<=966)ret= 8;
            if(v>=967 && v<=973)ret= 9;
            if(v>=974 && v<=990)ret= 10;
            if(v>=991 && v<=998)ret= 11;
            if(v==999)ret= 12;
        }
        else{
            int v=random.nextInt(1000),b=p/100;
            if(v<=199-12*b)ret=0;
            if(v>=200-12*b && v<=399-12*b)ret=1;
            if(v>=400-12*b && v<=599-12*b)ret=2;
            if(v>=600-12*b && v<=799-12*b)ret=3;
            if(v>=800-12*b && v<=849-10*b)ret=4;
            if(v>=850-10*b && v<=874-8*b)ret=5;
            if(v>=875-8*b && v<=924-6*b)ret=6;
            if(v>=925-6*b && v<=949-4*b)ret=7;
            if(v>=950-4*b && v<=966-3*b)ret= 8;
            if(v>=967-3*b && v<=973-2*b)ret= 9;
            if(v>=974-2*b && v<=990-b)ret= 10;
            if(v>=991-b && v<=998)ret= 11;
            if(v==999)ret= 12;
        }
        return ret;
    }
    private int itemgacha(){
        int ret=0,p=point;
        Random random=new Random();
        int v=random.nextInt(100),b=p/100;
        if(v<=90-b-b-b-(int)(b/3))ret=0;
        else if(v<=94-b-b-(int)(b/3))ret=1;
        else if(v<=98-b-(int)(b/3))ret=2;
        else if(v<=99-(int)(b/3))ret=3;
        return ret;
    }
}