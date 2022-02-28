package com.PotatoTimeKun;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class howtoplay extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_howtoplay);
        Button bt=findViewById(R.id.backbutton);
        backbuttonlistener li=new backbuttonlistener();
        bt.setOnClickListener(li);
    }
    private class backbuttonlistener implements View.OnClickListener{
        @Override
        public void onClick(View view){
            finish();
        }
    }
}