#include <stdio.h>
#include <stdlib.h>
#include <time.h>
/**
 * @brief 勝利した側の数字を返します。
 * 勝敗がない場合の返り値は0です。
 * @param array 盤面
 * @return int 0(同点) || 1(自分) || 2(相手)
 */
int win(const int array[][3])
{
    int winer = 0; // 勝者
    for (int i = 0; i < 3; i++)
    { // 縦横が一致
        if (array[i][0] == array[i][1] && array[i][1] == array[i][2] && array[i][0] != 0)
            winer = array[i][0];
        if (array[0][i] == array[1][i] && array[1][i] == array[2][i] && array[0][i] != 0)
            winer = array[0][i];
    }
    if (array[0][0] == array[1][1] && array[1][1] == array[2][2] && array[0][0] != 0)
        winer = array[0][0]; // 斜めが一致
    if (array[0][2] == array[1][1] && array[1][1] == array[2][0] && array[0][0] != 0)
        winer = array[0][2]; // 斜めが一致
    return winer;
}
/**
 * @brief (x,y)にiの駒を置きます。成功したら1、失敗したら0が返されます。
 * @param array 盤面
 * @return int 0(エラー) || 1
 */
int put(int array[][3], int x, int y, int i)
{ // x,yと座標のように取る→インデックスは[y][x]
    if (x < 0 || x > 3 || y < 0 || y > 3 || array[y][x] != 0)
        return 0; // 盤面外もしくは既に埋まってたら失敗
    array[y][x] = i;
    return 1;
}
/**
 * @brief 盤面を表示する関数
 * @param array 盤面
 */
void show(const int array[][3])
{
    printf("-------\n");
    for (int i = 0; i < 3; i++)
    { // 盤面の表示
        for (int j = 0; j < 3; j++)
        {
            switch (array[i][j])
            {
            case 0:
                printf("| "); // 0は空
                break;
            case 1:
                printf("|o"); // 1はo(自分)
                break;
            case 2:
                printf("|x"); // 2はx(相手)
                break;
            }
        }
        printf("|\n-------\n");
    }
}
int main()
{
    srand(time(NULL));             // 乱数のシード設定
    int table[3][3] = {{0, 0, 0}}; // 盤面
    int turn = 0;                  // 現在のターン(自分:0,相手:1)
    printf("oxゲーム!\nあなたはoです。\n\n");
    while (!win(table)) // 勝者が出るまで
    {
        printf("%sの番です\n", (turn) ? "相手" : "あなた");
        // turnが1(true)なら相手、0(false)なら自分
        show(table);
        int x, y; // 現在プレイヤーが記号を置く位置
        do
        {
            if (turn)
            {           // 相手なら、相手は有利なマスを選びつつ、選べなければ乱数を使用する
                x = -1; // 初期値を-1とする
                y = -1;
                for (int i = 0; i < 9; i++)
                { // となりが2つ空いてるマスを選ぶ(縦、横)
                    if (table[i / 3][i % 3] != 2)
                        continue; // 2のあるマスだけを考える
                    if (table[i / 3][(i + 1) % 3] == 0 && table[i / 3][(i + 2) % 2] == 0)
                    { // 横2つが空いている
                        y = i / 3;
                        x = (i + 1) % 3;
                    }
                    else if (table[(i / 3 + 1) % 3][i % 3] == 0 && table[(i / 3 + 2) % 3][i % 3] == 0)
                    { // 縦2つが空いている
                        y = (i / 3 + 1) % 3;
                        x = i % 3;
                    }
                }
                for (int i = 0; i < 3; i++)
                { // となりが2つ空いてるマスを選ぶ(斜め)
                    if (table[i][i] == 2 && table[(i + 1) % 3][(i + 1) % 3] == 0 && table[(i + 2) % 3][(i + 2) % 3] == 0)
                    { // 右下方向に2つ空いている
                        y = (i + 1) % 3;
                        x = (i + 1) % 3;
                    }
                    else if (table[(-i + 5) % 3][i] == 2 && table[(-i + 4) % 3][(i + 1) % 3] == 0 && table[(-i + 3) % 3][(i + 2) % 3] == 0)
                    { // 右上方向に2つ空いている
                        y = (-i + 4) % 3;
                        x = (i + 1) % 3;
                    }
                }
                for (int i = 0; i < 9; i++)
                { // もしoを付けられたら負けるマスを選ぶ
                    int table_copy[3][3];
                    for (int j = 0; j < 9; j++)
                        table_copy[j / 3][j % 3] = table[j / 3][j % 3]; // 盤面をコピー
                    if (put(table_copy, i / 3, i % 3, 1))
                    { // もしこのマスにoが置けて
                        if (win(table_copy) == 1)
                        { // コピーの盤面が負けていたら
                            x = i / 3;
                            y = i % 3;
                        }
                    }
                }
                for (int i = 0; i < 9; i++)
                { // もしxを付けたら勝つマスを選ぶ
                    int table_copy[3][3];
                    for (int j = 0; j < 9; j++)
                        table_copy[j / 3][j % 3] = table[j / 3][j % 3]; // 盤面をコピー
                    if (put(table_copy, i / 3, i % 3, 2))
                    { // もしこのマスにxが置けて
                        if (win(table_copy) == 2)
                        { // コピーの盤面が勝っていたら
                            x = i / 3;
                            y = i % 3;
                        }
                    }
                }
                if (x == -1 && y == -1)
                { // どのマスを選んでも有利でない場合
                    x = rand() % 3;
                    y = rand() % 3;
                }
            }
            else
            { // 自分なら、キーボード入力させる
                printf("どこにoを書きますか?\n横(0~2):");
                scanf("%d", &x);
                printf("縦(0~2):");
                scanf("%d", &y);
            }
        } while (!put(table, x, y, turn + 1)); // 置けるまで繰り返す
        printf("%sは(%d,%d)に%cを置いた\n\n", (turn) ? "相手" : "あなた", x, y, (turn) ? 'x' : 'o');
        turn = !turn;     // ターンを反転
        int breaking = 1; // while文を抜け出すかどうか
        for (int i = 0; i < 9; i++)
        {
            if (table[i / 3][i % 3] == 0)
                breaking = 0; // 0がある→全て埋まってない→ゲームを続ける
        }
        if (breaking)
            break;
    }
    show(table);
    switch (win(table))
    { // 勝敗の表示
    case 0:
        printf("あいこ、惜しい!");
        break;
    case 1:
        printf("勝利だ!!!");
        break;
    case 2:
        printf("負けてしまった...");
        break;
    }
}
