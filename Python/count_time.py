from time import perf_counter as perC
counted=0
"""直前に計測が完了した処理の秒数"""
def funcTimer(functionObject:function)->function:
    """
    処理を実行してから完了するまでの時間を計測するデコレータです。
    変数countedに計測した秒数を代入します。
    """
    def retFunc(*args,**kwards):
        global counted
        st=perC()
        ret=functionObject(*args,**kwards)
        en=perC()
        counted=en-st
        return ret
    return retFunc