// This is writed using shift-jis
/**
 * @file new_tabaicho.h
 * @author PotatoTimeKun (https://github.com/PotatoTimeKun)
 * @brief 
 * ���X�g�ɂ���đ��{�������������܂��B
 * ���{��������mkList�֐��ɂ���ĕԂ��ꂽTabaicho*�^�̕ϐ����g�p���܂��B
 * (���{�������Ԃ�)�l�����Z���s���֐��͂��ꂼ��sum,sub,mul,divi�ł��B
 * inputTabaicho�֐��̓L�[�{�[�h���͂ɂ���ē������{��������Ԃ��܂��B
 * showTabaicho�֐��͈����̑��{��������\�����܂��B
 * cmp�֐��͈����̑��{���������m�̑傫�����r���܂��B
 * ���̊֐��̃e�X�g��tabaicho.c�ōs���܂��B
 * 
 * @date 2022-06-11
 * 
 * @copyright Copyright (c) 2022 PotatoTimeKun
 * 
 */
#ifndef INCLUDE_NEW_TABAICHO
#define INCLUDE_NEW_TABAICHO
#include <stdlib.h>
#include <stdio.h>

/**
 * @brief �擪�ȊO�͂��̌^���g���A�v�f�̒l�Ǝ��v�f�ւ̃|�C���^�݂̂�����
 *
 */
typedef struct mylist_0
{
    int value;             // �v�f�̒l
    struct mylist_0 *next; //���̗v�f
} Tabaicho_child;

/**
 * @brief ���{�������������A�擪�݂̂��̌^���g��
 *
 */
typedef struct mylist_1
{
    int len;               // ���{�������̒���(���X�g�̒���)
    int value;             // �擪�̒l
    int minus;             // �l�����Ȃ�1������
    struct mylist_0 *next; //���̗v�f
} Tabaicho;

/**
 * @brief ���X�g�̖����ɗv�f��ǉ����܂�
 *
 * @param lis ���{������
 * @param val �v�f�̒l
 */
void add(Tabaicho *lis, int val)
{
    Tabaicho_child *newchild = (Tabaicho_child *)malloc(sizeof(Tabaicho_child));
    newchild->value = val;
    newchild->next = NULL;
    Tabaicho_child *index = lis->next;
    if (index == NULL)
    {
        lis->next = newchild;
        lis->len++;
        return;
    }
    while (index->next != NULL)
        index = index->next;
    index->next = newchild;
    lis->len++;
}

/**
 * @brief �w�肵���C���f�b�N�X�ɗv�f��ǉ����܂�
 *
 * @param lis ���{������
 * @param val �l
 * @param list_index �C���f�b�N�X
 */
void addAt(Tabaicho *lis, int val, int list_index)
{
    if (lis->len == list_index)
    {
        add(lis, val);
        return;
    }
    Tabaicho_child *newchild = (Tabaicho_child *)malloc(sizeof(Tabaicho_child));
    if (list_index == 0)
    {
        newchild->value = lis->value;
        newchild->next = lis->next;
        lis->value = val;
        lis->next = newchild;
        lis->len++;
        return;
    }
    newchild->value = val;
    if (list_index == 1)
    {
        newchild->next = lis->next;
        lis->next = newchild;
        lis->len++;
        return;
    }
    Tabaicho_child *index_for = lis->next;
    for (int i = 1; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return;
        index_for = index_for->next;
    }
    Tabaicho_child *index_back = index_for->next;
    index_for->next = newchild;
    newchild->next = index_back;
    lis->len++;
}

/**
 * @brief �V�������{�����������܂�
 *
 * @param val �l
 * @return ���{������
 */
Tabaicho *mkList()
{
    Tabaicho *newList = (Tabaicho *)malloc(sizeof(Tabaicho));
    newList->value = 0;
    newList->next = NULL;
    newList->len = 1;
    newList->minus = 0;
    return newList;
}

/**
 * @brief �w�肵���C���f�b�N�X�̒l��Ԃ��܂�
 *
 * @param lis ���{������
 * @param list_index �C���f�b�N�X
 * @return �l
 */
int numAt(Tabaicho *lis, int list_index)
{
    if (list_index == 0)
        return lis->value;
    Tabaicho_child *index = lis->next;
    for (int i = 1; i < list_index; i++)
    {
        if (index == NULL)
            return -2147483648;
        index = index->next;
    }
    return index->value;
}

/**
 * @brief �w�肵���C���f�b�N�X�̗v�f���폜���܂�
 *
 * @param lis ���{������
 * @param list_index �C���f�b�N�X
 * @return �폜�����l
 */
