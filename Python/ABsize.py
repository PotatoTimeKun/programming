def ABsize(AorB:str,size:int):
    """
    引数に("A"か"B",サイズ番号)を渡すと指定したA判、B判のサイズをmmでリストを返します。リストは縦長になる向きで[縦,横]となります。
    """
    A0=[841,1189]
    B0=[1030,1456]
    if(size<0):return [-1,-1]
    if(size>0 and AorB=="A"):
        for i in range(0,size):
            if(A0[0]>A0[1]):
                A0[0]=int(A0[0]/2)
                sw=A0[0]
                A0[0]=A0[1]
                A0[1]=sw
            else:
                A0[1]=int(A0[1]/2)
                sw=A0[0]
                A0[0]=A0[1]
                A0[1]=sw
    if(size>0 and AorB=="B"):
        for i in range(0,size):
            if(B0[0]>B0[1]):
                B0[0]=int(B0[0]/2)
                sw=B0[0]
                B0[0]=B0[1]
                B0[1]=sw
            else:
                B0[1]=int(B0[1]/2)
                sw=B0[0]
                B0[0]=B0[1]
                B0[1]=sw
    if(AorB=="A"):return A0
    if(AorB=="B"):return B0