class Chipher:
    """
    暗号を扱うクラスです
    """
    def ceasar(mode:str,sentence:str,shift:int)->str:
        """
        シーザー暗号を扱います。
        mode "m":暗号化モード,"r":復号化モード
        sentence 変換する文字列
        shift シフトする数
        ->return 暗号文または平文
        """
        sentence=sentence.lower()
        a=ord('a')
        z=ord('z')
        ret=""
        if(mode=="m"):
            if(shift<0):return Chipher.ceasar("r",sentence,shift)
            for i in sentence:
                if(ord(i)>=a and ord(i)<=z):
                    ret+=chr(a+(ord(i)-a+shift)%26)
                else:ret+=i
            ret=ret.upper()
        if(mode=="r"):
            if(shift<0):return Chipher.ceasar("m",sentence,shift)
            for i in sentence:
                if(ord(i)>=a and ord(i)<=z):
                    p=(ord(i)-a-shift)%26
                    if(p<0):p+=26
                    ret+=chr(a+p)
                else:ret+=i
            ret=ret.lower()
        return ret
    def vigenere(mode:str,sentence:str,key:str)->str:
        """
        ヴィジュネル暗号を扱います。
        mode "m":暗号化モード,"r":復号化モード
        sentence 変換する文字列
        key 鍵
        ->return 暗号文または平文
        """
        a=ord('a')
        z=ord('z')
        key=key.lower()
        sentence=sentence.lower()
        b=0
        ret=""
        if(mode=="m"):
            for i in sentence:
                if b==len(key):
                    b=0
                if(i>=a and i<=z):
                    ret+=chr(a+(ord(i)+ord(key[b])-2*a)%26)
                else :
                    ret+=i
                b+=1
                ret=ret.upper()
        if(mode=="r"):
            for i in sentence:
                if b==len(key):
                    b=0
                if(i>=a and i<=z):
                    if((ord(i)-ord(key[b])%26>=0)):
                        ret+=chr(a+(ord(i)-ord(key[b])%26))
                    else:
                        ret+=chr(a+26+(ord(i)-ord(key[b])%26>=0))
                else :
                    ret+=i
                b+=1
                ret=ret.lower()
        return ret
    def substitution(mode:str,sentence:str,key:str)->str:
        """
        単一換字式暗号を扱います。
        mode "m":暗号化モード,"r":復号化モード
        sentence 変換する文字列
        key 鍵(a-zに対応した文字列)
        ->return 暗号文または平文
        """
        abc = "abcdefghijklmnopqrstuvwxyz"
        ret=""
        if mode=="m":
            for i in range(0,len(sentence)):
                ret+=key[abc.index(sentence[i])]
        if mode=="r":
            for i in range(0,len(sentence)):
                ret+=abc[key.index(sentence[i])]
        return ret
    def polybius_square(mode:str,sentence:str)->str:
        """
        ポリュビオスの暗号表(5*5)を扱います。
        5*5の方式ではjとiの暗号が同じ結果になります。そのため、復号結果ではiはiのままjをiとします。
        平文ではa-z以外の文字(空白も含む)は除いてください。
        暗号文では0と1以外の文字(空白も含む)は除いてください。
        mode "m":暗号化モード,"r":復号化モード
        sentence 変換する文字列
        ->return 暗号文または平文
        """
        ret=""
        a=ord('a')
        j=ord('j')
        if(mode=="m"):
            for i in range(0,len(sentence)):
                c=ord(sentence[i])-a
                if(c>=j):c-=1
                ret+=str(c/5+1)
                ret+=str(c%5+1)
        if(mode=="r"):
            for i in range(0,len(sentence)):
                c=a+(5*(ord(sentence[2*i])-ord('0')-1)+(ord(sentence[2*i+1])-ord('0')-1))
                if(c>=j):c+=1
                ret+=chr(c)
        return ret
    def scytale(mode:str,sentence:str)->str:
        """
        スキュタレー暗号を扱います。
        ５列に分けて暗号化します。
        mode "m":暗号化モード,"r":復号化モード
        sentence 変換する文字列
        ->return 暗号文または平文
        """
        ret=""
        if(mode=="m"):
            table=[[0,0,0,0,0]]
            for i in range(0,len(sentence)):
                if(len(table)<=int((i)/5)):table.append([0,0,0,0,0])
                table[int(i/5)][i%5]=ord(sentence[i])
            for i in range(0,5):
                for j in range(0,len(table)):
                    if(table[j][i]!=0):ret+=chr(table[j][i])
        if(mode=="r"):
            table=[[0,0,0,0,0]]
            for i in range(0,len(sentence)):
                if(len(table)<=int((i)/5)):table.append([0,0,0,0,0])
                table[int(i/5)][i%5]=ord(sentence[i])
            k=0
            for i in range(0,5):
                for j in range(0,len(table)):
                    if(k<len(sentence) and table[j][i]!=0):
                        table[j][i]=ord(sentence[k])
                        k+=1
            for i in range(0,len(sentence)):
                if(table[int(i/5)][i%5]!=0):ret+=chr(table[int(i/5)][i%5])
        return ret