int delAt(Tabaicho *lis, int list_index)
{
    if (list_index == 0)
    {
        int ret = lis->value;
        lis->value = (lis->next)->value;
        lis->next = (lis->next)->next;
        free(lis->next);
        lis->len--;
        return ret;
    }
    Tabaicho_child *index_for = lis->next;
    if (list_index == 1)
    {
        int ret = lis->next->value;
        lis->next = index_for->next;
        free(index_for);
        lis->len--;
        return ret;
    }
    for (int i = 0; i < list_index - 1; i++)
    {
        if (index_for == NULL)
            return -2147483648;
        index_for = index_for->next;
    }
    Tabaicho_child *index = index_for->next;
    if (index == NULL)
        return -2147483648;
    index_for->next = index->next;
    int ret = index->value;
    free(index);
    lis->len--;
    return ret;
}

/**
 * @brief ���{���������폜���܂�
 *
 * @param lis ���{������
 */
void delList(Tabaicho *lis)
{
    if (lis->next == NULL)
    {
        free(lis);
        return;
    }
    Tabaicho_child *index = lis->next;
    while (lis->next != NULL)
    {
        index = lis->next;
        lis->next = index->next;
        free(index);
    }
    free(lis);
}

/**
 * @brief ���{���������L�[�{�[�h���͂Ŏ󂯎��܂�
 *
 * @param list ���{������
 */
Tabaicho* inputTabaicho()
{
    Tabaicho *list;
    list = mkList();
    while (1)
    {
        char c;
        scanf("%c", &c);
        if (c >= '0' && c <= '9')
        { // 0~9�̓��X�g�ɒǉ�
            add(list, c - '0');
        }
        else if (c == '-')
        { // -�������畉��(-���擪�łȂ��Ă����ɂȂ�)
            list->minus = 1;
        }
        else
            break; // �z���C�g�X�y�[�X�܂ނ��̑��̕����͓��͏I���Ƃ���
    }
    return list;
}

/**
 * @brief ���{���������o�͂��܂�
 *
 * @param list ���{������
 */
void showTabaicho(Tabaicho *list)
{
    int n = list->len;
    int not_zero = 0; // 0���ߔ�\���p
    if (list->minus)
        printf("-");
    for (int i = 0; i < n; i++)
    {
        if (numAt(list, i) != 0)
            not_zero = 1;
        if (not_zero || i == n - 1)
            printf("%d", numAt(list, i));
    }
    printf("\n");
}

Tabaicho *sub(Tabaicho *, Tabaicho *); //�v���g�^�C�v�錾

/**
 * @brief ���{���������m�̑����Z(a+b)
 *
 * @return Tabaicho* a+b
 */
