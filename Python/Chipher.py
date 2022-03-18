class Chipher:
    def ceasar(mode,sentence,shift):
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
    def vigenere(mode,sentence,key):
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
    def substitution(mode,sentence,key):
        abc = "abcdefghijklmnopqrstuvwxyz"
        ret=""
        if mode=="m":
            for i in range(0,len(sentence)):
                ret+=key[abc.index(sentence[i])]
        if mode=="r":
            for i in range(0,len(sentence)):
                ret+=abc[key.index(sentence[i])]
        return ret
    def polybius_square(mode,sentence):
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