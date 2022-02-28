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

public class setchara extends AppCompatActivity {
    public static String number="";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setchara);
        Button bt = findViewById(R.id.backb);
        bt.setOnClickListener(new backbuttonlistener());
        Intent intent=getIntent();
        String numb=intent.getStringExtra("number");
        number=numb.substring(0,numb.length()-1);
        String name=intent.getStringExtra("name");
        TextView tnu=findViewById(R.id.num),tna=findViewById(R.id.nam);
        tnu.setText(number);
        tna.setText(name);
        ImageView img=findViewById(R.id.img);
        TextView tx=findViewById(R.id.details);
        switch (Integer.valueOf(number)){
            case 0:
                img.setBackgroundResource(R.drawable.p1);
                tx.setText("初期値を12にする");
                break;
            case 1:
                img.setBackgroundResource(R.drawable.n1);
                tx.setText("かなりたまに負効果ボタンを1つ無効化");
                break;
            case 2:
                img.setBackgroundResource(R.drawable.h1);
                tx.setText("もらえるアイテム数がたまに2個になる");
                break;
            case 3:
                img.setBackgroundResource(R.drawable.pa1);
                tx.setText("かなりたまに良効果ボタンが更に良くなる");
                break;
            case 4:
                img.setBackgroundResource(R.drawable.p2);
                tx.setText("初期値を20にする");
                break;
            case 5:
                img.setBackgroundResource(R.drawable.n2);
                tx.setText("たまに負効果ボタンが1つ無効化");
                break;
            case 6:
                img.setBackgroundResource(R.drawable.h2);
                tx.setText("もらえるアイテム数が2個になる");
                break;
            case 7:
                img.setBackgroundResource(R.drawable.pa2);
                tx.setText("たまに良効果ボタンが更に良くなる");
                break;
            case 8:
                img.setBackgroundResource(R.drawable.p3);
                tx.setText("初期値を100にする");
                break;
            case 9:
                img.setBackgroundResource(R.drawable.n3);
                tx.setText("たまに負効果ボタンが最大2つ無効化");
                break;
            case 10:
                img.setBackgroundResource(R.drawable.h3);
                tx.setText("もらえるアイテム数が4個になる");
                break;
            case 11:
                img.setBackgroundResource(R.drawable.pa3);
                tx.setText("割とよく良効果ボタンが更に良くなる");
                break;
            case 12:
                img.setBackgroundResource(R.drawable.p4);
                tx.setText("クソレアキャラの機能を全て持ち合わせている");
                break;
        }
        Button setb=findViewById(R.id.set);
        setb.setOnClickListener(new setbt());
    }
    private class setbt implements View.OnClickListener{
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
                    if(i==1)st+=number;
                    else st+=buf;
                    if(i!=19)st+="\n";
                    i++;
                }
                out = openFileOutput("data.txt", MODE_PRIVATE);
                PrintWriter wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                wri.write(st);
                wri.close();
            } catch (IOException e) {}
        }
    }
    private class backbuttonlistener implements View.OnClickListener{
        @Override
        public void onClick(View view){
            finish();
        }
    }
}