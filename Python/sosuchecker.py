def check_prime(i):
    if float(i).is_integer():
        i=int(i)
    else:
        return False
    if i<2:
        return False
    for ic in range(2,i):
        if i%ic==0:
            return False
    return True
if __name__=="__main__":
    inp=input()
    print(check_prime(inp)
