package com.PotatoTimeKun;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class kusozukan extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_kusozukan);
        OutputStream out;
        InputStream in;
        String buf;
        int i=0,now=0;
        boolean known[]=new boolean[13];
        for(int j=0;j<13;j++){known[j]=false;}
        try {
            in = openFileInput("data.txt");
            BufferedReader reader = new BufferedReader(new InputStreamReader(in, "UTF-8"));
            while ((buf = reader.readLine()) != null) {
                if(i>=6 && buf.equals("1")){
                    known[i-6]=true;
                    now++;
                }
                i++;
            }
        } catch (IOException e) {}
        TextView tv=findViewById(R.id.tx);
        tv.setText(Integer.toString(now)+"種類/13種類");
        ListView lv=findViewById(R.id.lv);
        List<Map<String,String>> lis=new ArrayList<>();
        Map<String,String> ite=new HashMap<>();
        for(int j=0;j<13;j++){
            if(known[j]){
                ite=new HashMap<>();
                ite.put("number",Integer.toString(j)+"番");
                switch(j){
                    case 0:
                        ite.put("name","ポテト君(クソ)");
                        break;
                    case 1:
                        ite.put("name","コッニ(クソ)");
                        break;
                    case 2:
                        ite.put("name","ヘァドン(クソ)");
                        break;
                    case 3:
                        ite.put("name","1本のパスタ(クソ)");
                        break;
                    case 4:
                        ite.put("name","フライドポテト君(まだマシ)");
                        break;
                    case 5:
                        ite.put("name","角をアゴに生やしたコッニ(まだマシ)");
                        break;
                    case 6:
                        ite.put("name","3本指のヘァドン(まだマシ)");
                        break;
                    case 7:
                        ite.put("name","10本のパスタ(まだマシ)");
                        break;
                    case 8:
                        ite.put("name","真のポテト君(クソレア)");
                        break;
                    case 9:
                        ite.put("name","ココッニッニ(クソレア)");
                        break;
                    case 10:
                        ite.put("name","ドンドドン，ヘァァ！(クソレア)");
                        break;
                    case 11:
                        ite.put("name","虚数本のパスタ(クソレア)");
                        break;
                    case 12:
                        ite.put("name","パスタ食ってるコッニコニのポテト君(マジレア)");
                        break;
                }
                lis.add(ite);
            }
        }
        String[] from={"number","name"};
        int[] to = {android.R.id.text1,android.R.id.text2};
        SimpleAdapter adapter = new SimpleAdapter(kusozukan.this,lis, android.R.layout.simple_list_item_2,from,to);
        lv.setAdapter(adapter);
        backbuttonlistener btl=new backbuttonlistener();
        Button bt=findViewById(R.id.bcbt);
        bt.setOnClickListener(btl);
        lv.setOnItemClickListener(new lisit());
    }
    private class backbuttonlistener implements View.OnClickListener{
        @Override
        public void onClick(View view){
            finish();
        }
    }
    private class lisit implements AdapterView.OnItemClickListener{
        @Override
        public void onItemClick(AdapterView<?> parent,View view,int position,long id){
            Map<String,String> item=(Map<String, String>) parent.getItemAtPosition(position);
            Intent intent=new Intent(kusozukan.this,setchara.class);
            intent.putExtra("number",item.get("number"));
            intent.putExtra("name",item.get("name"));
            startActivity(intent);
        }
    }
}