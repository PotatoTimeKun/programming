package com.PotatoTimeKun;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
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

public class game extends AppCompatActivity {
    public static int point=0;
    public static int[] btnset= {0,1,2,3,4,5};
    public static int chara=13;
    public static int[] item={0,0,0,0};
    public static boolean[] used={false,false};
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_game);
        Button fnbt=findViewById(R.id.fn);
        fnbt.setOnClickListener(new fnbtli());
        try {
            InputStream in;
            String buf;
            int i=0;
            in = openFileInput("data.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
            while ((buf = reader.readLine()) != null) {
                if(i==1)chara=Integer.valueOf(buf);
                if(i>=2 && i<=5)item[i-2]=Integer.valueOf(buf);
                i++;
            }
        } catch (IOException e) {}
        ImageView img=findViewById(R.id.cha);
        switch (chara){
            case 0:
                img.setBackgroundResource(R.drawable.p1);
                break;
            case 1:
                img.setBackgroundResource(R.drawable.n1);
                break;
            case 2:
                img.setBackgroundResource(R.drawable.h1);
                break;
            case 3:
                img.setBackgroundResource(R.drawable.pa1);
                break;
            case 4:
                img.setBackgroundResource(R.drawable.p2);
                break;
            case 5:
                img.setBackgroundResource(R.drawable.n2);
                break;
            case 6:
                img.setBackgroundResource(R.drawable.h2);
                break;
            case 7:
                img.setBackgroundResource(R.drawable.pa2);
                break;
            case 8:
                img.setBackgroundResource(R.drawable.p3);
                break;
            case 9:
                img.setBackgroundResource(R.drawable.n3);
                break;
            case 10:
                img.setBackgroundResource(R.drawable.h3);
                break;
            case 11:
                img.setBackgroundResource(R.drawable.pa3);
                break;
            case 12:
                img.setBackgroundResource(R.drawable.p4);
                break;
        }
        Random random = new Random();
        boolean doing;
        for(int i=0;i<6;i++){
            doing=true;
            while(doing){
                doing=false;
                btnset[i]=random.nextInt(7);
                for(int j=0;j<i;j++){if(btnset[j]==btnset[i]){doing=true;}}
            }
        }
        if(chara==1){
            for(int i=0;i<6;i++){
                if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                    if(random.nextInt(10)==1){btnset[i]=6;}
                    break;
                }
            }
        }
        if(chara==5){
            for(int i=0;i<6;i++){
                if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                    if(random.nextInt(4)==1){btnset[i]=6;}
                    break;
                }
            }
        }
        if(chara==9 || chara==12){
            int count=0;
            for(int i=0;i<6;i++){
                if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                    if(random.nextInt(4)==1){btnset[i]=6;}
                    count++;
                    if(count>=2)break;
                }
            }
        }
        if(chara==3){
            for(int i=0;i<6;i++){
                if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                    if(random.nextInt(30)==1){
                        if(btnset[i]==5)btnset[i]=7;
                        if(btnset[i]==2)btnset[i]=5;
                        if(btnset[i]==1)btnset[i]=2;
                    }
                }
            }
        }
        if(chara==7){
            for(int i=0;i<6;i++){
                if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                    if(random.nextInt(15)==1){
                        if(btnset[i]==5)btnset[i]=7;
                        if(btnset[i]==2)btnset[i]=5;
                        if(btnset[i]==1)btnset[i]=2;
                    }
                }
            }
        }
        if(chara==11 || chara==12){
            for(int i=0;i<6;i++){
                if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                    if(random.nextInt(3)==1){
                        if(btnset[i]==5)btnset[i]=7;
                        if(btnset[i]==2)btnset[i]=5;
                        if(btnset[i]==1)btnset[i]=2;
                    }
                }
            }
        }
        point=10;
        switch (chara){
            case 0:
                point=12;
                break;
            case 4:
                point=20;
                break;
            case 8:
                point=100;
                break;
            case 12:
                point=100;
                break;
            default:break;
        }
        TextView txpo=findViewById(R.id.pot);
        txpo.setText(String.valueOf(point));
        TextView txp=findViewById(R.id.pt);
        TextView txc=findViewById(R.id.ct);
        TextView txs=findViewById(R.id.st);
        TextView txk=findViewById(R.id.kt);
        txp.setText(String.valueOf(item[0]));
        txc.setText(String.valueOf(item[1]));
        txs.setText(String.valueOf(item[2]));
        txk.setText(String.valueOf(item[3]));
        ImageButton btp=findViewById(R.id.pb);
        ImageButton btc=findViewById(R.id.cb);
        ImageButton bts=findViewById(R.id.sb);
        ImageButton btk=findViewById(R.id.kb);
        itemli l=new itemli();
        btp.setOnClickListener(l);
        btc.setOnClickListener(l);
        bts.setOnClickListener(l);
        btk.setOnClickListener(l);
        Button bt1=findViewById(R.id.bt1);
        Button bt2=findViewById(R.id.bt2);
        Button bt3=findViewById(R.id.bt3);
        Button bt4=findViewById(R.id.bt4);
        Button bt5=findViewById(R.id.bt5);
        Button bt6=findViewById(R.id.bt6);
        btn6 btli=new btn6();
        bt1.setOnClickListener(btli);
        bt2.setOnClickListener(btli);
        bt3.setOnClickListener(btli);
        bt4.setOnClickListener(btli);
        bt5.setOnClickListener(btli);
        bt6.setOnClickListener(btli);
    }
    private class fnbtli implements View.OnClickListener{
        @Override
        public void onClick(View view){
            OutputStream out;
            InputStream in;
            String buf,st="";
            int i=0;
            try {
                in = openFileInput("data.txt");
                BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
                while ((buf = reader.readLine()) != null) {
                    if(i>=2 && i<=5)st+=String.valueOf(item[i-2]);
                    else st+=buf;
                    if(i!=19)st+="\n";
                    i++;
                }
                out = openFileOutput("data.txt", MODE_PRIVATE);
                PrintWriter wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                wri.write(st);
                wri.close();
            } catch (IOException e) {}
            Intent intent=new Intent(game.this,result.class);
            intent.putExtra("point",point);
            startActivity(intent);
            finish();
        }
    }
    private class itemli implements View.OnClickListener{
        @Override
        public void onClick(View view){
            int id=view.getId();
            switch (id){
                case R.id.pb:
                    if(item[0]>0){
                        point+=1;
                        item[0]--;
                    }
                    break;
                case R.id.sb:
                    if(item[2]>0){
                        point*=2;
                        item[2]--;
                    }
                    break;
                case R.id.cb:
                    if(item[1]>0 && !used[0]){
                        for(int i=0;i<6;i++){
                            if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                                btnset[i]=6;
                                break;
                            }
                        }
                        item[1]--;
                        used[0]=true;
                    }
                    break;
                case R.id.kb:
                    if(item[3]>0 && !used[1]){
                        for(int i=0;i<6;i++){
                            switch (btnset[i]){
                                case 0:
                                    btnset[i]=6;
                                    break;
                                case 1:
                                    btnset[i]=2;
                                    break;
                                case 2:
                                    btnset[i]=7;
                                    break;
                                case 3:
                                    btnset[i]=6;
                                    break;
                                case 4:
                                    btnset[i]=3;
                                    break;
                                case 5:
                                    btnset[i]=7;
                                    break;
                                case 6:
                                    btnset[i]=1;
                                    break;
                                default:break;
                            }
                        }
                    item[3]--;
                    used[1]=true;
                    }
                    break;
                default:break;
                }
            TextView txpo=findViewById(R.id.pot);
            txpo.setText(String.valueOf(point));
            TextView txp=findViewById(R.id.pt);
            TextView txc=findViewById(R.id.ct);
            TextView txs=findViewById(R.id.st);
            TextView txk=findViewById(R.id.kt);
            txp.setText(String.valueOf(item[0]));
            txc.setText(String.valueOf(item[1]));
            txs.setText(String.valueOf(item[2]));
            txk.setText(String.valueOf(item[3]));
            }
        }
        private class btn6 implements View.OnClickListener{
            @Override
            public void onClick(View view){
                int id=view.getId(),btnow=0;
                switch (id){
                    case R.id.bt1:
                        btnow=0;
                        break;
                    case R.id.bt2:
                        btnow=1;
                        break;
                    case R.id.bt3:
                        btnow=2;
                        break;
                    case R.id.bt4:
                        btnow=3;
                        break;
                    case R.id.bt5:
                        btnow=4;
                        break;
                    case R.id.bt6:
                        btnow=5;
                        break;
                    default:break;
                }
                switch (btnset[btnow]){
                    case 0:
                        point=0;
                        break;
                    case 1:
                        point+=10;
                        break;
                    case 2:
                        point*=2;
                        break;
                    case 3:
                        point-=10;
                        break;
                    case 4:
                        point/=2;
                        break;
                    case 5:
                        point*=10;
                        break;
                    case 6:
                        break;
                    case 7:
                        point*=100;
                        break;
                    default:break;
                }
                Random random = new Random();
                boolean doing;
                for(int i=0;i<6;i++){
                    doing=true;
                    while(doing){
                        doing=false;
                        btnset[i]=random.nextInt(7);
                        for(int j=0;j<i;j++){if(btnset[j]==btnset[i]){doing=true;}}
                    }
                }
                if(chara==1){
                    for(int i=0;i<6;i++){
                        if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                            if(random.nextInt(10)==1){btnset[i]=6;}
                            break;
                        }
                    }
                }
                if(chara==5){
                    for(int i=0;i<6;i++){
                        if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                            if(random.nextInt(4)==1){btnset[i]=6;}
                            break;
                        }
                    }
                }
                if(chara==9 || chara==12){
                    int count=0;
                    for(int i=0;i<6;i++){
                        if(btnset[i]==0 || btnset[i]==3 || btnset[i]==4){
                            if(random.nextInt(4)==1){btnset[i]=6;}
                            count++;
                            if(count>=2)break;
                        }
                    }
                }
                if(chara==3){
                    for(int i=0;i<6;i++){
                        if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                            if(random.nextInt(30)==1){
                                if(btnset[i]==5)btnset[i]=7;
                                if(btnset[i]==2)btnset[i]=5;
                                if(btnset[i]==1)btnset[i]=2;
                            }
                        }
                    }
                }
                if(chara==7){
                    for(int i=0;i<6;i++){
                        if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                            if(random.nextInt(15)==1){
                                if(btnset[i]==5)btnset[i]=7;
                                if(btnset[i]==2)btnset[i]=5;
                                if(btnset[i]==1)btnset[i]=2;
                            }
                        }
                    }
                }
                if(chara==11 || chara==12){
                    for(int i=0;i<6;i++){
                        if(btnset[i]==1 || btnset[i]==2 || btnset[i]==5){
                            if(random.nextInt(3)==1){
                                if(btnset[i]==5)btnset[i]=7;
                                if(btnset[i]==2)btnset[i]=5;
                                if(btnset[i]==1)btnset[i]=2;
                            }
                        }
                    }
                }
                used[0]=false;
                used[1]=false;
                TextView txpo=findViewById(R.id.pot);
                txpo.setText(String.valueOf(point));
            }
        }
    }
