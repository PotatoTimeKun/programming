class babanuki{
    protected int[] tehuda=new int[13*2+2];
    public babanuki(){
        for(int i=0;i<28;i++){tehuda[i]=-1;}
    }
    public babanuki(int[] new_tehuda){
        babanuki();
        for(int i=0;i<new_tehuda.Length;i++){tehuda[i]=new_tehuda[i];}
    }
    public void set(int[] new_tehuda){
        babanuki(new_tehuda);
    }
    public int[] get(){
        int[] ret;
        int cou=0;
        for(int i=0;i<28;i++){if(tehuda[i]>=0)cou++;}
        ret=new int[cou];
        int j=0;
        for(int i=0;i<28;i++){
            if(tehuda[i]>=0){
                ret[j]=tehuda[i];
                j++;
            }
        }
        return ret;
    }
    public void drop(){
        for(int i=0;i<27;i++){
            for(int j=0;j<28;j++){
                if(tehuda[i]==tehuda[j]){
                    tehuda[i]=-1;
                    tehuda[j]=-1;
                }
            }
        }
    }
    public bool win(){
        bool ret=true;
        for(int i=0;i<28;i++){
            if(tehuda[i]>=0)ret=false;
        }
        return ret;
    }
}