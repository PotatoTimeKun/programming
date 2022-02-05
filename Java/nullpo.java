public class nullpo {
    public static void main(String[] args){
        try{
            throw new NullPointerException();
        }catch(NullPointerException e){
            System.out.println("ぬるぽ");
            System.out.println("ガッ");
        }
    }
}