Tabaicho *sum(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c;
    if (!a->minus && b->minus)
    { //�ٕ����Ȃ猸�@��
        b->minus = !b->minus;
        c = sub(a, b);
        b->minus = !b->minus;
        return c;
    }
    else if (a->minus && !b->minus)
    { //�ٕ����Ȃ猸�@��
        a->minus = !a->minus;
        c = sub(b, a);
        a->minus = !a->minus;
        return c;
    }
    c = mkList();
    while (a->len != b->len)
    {
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    int carry = 0;                        // �L�����[
    for (int k = a->len - 1; k >= 0; k--) // ��������擪�܂�
    {
        int tmp = numAt(a, k) + numAt(b, k) + carry; // �P���ɑ������l
        carry = tmp / 10;                            // �������̓L�����[��
        addAt(c, tmp % 10, 1);                       // ���ʂ�����
    }
    addAt(c, carry, 1); //�Ō�̃L�����[��ǉ�
    if (a->minus && b->minus)
        c->minus = 1; //�}�C�i�X���m�Ȃ猋�ʂ��}�C�i�X
    return c;
}

/**
 * @brief ���{���������m�̑傫���̔�r
 * @return 1(a>b) / 0(a==b) / -1(a<b)
 */
int cmp(Tabaicho *a, Tabaicho *b)
{
    if (a->minus && !b->minus)
        return -1; //�������Ⴄ�Ȃ�召�͖��炩
    if (!a->minus && b->minus)
        return 1; //�������Ⴄ�Ȃ�召�͖��炩
    while (a->len != b->len)
    { //�����𑵂���
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    for (int i = 0; i < a->len; i++)
    { // �擪����1��������
        if (numAt(b, i) > numAt(a, i))
        { // b[i]>a[i]
            if (!a->minus && !b->minus)
                return -1; // �����ŕԂ�l�͋t�ɂȂ�
            else
                return 1;
        }
        if (numAt(a, i) > numAt(b, i))
        { // a[i]>b[i]
            if (!a->minus && !b->minus)
                return 1; // �����ŕԂ�l�͋t�ɂȂ�
            else
                return -1;
        }
    }         // �召���Ȃ�������
    return 0; // 0(a==b)
}

/** �A�N�Z�X�񐄏��A�召�֌W�Ȃ������Z���s��*/
Tabaicho *_privatesub(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    while (a->len != b->len)
    {
        addAt((a->len < b->len) ? a : b, 0, 0);
    }
    int carry = 0; // �L�����[
    for (int i = a->len - 1; i >= 0; i--)
    {                                                // ��������擪�܂�
        int tmp = numAt(a, i) - numAt(b, i) - carry; // �P���Ɉ������l
        if (tmp < 0)
        {              // ���������̂����Ȃ�
            carry = 1; // �L�����[��ݒ�
            tmp += 10; // 10�����Đ��ɂ���
        }
        else
            carry = 0;
        addAt(c, tmp % 10, 1); // ���ʂ�����
    }
}

/**
 * @brief ���{���������m�̈����Z(a-b)
 *
 * @return Tabaicho* a-b
 */
Tabaicho *sub(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c;
    if (a->minus == !b->minus)
    { //�ٕ����Ȃ���@��
        b->minus = !b->minus;
        c = sum(a, b);
        b->minus = !b->minus;
        return c;
    }
    int size = cmp(a, b);
    if (size >= 0)
    { //�召�ŕ����Aa,b�̕����Ōv�Z���@��ς���(a,b���m�͓������������肦�Ȃ�)
        if (!a->minus)
            c = _privatesub(a, b);
        else
            c = _privatesub(b, a);
        c->minus = 0;
    }
    else
    {
        if (!a->minus)
            c = _privatesub(b, a);
        else
            c = _privatesub(a, b);
        c->minus = 1;
    }
    return c;
}

/**
 * @brief ���{���������m�̂����Z(a*b)
 *
 * @return Tabaicho* a*b
 */
Tabaicho *mul(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    for (int i = b->len - 1; i >= 0; i--)
    {                              //��������擪�܂�
        Tabaicho *a_bi = mkList(); // a*b[i]
        int b_keta = numAt(b, i);  // b[i]
        int carry = 0;             //�L�����[
        for (int j = b->len - 1; j >= 0; j--)
        {                                           // b�̌����Ƃɂ����Z���s��
            int tmp = numAt(a, j) * b_keta + carry; // tmp=a[j]*b[i]+carry
            carry = tmp / 10;
            tmp = tmp % 10;
            addAt(a_bi, tmp, 1);
        }
        for (int j = b->len - 1; j > i; j--)
            add(a_bi, 0); // a*b[i]��K�؂Ȍ����ɂ���
        c = sum(c, a_bi); // c��a*b[i]�𑫂�
        delList(a_bi);
    }
    if (a->minus == !b->minus)
        c->minus = 1; //�����ݒ�
    return c;
}

/**
 * @brief ���{���������m�̊���Z(a/b)
 *
 * @return Tabaicho* a/b
 */
Tabaicho *divi(Tabaicho *a, Tabaicho *b)
{
    Tabaicho *c = mkList();
    Tabaicho *rem = mkList(); // �]��
    for (int i = 0; i < a->len; i++)
    {                                  // �擪���疖���܂�
        Tabaicho *keta_sum = mkList(); // b�̘a
        add(rem, 0);                   // �]���*10
        for (int j = 0; j < 10; j++)
        {                             // ����Z
            Tabaicho *a_i = mkList(); // =a[i]
            add(a_i, numAt(a, i));
            keta_sum = sum(keta_sum, b); // keta_sum+=b
            if (cmp(sum(rem, a_i), keta_sum) == -1)
            {                                               // b�𑫂��Ă����āA(rem*a[i])�𒴂�����
                add(c, j);                                  // c�̖�����(rem*a[i])/b(�܂�A�J��Ԃ��̉�-1�ł���j)��ǉ�
                rem = sub(sum(rem, a_i), sub(keta_sum, b)); // �]��Ƃ��āA(rem*a[i])%b(�܂�Arem*a[i]-(b*j))��ǉ�
                break;
            }
        }
    }
    if (a->minus == !b->minus)
        c->minus = 1; //�����ݒ�
    return c;
}

#endif // INCLUDE_NEW_TABAICHO
