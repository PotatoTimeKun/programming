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