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
    char t12[16];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    int t5;
    char *t6;
    char *t7;
    int t8;
    char *t9;
    char *t10;
    int t11;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned char t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t26;

LAB0:    t1 = (t0 + 3432U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 1672U);
    t3 = *((char **)t2);
    t2 = (t0 + 6728);
    t5 = xsi_mem_cmp(t2, t3, 2U);
    if (t5 == 1)
        goto LAB5;

LAB9:    t6 = (t0 + 6730);
    t8 = xsi_mem_cmp(t6, t3, 2U);
    if (t8 == 1)
        goto LAB6;

LAB10:    t9 = (t0 + 6732);
    t11 = xsi_mem_cmp(t9, t3, 2U);
    if (t11 == 1)
        goto LAB7;

LAB11:
LAB8:    xsi_set_current_line(27, ng0);
    t2 = xsi_get_transient_memory(8U);
    memset(t2, 0, 8U);
    t3 = t2;
    memset(t3, (unsigned char)1, 8U);
    t4 = (t0 + 4360);
    t6 = (t4 + 56U);
    t7 = *((char **)t6);
    t9 = (t7 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t2, 8U);
    xsi_driver_first_trans_fast(t4);

LAB4:    xsi_set_current_line(26, ng0);

LAB21:    t2 = (t0 + 4248);
    *((int *)t2) = 1;
    *((char **)t1) = &&LAB22;

LAB1:    return;
LAB5:    xsi_set_current_line(27, ng0);
    t13 = (t0 + 1032U);
    t14 = *((char **)t13);
    t13 = (t0 + 6608U);
    t15 = (t0 + 1192U);
    t16 = *((char **)t15);
    t15 = (t0 + 6624U);
    t17 = ieee_p_2592010699_sub_795620321_503743352(IEEE_P_2592010699, t12, t14, t13, t16, t15);
    t18 = (t12 + 12U);
    t19 = *((unsigned int *)t18);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB13;

LAB14:    t22 = (t0 + 4360);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    t25 = (t24 + 56U);
    t26 = *((char **)t25);
    memcpy(t26, t17, 8U);
    xsi_driver_first_trans_fast(t22);
    goto LAB4;

LAB6:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 6608U);
    t4 = (t0 + 1192U);
    t6 = *((char **)t4);
    t4 = (t0 + 6624U);
    t7 = ieee_p_2592010699_sub_1735675855_503743352(IEEE_P_2592010699, t12, t3, t2, t6, t4);
    t9 = (t12 + 12U);
    t19 = *((unsigned int *)t9);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB15;

LAB16:    t10 = (t0 + 4360);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t7, 8U);
    xsi_driver_first_trans_fast(t10);
    goto LAB4;

LAB7:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t2 = (t0 + 6608U);
    t4 = (t0 + 1192U);
    t6 = *((char **)t4);
    t4 = (t0 + 6624U);
    t7 = ieee_p_2592010699_sub_1697423399_503743352(IEEE_P_2592010699, t12, t3, t2, t6, t4);
    t9 = (t12 + 12U);
    t19 = *((unsigned int *)t9);
    t20 = (1U * t19);
    t21 = (8U != t20);
    if (t21 == 1)
        goto LAB17;

LAB18:    t10 = (t0 + 4360);
    t13 = (t10 + 56U);
    t14 = *((char **)t13);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t7, 8U);
    xsi_driver_first_trans_fast(t10);
    goto LAB4;

LAB12:;
LAB13:    xsi_size_not_matching(8U, t20, 0);
    goto LAB14;

LAB15:    xsi_size_not_matching(8U, t20, 0);
    goto LAB16;

LAB17:    xsi_size_not_matching(8U, t20, 0);
    goto LAB18;

LAB19:    t3 = (t0 + 4248);
    *((int *)t3) = 0;
    goto LAB2;

LAB20:    goto LAB19;

LAB22:    goto LAB20;

}

static void work_a_0115648051_2372691052_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(31, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 4424);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 8U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4264);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0115648051_2372691052_p_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    int t8;
    int t9;
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

LAB0:    xsi_set_current_line(36, ng0);
    t1 = (t0 + 4488);
    t2 = (t1 + 56U);
    t3 = *((char **)t2);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    *((unsigned char *)t5) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(37, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t7 = (t6 == (unsigned char)2);
    if (t7 != 0)
        goto LAB2;

LAB4:
LAB3:    xsi_set_current_line(43, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t6 = *((unsigned char *)t2);
    t1 = (t0 + 4552);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t11 = *((char **)t5);
    *((unsigned char *)t11) = t6;
    xsi_driver_first_trans_fast_port(t1);
    t1 = (t0 + 4280);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(38, ng0);
    t1 = (t0 + 6734);
    *((int *)t1) = 7;
    t3 = (t0 + 6738);
    *((int *)t3) = 0;
    t8 = 7;
    t9 = 0;

LAB5:    if (t8 >= t9)
        goto LAB6;

LAB8:    goto LAB3;

LAB6:    xsi_set_current_line(39, ng0);
    t4 = (t0 + 2152U);
    t5 = *((char **)t4);
    t10 = *((unsigned char *)t5);
    t4 = (t0 + 1992U);
    t11 = *((char **)t4);
    t4 = (t0 + 6734);
    t12 = *((int *)t4);
    t13 = (t12 - 7);
    t14 = (t13 * -1);
    t15 = (1U * t14);
    t16 = (0 + t15);
    t17 = (t11 + t16);
    t18 = *((unsigned char *)t17);
    t19 = ieee_p_2592010699_sub_2507238156_503743352(IEEE_P_2592010699, t10, t18);
    t20 = (t0 + 4488);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    *((unsigned char *)t24) = t19;
    xsi_driver_first_trans_fast(t20);

LAB7:    t1 = (t0 + 6734);
    t8 = *((int *)t1);
    t2 = (t0 + 6738);
    t9 = *((int *)t2);
    if (t8 == t9)
        goto LAB8;

LAB9:    t12 = (t8 + -1);
    t8 = t12;
    t3 = (t0 + 6734);
    *((int *)t3) = t8;
    goto LAB5;

}


extern void work_a_0115648051_2372691052_init()
{
	static char *pe[] = {(void *)work_a_0115648051_2372691052_p_0,(void *)work_a_0115648051_2372691052_p_1,(void *)work_a_0115648051_2372691052_p_2};
	xsi_register_didat("work_a_0115648051_2372691052", "isim/tb_calculation_unit_isim_beh.exe.sim/work/a_0115648051_2372691052.didat");
	xsi_register_executes(pe);
}
