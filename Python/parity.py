def odd_parity(value):
    i=0
    for c in value:
        if(c=="1"):
            i+=1
    if(i%2==0):return "1"
    return "0"
def even_parity(value):
    i=0
    for c in value:
        if(c=="1"):
            i+=1
    if(i%2==0):return "0"
    return "1"