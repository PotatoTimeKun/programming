package com.PotatoTimeKun;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        OutputStream out;
        InputStream in;
        try {
            out = openFileOutput("data.txt",MODE_PRIVATE|MODE_APPEND);
            PrintWriter wri = new PrintWriter(new OutputStreamWriter(out,"UTF-8"));
            wri.close();
        } catch (IOException e) {}
        String buf,st="";
        int i=0;
        try {
            in = openFileInput("data.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
            while ((buf = reader.readLine()) != null) {
                i++;
            }
            if(i==0){
                st = "0\n13\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0\n0";
                out = openFileOutput("data.txt", MODE_PRIVATE);
                PrintWriter wri = new PrintWriter(new OutputStreamWriter(out, "UTF-8"));
                wri.write(st);
                wri.close();
            }
        } catch (IOException e) {}
        onlis btlis=new onlis();
        Button hw=findViewById(R.id.howto);
        hw.setOnClickListener(btlis);
        Button zk=findViewById(R.id.chara);
        zk.setOnClickListener(btlis);
        Button pl=findViewById(R.id.play);
        pl.setOnClickListener(btlis);
    }

    private class onlis implements View.OnClickListener{
        @Override
        public void onClick(View view){
            int id=view.getId();
            switch (id) {
                case R.id.howto:
                    Intent it = new Intent(MainActivity.this, howtoplay.class);
                    startActivity(it);
                    break;
                case R.id.chara:
                    Intent itc=new Intent(MainActivity.this,kusozukan.class);
                    startActivity(itc);
                    break;
                case R.id.play:
                    Intent intent=new Intent(MainActivity.this,game.class);
                    startActivity(intent);
                    break;
            }
        }
    }
}