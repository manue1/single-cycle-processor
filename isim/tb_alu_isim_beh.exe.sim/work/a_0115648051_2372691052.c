/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0xa0883be4 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//VBOXSVR/Github/picoblaze-processor/logic-unit.vhd";
extern char *IEEE_P_2592010699;

char *ieee_p_2592010699_sub_1697423399_503743352(char *, char *, char *, char *, char *, char *);
char *ieee_p_2592010699_sub_1735675855_503743352(char *, char *, char *, char *, char *, char *);
unsigned char ieee_p_2592010699_sub_2507238156_503743352(char *, unsigned char , unsigned char );
char *ieee_p_2592010699_sub_795620321_503743352(char *, char *, char *, char *, char *, char *);


static void work_a_0115648051_2372691052_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    int t7;
    unsigned char t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    int t12;
    int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    char *t17;
    unsigned char t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(30, ng0);
    t1 = (t0 + 4624);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(31, ng0);
    t1 = (t0 + 7056);
    *((int *)t1) = 7;
    t2 = (t0 + 7060);
    *((int *)t2) = 0;
    t6 = 7;
    t7 = 0;

LAB2:    if (t6 >= t7)
        goto LAB3;

LAB5:    t1 = (t0 + 4496);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(32, ng0);
    t3 = (t0 + 1832U);
    t4 = *((char **)t3);
    t8 = *((unsigned char *)t4);
    t9 = (t8 == (unsigned char)2);
    if (t9 != 0)
        goto LAB6;

LAB8:
LAB7:
LAB4:    t1 = (t0 + 7056);
    t6 = *((int *)t1);
    t2 = (t0 + 7060);
    t7 = *((int *)t2);
    if (t6 == t7)
        goto LAB5;

LAB9:    t12 = (t6 + -1);
    t6 = t12;
    t3 = (t0 + 7056);
    *((int *)t3) = t6;
    goto LAB2;

LAB6:    xsi_set_current_line(33, ng0);
    t3 = (t0 + 2152U);
    t5 = *((char **)t3);
    t10 = *((unsigned char *)t5);
    t3 = (t0 + 1992U);
    t11 = *((char **)t3);
    t3 = (t0 + 7056);
    t12 = *((int *)t3);
    t13 = (t12 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t17 = (t11 + t16);
    t18 = *((unsigned char *)t17);
    t19 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t10, t18);
    t20 = (t0 + 4624);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    *((unsigned char *)t24) = t19;
    xsi_driver_first_trans_fast(t20);
    goto LAB7;

}

static void work_a_0115648051_2372691052_p_1(char *t0)
{
    char t8[16];
    char *t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned int t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    unsigned int t15;
    unsigned int t16;
    unsigned char t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    char *t22;

LAB0:    xsi_set_current_line(41, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 7064);
    t4 = 1;
    if (2U == 2U)
        goto LAB5;

LAB6:    t4 = 0;

LAB7:    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 7066);
    t4 = 1;
    if (2U == 2U)
        goto LAB15;

LAB16:    t4 = 0;

LAB17:    if (t4 != 0)
        goto LAB13;

LAB14:    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 7068);
    t4 = 1;
    if (2U == 2U)
        goto LAB25;

LAB26:    t4 = 0;

LAB27:    if (t4 != 0)
        goto LAB23;

LAB24:    xsi_set_current_line(47, ng0);
    t1 = (t0 + 7070);
    t3 = (t0 + 4688);
    t6 = (t3 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 8U);
    xsi_driver_first_trans_fast(t3);

LAB3:    t1 = (t0 + 4512);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(42, ng0);
    t9 = (t0 + 1032U);
    t10 = *((char **)t9);
    t9 = (t0 + 6936U);
    t11 = (t0 + 1192U);
    t12 = *((char **)t11);
    t11 = (t0 + 6952U);
    t13 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t8, t10, t9, t12, t11);
    t14 = (t8 + 12U);
    t15 = *((unsigned int *)t14);
    t16 = (1U * t15);
    t17 = (8U != t16);
    if (t17 == 1)
        goto LAB11;

LAB12:    t18 = (t0 + 4688);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t13, 8U);
    xsi_driver_first_trans_fast(t18);
    goto LAB3;

LAB5:    t5 = 0;

LAB8:    if (t5 < 2U)
        goto LAB9;
    else
        goto LAB7;

LAB9:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB6;

LAB10:    t5 = (t5 + 1);
    goto LAB8;

LAB11:    xsi_size_not_matching(8U, t16, 0);
    goto LAB12;

LAB13:    xsi_set_current_line(44, ng0);
    t9 = (t0 + 1032U);
    t10 = *((char **)t9);
    t9 = (t0 + 6936U);
    t11 = (t0 + 1192U);
    t12 = *((char **)t11);
    t11 = (t0 + 6952U);
    t13 = ieee_p_2592010699_sub_1735675855_503743352(IEEE_P_2592010699, t8, t10, t9, t12, t11);
    t14 = (t8 + 12U);
    t15 = *((unsigned int *)t14);
    t16 = (1U * t15);
    t17 = (8U != t16);
    if (t17 == 1)
        goto LAB21;

LAB22:    t18 = (t0 + 4688);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t13, 8U);
    xsi_driver_first_trans_fast(t18);
    goto LAB3;

LAB15:    t5 = 0;

LAB18:    if (t5 < 2U)
        goto LAB19;
    else
        goto LAB17;

LAB19:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB16;

LAB20:    t5 = (t5 + 1);
    goto LAB18;

LAB21:    xsi_size_not_matching(8U, t16, 0);
    goto LAB22;

LAB23:    xsi_set_current_line(46, ng0);
    t9 = (t0 + 1032U);
    t10 = *((char **)t9);
    t9 = (t0 + 6936U);
    t11 = (t0 + 1192U);
    t12 = *((char **)t11);
    t11 = (t0 + 6952U);
    t13 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t8, t10, t9, t12, t11);
    t14 = (t8 + 12U);
    t15 = *((unsigned int *)t14);
    t16 = (1U * t15);
    t17 = (8U != t16);
    if (t17 == 1)
        goto LAB31;

LAB32:    t18 = (t0 + 4688);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t13, 8U);
    xsi_driver_first_trans_fast(t18);
    goto LAB3;

LAB25:    t5 = 0;

LAB28:    if (t5 < 2U)
        goto LAB29;
    else
        goto LAB27;

LAB29:    t6 = (t2 + t5);
    t7 = (t1 + t5);
    if (*((unsigned char *)t6) != *((unsigned char *)t7))
        goto LAB26;

LAB30:    t5 = (t5 + 1);
    goto LAB28;

LAB31:    xsi_size_not_matching(8U, t16, 0);
    goto LAB32;

}

static void work_a_0115648051_2372691052_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(51, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 4752);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4528);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0115648051_2372691052_p_3(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(52, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 4816);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 4544);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_0115648051_2372691052_init()
{
	static char *pe[] = {(void *)work_a_0115648051_2372691052_p_0,(void *)work_a_0115648051_2372691052_p_1,(void *)work_a_0115648051_2372691052_p_2,(void *)work_a_0115648051_2372691052_p_3};
	xsi_register_didat("work_a_0115648051_2372691052", "isim/tb_alu_isim_beh.exe.sim/work/a_0115648051_2372691052.didat");
	xsi_register_executes(pe);
}
